import 'package:abould_ada/core/localization/l10n_extensions.dart';
import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:abould_ada/modules/supabase/di/supabase_crud_providers.dart';
import 'package:abould_ada/modules/supabase/models/supabase_task_model.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_card.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_text_field.dart';
import 'package:abould_ada/modules/ui_components/widgets/empty_view.dart';
import 'package:abould_ada/modules/ui_components/widgets/feedback/ada_dialogs.dart';
import 'package:abould_ada/modules/ui_components/widgets/feedback/ada_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SupabaseTasksPanel extends ConsumerStatefulWidget {
  const SupabaseTasksPanel({super.key, required this.userId});

  final String userId;

  @override
  ConsumerState<SupabaseTasksPanel> createState() => _SupabaseTasksPanelState();
}

class _SupabaseTasksPanelState extends ConsumerState<SupabaseTasksPanel> {
  final _controller = TextEditingController();
  bool _adding = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _addTask() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() => _adding = true);
    try {
      await ref.read(supabaseTasksRepositoryProvider).create(
            userId: widget.userId,
            title: text,
          );
      _controller.clear();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.todoAddFailed(e.toString()))),
        );
      }
    } finally {
      if (mounted) setState(() => _adding = false);
    }
  }

  Future<bool> _confirmDelete(SupabaseTaskModel task) {
    return AdaDialogs.confirm(
      context,
      title: context.l10n.todoDeleteTitle,
      message: context.l10n.todoDeleteMessage(task.title),
      confirmLabel: context.l10n.todoDeleteConfirm,
      cancelLabel: context.l10n.todoDeleteCancel,
      destructive: true,
    );
  }

  Future<void> _editTask(SupabaseTaskModel task) async {
    final controller = TextEditingController(text: task.title);
    final saved = await AdaDialogs.editForm(
      context,
      title: context.l10n.todoEditTitle,
      message: context.l10n.todoEditMessage,
      form: AdaTextField(
        controller: controller,
        label: context.l10n.todoNameLabel,
        textInputAction: TextInputAction.done,
      ),
    );
    final next = controller.text.trim();
    controller.dispose();
    if (saved != true || next.isEmpty || next == task.title) return;
    try {
      await ref.read(supabaseTasksRepositoryProvider).updateTitle(
            task: task,
            title: next,
          );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.todoUpdateFailed(e.toString()))),
        );
      }
    }
  }

  Future<void> _deleteTask(SupabaseTaskModel task) async {
    final ok = await _confirmDelete(task);
    if (!ok) return;
    try {
      await ref.read(supabaseTasksRepositoryProvider).remove(task);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.todoDeleteFailed(e.toString()))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(supabaseTasksStreamProvider);
    final repo = ref.read(supabaseTasksRepositoryProvider);
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AdaCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: AdaTextField(
                  controller: _controller,
                  label: context.l10n.newTodoLabel,
                  hint: 'Task title',
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _addTask(),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              FilledButton(
                onPressed: _adding ? null : _addTask,
                child: _adding
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.add_rounded),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        tasksAsync.when(
          loading: () => Column(
            children: List.generate(
              3,
              (_) => const Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.sm),
                child: AdaShimmer(height: 72, borderRadius: 12),
              ),
            ),
          ),
          error: (e, _) => AdaCard(
            child: Text(
              'Realtime error: $e\n\nRun supabase/migrations SQL and enable Realtime.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          data: (items) {
            if (items.isEmpty) {
              return AdaCard(
                child: EmptyView(
                  icon: Icons.task_alt_rounded,
                  title: context.l10n.todoEmptyTitle,
                  message: context.l10n.todoEmptyMessage,
                ),
              );
            }
            return Column(
              children: items.map((task) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: AdaCard(
                    padding: EdgeInsets.zero,
                    onTap: () => _editTask(task),
                    child: ListTile(
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (_) => repo.toggleCompleted(task),
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit_outlined),
                            tooltip: 'Edit',
                            onPressed: () => _editTask(task),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete_outline, color: scheme.error),
                            tooltip: 'Delete todo',
                            onPressed: () => _deleteTask(task),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
