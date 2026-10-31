import 'package:abould_ada/core/di/providers.dart';
import 'package:abould_ada/core/localization/l10n_extensions.dart';
import 'package:abould_ada/core/services/theme_mode_controller.dart';
import 'package:abould_ada/core/theme/app_colors.dart';
import 'package:abould_ada/core/theme/app_radius.dart';
import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:abould_ada/features/ui_showcase/presentation/widgets/ui_showcase_section.dart';
import 'package:abould_ada/modules/ui_components/ui_components.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class UiShowcasePage extends ConsumerStatefulWidget {
  const UiShowcasePage({super.key});

  @override
  ConsumerState<UiShowcasePage> createState() => _UiShowcasePageState();
}

class _UiShowcasePageState extends ConsumerState<UiShowcasePage>
    with SingleTickerProviderStateMixin {
  final _text = TextEditingController(text: 'Standard text');
  final _password = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _search = TextEditingController();
  final _notes = TextEditingController();
  final _number = TextEditingController(text: '42');

  bool _switchValue = true;
  bool _checkValue = false;
  String? _dropdownValue = 'flutter';
  String? _searchableValue = 'ada';
  String _radioValue = 'a';
  DateTime? _date;
  TimeOfDay? _time;
  double _rating = 4;
  double _progress = 0.65;
  bool _btnLoading = false;

  XFile? _pickedImage;
  final List<XFile> _gallery = [];
  PlatformFile? _pickedFile;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _text.dispose();
    _password.dispose();
    _email.dispose();
    _phone.dispose();
    _search.dispose();
    _notes.dispose();
    _number.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _openNavigationDemo() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => AdaNavigationDemoShell(
          body: Center(
            child: Text(
              'Drawer · tabs · bottom nav',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final online = ref.watch(isOnlineProvider);
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.uiLibraryTitle),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.subtleGradient(context),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.lg,
                  AppSpacing.lg,
                ),
                  child: _LibraryHero(
                    themeMode: themeMode,
                    onThemeChanged: (mode) =>
                        ref.read(themeModeProvider.notifier).setThemeMode(mode),
                    onlineChip: online.when(
                      data: (connected) => AdaStatusChip(
                        label: connected ? context.l10n.online : context.l10n.offline,
                        icon: connected ? Icons.wifi : Icons.wifi_off,
                        color: connected ? AppColors.success : AppColors.error,
                      ),
                      loading: () => const AdaShimmer(height: 32, width: 88),
                      error: (error, stackTrace) =>
                          AdaStatusChip(label: context.l10n.offline),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    UiShowcaseSection(
                      icon: Icons.smart_button_outlined,
                      title: context.l10n.showcaseButtons,
                      subtitle: context.l10n.showcaseButtonsSub,
                      child: UiShowcasePreviewTray(
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: WrapAlignment.start,
                          children: [
                            AdaPrimaryButton(
                              label: 'Primary',
                              onPressed: () {},
                              expand: false,
                            ),
                            AdaSecondaryButton(
                              label: 'Secondary',
                              onPressed: () {},
                            ),
                            AdaOutlinedButton(
                              label: 'Outlined',
                              onPressed: () {},
                            ),
                            AdaTextButton(label: 'Text', onPressed: () {}),
                            AdaIconButton(
                              icon: Icons.favorite_border,
                              onPressed: () {},
                            ),
                            AdaPrimaryButton(
                              label: 'Disabled',
                              onPressed: null,
                              expand: false,
                            ),
                            AdaLoadingButton(
                              label: 'Loading',
                              isLoading: _btnLoading,
                              onPressed: () async {
                                setState(() => _btnLoading = true);
                                await Future<void>.delayed(
                                  const Duration(seconds: 1),
                                );
                                if (mounted) {
                                  setState(() => _btnLoading = false);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    UiShowcaseSection(
                      icon: Icons.edit_note_outlined,
                      title: context.l10n.showcaseInputs,
                      subtitle: context.l10n.showcaseInputsSub,
                      child: Column(
                        children: [
                          AdaTextField(
                            controller: _text,
                            label: 'Standard text field',
                            hint: 'Enter text',
                          ),
                          const SizedBox(height: 12),
                          AdaPasswordField(
                            controller: _password,
                            label: 'Password field',
                          ),
                          const SizedBox(height: 12),
                          AdaEmailField(controller: _email),
                          const SizedBox(height: 12),
                          AdaPhoneField(controller: _phone),
                          const SizedBox(height: 12),
                          AdaSearchField(controller: _search),
                          const SizedBox(height: 12),
                          AdaMultilineField(controller: _notes),
                          const SizedBox(height: 12),
                          AdaNumberField(controller: _number),
                          const SizedBox(height: 12),
                          AdaDateField(
                            label: 'Date picker',
                            value: _date,
                            onChanged: (d) => setState(() => _date = d),
                          ),
                          const SizedBox(height: 12),
                          AdaTimeField(
                            label: 'Time picker',
                            value: _time,
                            onChanged: (t) => setState(() => _time = t),
                          ),
                          const SizedBox(height: 12),
                          AdaDropdownField<String>(
                            label: 'Dropdown',
                            value: _dropdownValue,
                            items: const [
                              DropdownMenuItem(value: 'flutter', child: Text('Flutter')),
                              DropdownMenuItem(value: 'dart', child: Text('Dart')),
                            ],
                            onChanged: (v) => setState(() => _dropdownValue = v),
                          ),
                          const SizedBox(height: 12),
                          AdaSearchableDropdownField<String>(
                            label: 'Searchable dropdown',
                            value: _searchableValue,
                            options: const [
                              AdaSearchableDropdownOption(
                                value: 'ada',
                                label: 'Abould ADA',
                              ),
                              AdaSearchableDropdownOption(
                                value: 'flutter',
                                label: 'Flutter SDK',
                              ),
                              AdaSearchableDropdownOption(
                                value: 'firebase',
                                label: 'Firebase',
                              ),
                              AdaSearchableDropdownOption(
                                value: 'supabase',
                                label: 'Supabase',
                              ),
                            ],
                            onChanged: (v) => setState(() => _searchableValue = v),
                          ),
                          AdaCheckboxField(
                            label: 'Checkbox',
                            value: _checkValue,
                            onChanged: (v) => setState(() => _checkValue = v ?? false),
                          ),
                          AdaRadioGroupField<String>(
                            label: 'Radio group',
                            value: _radioValue,
                            options: const [
                              AdaRadioOption(value: 'a', label: 'Option A'),
                              AdaRadioOption(value: 'b', label: 'Option B'),
                            ],
                            onChanged: (v) => setState(() => _radioValue = v),
                          ),
                          AdaSwitchField(
                            label: 'Switch',
                            value: _switchValue,
                            onChanged: (v) => setState(() => _switchValue = v),
                          ),
                        ],
                      ),
                    ),
                    UiShowcaseSection(
                      icon: Icons.explore_outlined,
                      title: context.l10n.showcaseNavigation,
                      subtitle: context.l10n.showcaseNavigationSub,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const AdaBreadcrumb(
                            segments: ['Home', 'Modules', 'UI Library'],
                          ),
                          const SizedBox(height: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(AppRadius.lg),
                            child: ColoredBox(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHighest
                                  .withValues(alpha: 0.35),
                              child: SizedBox(
                                height: 112,
                                child: Column(
                                  children: [
                                    AdaTabNavigation(
                                      tabs: const ['One', 'Two', 'Three'],
                                      controller: _tabController,
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        controller: _tabController,
                                        children: const [
                                          Center(child: Text('Tab 1')),
                                          Center(child: Text('Tab 2')),
                                          Center(child: Text('Tab 3')),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          AdaPrimaryButton(
                            label: 'Open full navigation demo',
                            icon: Icons.open_in_new_rounded,
                            expand: true,
                            onPressed: _openNavigationDemo,
                          ),
                        ],
                      ),
                    ),
                    UiShowcaseSection(
                      icon: Icons.dashboard_customize_outlined,
                      title: context.l10n.showcaseDisplay,
                      subtitle: context.l10n.showcaseDisplaySub,
                      child: Column(
                        children: [
                          AdaListTileCard(
                            title: 'List tile card',
                            subtitle: 'Tap-ready row inside AdaCard',
                            leading: const Icon(Icons.inbox_outlined),
                            onTap: () {},
                          ),
                          const SizedBox(height: 12),
                          AdaProfileCard(
                            name: 'Jane Developer',
                            subtitle: 'jane@company.com',
                            onEdit: () {},
                          ),
                          const SizedBox(height: 12),
                          AdaImageCard(
                            image: const NetworkImage(
                              'https://picsum.photos/seed/ada/600/320',
                            ),
                            title: 'Image card',
                            subtitle: 'Hero image + caption',
                            height: 120,
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: const [
                              AdaBadge(label: 'New', icon: Icons.fiber_new),
                              AdaBadge(label: 'Active', color: AppColors.success),
                              AdaStatusChip(label: 'Status chip'),
                            ],
                          ),
                          const SizedBox(height: 12),
                          AdaLinearProgress(
                            value: _progress,
                            label: 'Progress ${(_progress * 100).round()}%',
                          ),
                          Slider(
                            value: _progress,
                            onChanged: (v) => setState(() => _progress = v),
                          ),
                          const Center(
                            child: AdaCircularProgress(message: 'Loading…'),
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: AdaRatingBar(
                              value: _rating,
                              onChanged: (v) => setState(() => _rating = v),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AdaAvatar(name: 'ADA', radius: 24),
                              SizedBox(width: 16),
                              AdaAvatar(name: 'Dev', radius: 24),
                            ],
                          ),
                          const AdaSectionDivider(label: 'End of section'),
                        ],
                      ),
                    ),
                    UiShowcaseSection(
                      icon: Icons.chat_bubble_outline_rounded,
                      title: context.l10n.showcaseFeedback,
                      subtitle: context.l10n.showcaseFeedbackSub,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              AdaOutlinedButton(
                                label: 'Success',
                                onPressed: () => AdaDialogs.success(
                                  context,
                                  title: 'Saved',
                                  message: 'Your changes were saved.',
                                ),
                              ),
                              AdaOutlinedButton(
                                label: 'Error',
                                onPressed: () => AdaDialogs.error(
                                  context,
                                  title: 'Failed',
                                  message: 'Something went wrong.',
                                ),
                              ),
                              AdaOutlinedButton(
                                label: 'Confirm',
                                onPressed: () async {
                                  final ok = await AdaDialogs.confirm(
                                    context,
                                    title: 'Delete item?',
                                    message: 'This action cannot be undone.',
                                    confirmLabel: 'Delete',
                                    cancelLabel: 'Keep',
                                    destructive: true,
                                  );
                                  if (context.mounted) {
                                    AdaSnackbar.show(
                                      context,
                                      ok ? 'Confirmed' : 'Cancelled',
                                    );
                                  }
                                },
                              ),
                              AdaOutlinedButton(
                                label: 'Bottom sheet',
                                onPressed: () => AdaDialogs.bottomSheet(
                                  context,
                                  title: 'Options',
                                  child: const Text('Sheet content'),
                                ),
                              ),
                              AdaOutlinedButton(
                                label: 'Snackbar',
                                onPressed: () {
                                  AdaSnackbar.success(context, 'Success');
                                  AdaSnackbar.error(context, 'Error');
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const AdaShimmer(height: 56),
                          const SizedBox(height: 12),
                          const EmptyView(
                            compact: true,
                            icon: Icons.widgets_outlined,
                            title: 'Empty state',
                            message: 'Reusable empty placeholder for lists.',
                          ),
                          const SizedBox(height: 12),
                          ErrorView(
                            message: 'Could not load data.',
                            onRetry: () => AdaSnackbar.show(context, 'Retry tapped'),
                          ),
                        ],
                      ),
                    ),
                    UiShowcaseSection(
                      icon: Icons.perm_media_outlined,
                      title: context.l10n.showcaseMedia,
                      subtitle: context.l10n.showcaseMediaSub,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              AdaImagePickerButton(
                                label: 'Pick image',
                                onImagePicked: (f) => setState(() {
                                  _pickedImage = f;
                                  if (!_gallery.contains(f)) _gallery.add(f);
                                }),
                              ),
                              AdaFileUpload(
                                onFilePicked: (f) => setState(() => _pickedFile = f),
                              ),
                            ],
                          ),
                          if (_pickedImage != null) ...[
                            const SizedBox(height: 12),
                            AdaImagePreview(
                              file: _pickedImage!,
                              height: 140,
                              onClear: () => setState(() => _pickedImage = null),
                            ),
                          ],
                          const SizedBox(height: 12),
                          AdaImageGallery(files: _gallery),
                          if (_pickedFile != null) ...[
                            const SizedBox(height: 12),
                            AdaDocumentPreview(
                              fileName: _pickedFile!.name,
                              subtitle: '${_pickedFile!.size} bytes',
                              onRemove: () => setState(() => _pickedFile = null),
                            ),
                          ],
                          const SizedBox(height: 12),
                          AdaVideoPreviewPlaceholder(
                            durationLabel: '0:42',
                            onPlay: () => AdaSnackbar.show(context, 'Play video'),
                          ),
                        ],
                      ),
                    ),
                    UiShowcaseSection(
                      icon: Icons.palette_outlined,
                      title: context.l10n.showcaseTokens,
                      subtitle: context.l10n.showcaseTokensSub,
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          AdaStatusChip(label: 'Violet', color: AppColors.primary),
                          AdaStatusChip(label: 'Cyan', color: AppColors.cyan500),
                          AdaStatusChip(label: 'Pink', color: AppColors.pink500),
                          AdaStatusChip(label: 'Radius ${AppRadius.lg}'),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                  ]),
                ),
              ),
            ],
          ),
        ),
    );
  }
}

class _LibraryHero extends StatelessWidget {
  const _LibraryHero({
    required this.themeMode,
    required this.onThemeChanged,
    required this.onlineChip,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;
  final Widget onlineChip;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final gradient = isDark
        ? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3D2F5C),
              Color(0xFF252A38),
            ],
          )
        : AppColors.brandGradient;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: Colors.white.withValues(alpha: isDark ? 0.12 : 0.22),
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.22),
                  blurRadius: 28,
                  offset: const Offset(0, 14),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.widgets_rounded, color: Colors.white),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'UI Component Library',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            'Reusable, configurable building blocks for every ADA app.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                  height: 1.45,
                ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              onlineChip,
              _ThemeModeToggle(
                value: themeMode,
                onChanged: onThemeChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ThemeModeToggle extends StatelessWidget {
  const _ThemeModeToggle({
    required this.value,
    required this.onChanged,
  });

  final ThemeMode value;
  final ValueChanged<ThemeMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(AppRadius.full),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ThemeModeChip(
              icon: Icons.brightness_auto_rounded,
              selected: value == ThemeMode.system,
              onTap: () => onChanged(ThemeMode.system),
            ),
            _ThemeModeChip(
              icon: Icons.light_mode_outlined,
              selected: value == ThemeMode.light,
              onTap: () => onChanged(ThemeMode.light),
            ),
            _ThemeModeChip(
              icon: Icons.dark_mode_outlined,
              selected: value == ThemeMode.dark,
              onTap: () => onChanged(ThemeMode.dark),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeModeChip extends StatelessWidget {
  const _ThemeModeChip({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? Colors.white.withValues(alpha: 0.95)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.full),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Icon(
            icon,
            size: 18,
            color: selected ? AppColors.primary : Colors.white,
          ),
        ),
      ),
    );
  }
}
