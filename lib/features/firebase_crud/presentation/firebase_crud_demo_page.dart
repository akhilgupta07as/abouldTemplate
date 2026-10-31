import 'package:abould_ada/core/localization/l10n_extensions.dart';
import 'package:abould_ada/core/routing/route_names.dart';
import 'package:abould_ada/core/services/locale_controller.dart';
import 'package:abould_ada/core/theme/app_colors.dart';
import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:abould_ada/modules/authentication/presentation/providers/auth_providers.dart';
import 'package:abould_ada/modules/firebase/di/firebase_crud_providers.dart';
import 'package:abould_ada/modules/firebase/models/todo_model.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_card.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_loading_button.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_text_field.dart';
import 'package:abould_ada/modules/ui_components/widgets/empty_view.dart';
import 'package:abould_ada/modules/ui_components/widgets/feedback/ada_dialogs.dart';
import 'package:abould_ada/modules/ui_components/widgets/feedback/ada_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FirebaseCrudDemoPage extends ConsumerStatefulWidget {
  const FirebaseCrudDemoPage({super.key});

  @override
  ConsumerState<FirebaseCrudDemoPage> createState() =>
      _FirebaseCrudDemoPageState();
}

class _FirebaseCrudDemoPageState extends ConsumerState<FirebaseCrudDemoPage> {
  final _todoController = TextEditingController();
  bool _adding = false;

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  Future<void> _addTodo(String userref) async {
    final name = _todoController.text.trim();
    if (name.isEmpty) return;
    final lang = ref.read(localeControllerProvider).languageCode;
    setState(() => _adding = true);
    try {
      await ref.read(firebaseTodosRepositoryProvider).create(
            userref: userref,
            text: name,
            sourceLanguageCode: lang,
          );
      _todoController.clear();
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

  Future<bool> _confirmDeleteTodo(TodoModel todo, String displayName) {
    return AdaDialogs.confirm(
      context,
      title: context.l10n.todoDeleteTitle,
      message: context.l10n.todoDeleteMessage(displayName),
      confirmLabel: context.l10n.todoDeleteConfirm,
      cancelLabel: context.l10n.todoDeleteCancel,
      destructive: true,
    );
  }

  Future<void> _removeTodo(TodoModel todo) async {
    try {
      await ref.read(firebaseTodosRepositoryProvider).remove(todo.id);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.todoDeleteFailed(e.toString()))),
        );
      }
    }
  }

  Future<void> _editTodo(String userref, TodoModel todo) async {
    final lang = ref.read(localeControllerProvider).languageCode;
    final current = todo.localizedTitle(lang);
    final controller = TextEditingController(text: current);
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
    if (saved != true) return;
    if (next.isEmpty || next == current) return;
    try {
      await ref.read(firebaseTodosRepositoryProvider).edit(
            todo: todo,
            text: next,
            sourceLanguageCode: lang,
          );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.todoUpdateFailed(e.toString()))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final enabled = ref.watch(firebaseCrudEnabledProvider);
    if (!enabled) {
      return Scaffold(
        appBar: AppBar(title: Text(context.l10n.todosTitle)),
        body: Container(
          decoration: BoxDecoration(
            gradient: AppColors.subtleGradient(context),
          ),
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: AdaCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Todos use collection `todo` in Firestore',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Sign in with Firebase. Each document has: userref, english, '
                  'hindi, todoname (legacy), iscompleted, createdAt.',
                ),
                const SizedBox(height: AppSpacing.md),
                AdaLoadingButton(
                  label: 'Go to login',
                  onPressed: () => context.go(RouteNames.login),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final userref = ref.watch(currentAuthUserProvider)!.id;
    final todosAsync = ref.watch(firebaseTodosStreamProvider);
    final repo = ref.read(firebaseTodosRepositoryProvider);
    final lang = ref.watch(localeControllerProvider).languageCode;
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.todosTitle)),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.subtleGradient(context),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: AdaCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: AdaTextField(
                        controller: _todoController,
                        label: context.l10n.newTodoLabel,
                        hint: context.l10n.newTodoHint,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _addTodo(userref),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    FilledButton(
                      onPressed: _adding ? null : () => _addTodo(userref),
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
            ),
            Expanded(
              child: todosAsync.when(
                loading: () => ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: 5,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: AdaShimmer(height: 72, borderRadius: 12),
                  ),
                ),
                error: (e, _) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Text(
                      'Firestore error: $e\n\nPublish rules for collection '
                      '`todo` and create index userref + createdAt if prompted.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                data: (items) {
                  if (items.isEmpty) {
                    return EmptyView(
                      icon: Icons.task_alt_rounded,
                      title: context.l10n.todoEmptyTitle,
                      message: context.l10n.todoEmptyMessage,
                    );
                  }
                  final active = items.where((t) => !t.iscompleted).toList();
                  final done = items.where((t) => t.iscompleted).toList();

                  return ListView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      0,
                      AppSpacing.lg,
                      AppSpacing.xxl,
                    ),
                    children: [
                      if (active.isNotEmpty) ...[
                        _SectionHeader(context.l10n.todoActiveSection, active.length),
                        ...active.map(
                          (t) => _TodoTile(
                            todo: t,
                            languageCode: lang,
                            onToggle: () => repo.toggleCompleted(t),
                            onEdit: () => _editTodo(userref, t),
                            onConfirmDelete: () => _confirmDeleteTodo(
                              t,
                              t.localizedTitle(lang),
                            ),
                            onDelete: () => _removeTodo(t),
                          ),
                        ),
                      ],
                      if (done.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.md),
                        _SectionHeader(context.l10n.todoDoneSection, done.length),
                        ...done.map(
                          (t) => _TodoTile(
                            todo: t,
                            languageCode: lang,
                            onToggle: () => repo.toggleCompleted(t),
                            onEdit: () => _editTodo(userref, t),
                            onConfirmDelete: () => _confirmDeleteTodo(
                              t,
                              t.localizedTitle(lang),
                            ),
                            onDelete: () => _removeTodo(t),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.label, this.count);

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm, top: AppSpacing.sm),
      child: Text(
        '$label ($count)',
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _TodoTile extends StatelessWidget {
  const _TodoTile({
    required this.todo,
    required this.languageCode,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
    required this.onConfirmDelete,
  });

  final TodoModel todo;
  final String languageCode;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Future<bool> Function() onConfirmDelete;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Dismissible(
        key: ValueKey(todo.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: AppSpacing.lg),
          decoration: BoxDecoration(
            color: scheme.errorContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.delete_outline, color: scheme.onErrorContainer),
        ),
        confirmDismiss: (_) => onConfirmDelete(),
        onDismissed: (_) => onDelete(),
        child: AdaCard(
          onTap: onEdit,
          padding: EdgeInsets.zero,
          child: ListTile(
            leading: Checkbox(
              value: todo.iscompleted,
              onChanged: (_) => onToggle(),
            ),
            title: Text(
              todo.localizedTitle(languageCode),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                decoration:
                    todo.iscompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(
              'createdAt · ${todo.createdAt.toLocal()}'.split('.').first,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  tooltip: 'Edit',
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline, color: scheme.error),
                  tooltip: 'Delete',
                  onPressed: () async {
                    if (await onConfirmDelete()) onDelete();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
