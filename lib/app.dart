import 'package:abould_ada/core/routing/app_router.dart';
import 'package:abould_ada/core/services/app_lifecycle_service.dart';
import 'package:abould_ada/core/services/locale_controller.dart';
import 'package:abould_ada/core/services/theme_mode_controller.dart';
import 'package:abould_ada/core/theme/app_theme.dart';
import 'package:abould_ada/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AbouldAdaApp extends ConsumerStatefulWidget {
  const AbouldAdaApp({super.key});

  @override
  ConsumerState<AbouldAdaApp> createState() => _AbouldAdaAppState();
}

class _AbouldAdaAppState extends ConsumerState<AbouldAdaApp> {
  AppLifecycleObserver? _lifecycleObserver;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(appLifecycleProvider.notifier);
      _lifecycleObserver = AppLifecycleObserver(notifier);
      WidgetsBinding.instance.addObserver(_lifecycleObserver!);
    });
  }

  @override
  void dispose() {
    if (_lifecycleObserver != null) {
      WidgetsBinding.instance.removeObserver(_lifecycleObserver!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeControllerProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
