import 'package:abould_ada/core/di/providers.dart';
import 'package:abould_ada/core/theme/app_colors.dart';
import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:abould_ada/modules/api_integration/data/users_repository.dart';
import 'package:abould_ada/modules/api_integration/di/api_providers.dart';
import 'package:abould_ada/modules/api_integration/models/user_model.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_card.dart';
import 'package:abould_ada/modules/ui_components/widgets/empty_view.dart';
import 'package:abould_ada/modules/ui_components/widgets/feedback/ada_dialogs.dart';
import 'package:abould_ada/modules/ui_components/widgets/feedback/ada_shimmer.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiHttpDemoPage extends ConsumerStatefulWidget {
  const ApiHttpDemoPage({super.key});

  @override
  ConsumerState<ApiHttpDemoPage> createState() => _ApiHttpDemoPageState();
}

class _ApiHttpDemoPageState extends ConsumerState<ApiHttpDemoPage> {
  final _firstNameController = TextEditingController(text: 'Ada');
  final _lastNameController = TextEditingController(text: 'Developer');

  List<UserModel> _users = [];
  String? _error;
  bool _loadingList = false;
  bool _adding = false;
  int? _busyUserId;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  UsersRepository get _repo => ref.read(usersRepositoryProvider);

  Future<void> _loadUsers() async {
    setState(() {
      _loadingList = true;
      _error = null;
    });
    try {
      final page = await _repo.listUsers(limit: 20, skip: 0);
      setState(() => _users = page.items);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loadingList = false);
    }
  }

  Future<void> _addUser() async {
    final first = _firstNameController.text.trim();
    final last = _lastNameController.text.trim();
    if (first.isEmpty || last.isEmpty) {
      _showSnack('Enter first and last name.');
      return;
    }
    setState(() => _adding = true);
    try {
      final created = await _repo.createUser(
        firstName: first,
        lastName: last,
        age: 28,
      );
      setState(() => _users = [created, ..._users]);
      _firstNameController.clear();
      _lastNameController.clear();
      _showSnack('User added (POST /users/add) · id ${created.id}');
    } catch (e) {
      _showSnack('Add failed: $e', isError: true);
    } finally {
      if (mounted) setState(() => _adding = false);
    }
  }

  Future<void> _editUser(UserModel user) async {
    final firstCtrl = TextEditingController(text: user.firstName);
    final lastCtrl = TextEditingController(text: user.lastName);
    final saved = await AdaDialogs.editForm(
      context,
      title: 'Edit user',
      message: 'Changes are sent with PATCH /users/${user.id}.',
      form: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AdaTextField(
            controller: firstCtrl,
            label: 'First name',
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppSpacing.sm),
          AdaTextField(
            controller: lastCtrl,
            label: 'Last name',
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
    firstCtrl.dispose();
    lastCtrl.dispose();
    if (saved != true) return;

    setState(() => _busyUserId = user.id);
    try {
      final updated = await _repo.updateUser(
        id: user.id,
        body: {
          'firstName': firstCtrl.text.trim(),
          'lastName': lastCtrl.text.trim(),
        },
      );
      setState(() {
        _users = _users
            .map((u) => u.id == user.id ? updated : u)
            .toList(growable: false);
      });
      _showSnack('Updated (PATCH /users/${user.id})');
    } catch (e) {
      _showSnack('Edit failed: $e', isError: true);
    } finally {
      if (mounted) setState(() => _busyUserId = null);
    }
  }

  Future<void> _deleteUser(UserModel user) async {
    final ok = await AdaDialogs.confirm(
      context,
      title: 'Delete user?',
      message:
          'This removes ${user.fullName} from your list. DummyJSON simulates DELETE and does not persist on the server.',
      confirmLabel: 'Delete user',
      cancelLabel: 'Keep user',
      destructive: true,
    );
    if (!ok) return;

    setState(() => _busyUserId = user.id);
    try {
      await _repo.removeUser(user.id);
      setState(() {
        _users = _users.where((u) => u.id != user.id).toList(growable: false);
      });
      _showSnack('Deleted user ${user.id}');
    } catch (e) {
      _showSnack('Delete failed: $e', isError: true);
    } finally {
      if (mounted) setState(() => _busyUserId = null);
    }
  }

  void _showSnack(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Theme.of(context).colorScheme.error : null,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadUsers());
  }

  @override
  Widget build(BuildContext context) {
    final baseUrl = ref.watch(appConfigProvider).apiBaseUrl;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DummyJSON Users'),
        actions: [
          IconButton(
            tooltip: 'Refresh (GET)',
            onPressed: _loadingList ? null : _loadUsers,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.subtleGradient(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: AdaCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'POST',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 11,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Add user',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AdaTextField(
                            controller: _firstNameController,
                            label: 'First name',
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: AdaTextField(
                            controller: _lastNameController,
                            label: 'Last name',
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _addUser(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    FilledButton.icon(
                      onPressed: _adding ? null : _addUser,
                      icon: _adding
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.person_add_alt_1_rounded),
                      label: const Text('Add user'),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'GET',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                        color: AppColors.success,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '$baseUrl/users',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Text(
                  _error!,
                  style: TextStyle(color: scheme.error),
                ),
              ),
            Expanded(child: _buildUserList(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList(BuildContext context) {
    if (_loadingList && _users.isEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: 6,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: AdaShimmer(height: 72, borderRadius: 12),
        ),
      );
    }
    if (_users.isEmpty) {
      return const EmptyView(message: 'No users loaded.');
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.xxl,
      ),
      itemCount: _users.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        final user = _users[index];
        final busy = _busyUserId == user.id;

        return AdaCard(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                user.firstName.isNotEmpty
                    ? user.firstName[0].toUpperCase()
                    : '?',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            title: Text(
              user.fullName,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text('@${user.username} · id ${user.id}'),
            trailing: busy
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: 'Edit (PATCH)',
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: () => _editUser(user),
                      ),
                      IconButton(
                        tooltip: 'Delete (DELETE)',
                        icon: Icon(
                          Icons.delete_outline,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        onPressed: () => _deleteUser(user),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
