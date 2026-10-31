import 'package:abould_ada/core/theme/app_colors.dart';

import 'package:abould_ada/core/theme/app_radius.dart';

import 'package:abould_ada/core/theme/app_typography.dart';

import 'package:flutter/material.dart';



abstract final class AppTheme {

  static ThemeData get light => _build(Brightness.light);



  static ThemeData get dark => _build(Brightness.dark);



  static ThemeData _build(Brightness brightness) {

    final isDark = brightness == Brightness.dark;



    final scheme = ColorScheme(

      brightness: brightness,

      primary: AppColors.primary,

      onPrimary: AppColors.neutral0,

      primaryContainer: isDark ? AppColors.violet700 : AppColors.violet100,

      onPrimaryContainer:

          isDark ? AppColors.violet100 : AppColors.violet700,

      secondary: AppColors.cyan500,

      onSecondary: AppColors.neutral0,

      secondaryContainer:

          isDark ? AppColors.cyan500.withValues(alpha: 0.25) : const Color(0xFFD5F5F8),

      onSecondaryContainer: isDark ? AppColors.neutral0 : const Color(0xFF147481),

      tertiary: AppColors.pink500,

      onTertiary: AppColors.neutral0,

      error: AppColors.error,

      onError: AppColors.neutral0,

      errorContainer: const Color(0xFFFDE1DF),

      onErrorContainer: AppColors.error700,

      surface: isDark ? AppColors.darkSurface : AppColors.lightSurface,

      surfaceContainerHighest: isDark
          ? AppColors.darkSurfaceVariant
          : AppColors.neutral100,

      surfaceContainerHigh: isDark
          ? const Color(0xFF353D4A)
          : AppColors.neutral100,

      surfaceContainer: isDark
          ? AppColors.darkSurface
          : AppColors.lightSurfaceVariant,

      onSurface: isDark ? AppColors.neutral100 : AppColors.neutral800,

      onSurfaceVariant:

          isDark ? AppColors.neutral500 : AppColors.neutral600,

      outline: isDark ? AppColors.neutral700 : AppColors.neutral200,

      outlineVariant: isDark ? AppColors.neutral700 : AppColors.neutral200,

      shadow: Colors.black,

      scrim: Colors.black,

      inverseSurface: isDark ? AppColors.neutral100 : AppColors.neutral800,

      onInverseSurface:

          isDark ? AppColors.neutral800 : AppColors.neutral100,

      inversePrimary: AppColors.violet100,

      surfaceTint: AppColors.primary,

    );



    final base = ThemeData(

      useMaterial3: true,

      brightness: brightness,

      colorScheme: scheme,

      scaffoldBackgroundColor:

          isDark ? AppColors.darkBackground : AppColors.lightBackground,

    );



    return base.copyWith(

      textTheme: AppTypography.textTheme(base.textTheme).apply(

        bodyColor: scheme.onSurface,

        displayColor: scheme.onSurface,

      ),

      appBarTheme: AppBarTheme(

        centerTitle: false,

        elevation: 0,

        scrolledUnderElevation: 0,

        backgroundColor: Colors.transparent,

        foregroundColor: scheme.onSurface,

        titleTextStyle: base.textTheme.titleLarge?.copyWith(

          fontWeight: FontWeight.w700,

          color: scheme.onSurface,

        ),

      ),

      cardTheme: CardThemeData(

        elevation: 0,

        color: scheme.surface,

        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(AppRadius.lg),

          side: BorderSide(color: scheme.outline.withValues(alpha: 0.6)),

        ),

        margin: EdgeInsets.zero,

      ),

      dialogTheme: DialogThemeData(

        backgroundColor: Colors.transparent,

        elevation: 0,

        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(28),

        ),

      ),

      iconTheme: IconThemeData(

        color: scheme.onSurfaceVariant,

      ),

      filledButtonTheme: FilledButtonThemeData(

        style: FilledButton.styleFrom(

          backgroundColor: scheme.primary,

          foregroundColor: scheme.onPrimary,

          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),

          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(AppRadius.full),

          ),

          textStyle: const TextStyle(

            fontWeight: FontWeight.w700,

            fontSize: 15,

          ),

        ),

      ),

      outlinedButtonTheme: OutlinedButtonThemeData(

        style: OutlinedButton.styleFrom(

          foregroundColor: scheme.primary,

          side: BorderSide(color: scheme.outline),

          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),

          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(AppRadius.full),

          ),

        ),

      ),

      dividerTheme: DividerThemeData(

        color: scheme.outline,

        thickness: 1,

      ),

      inputDecorationTheme: InputDecorationTheme(

        filled: true,

        fillColor: isDark

            ? AppColors.darkSurfaceVariant.withValues(alpha: 0.45)

            : AppColors.neutral0,

        enabledBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(AppRadius.md),

          borderSide: BorderSide(

            color: isDark

                ? AppColors.neutral700

                : AppColors.neutral400,

          ),

        ),

        focusedBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(AppRadius.md),

          borderSide: BorderSide(color: scheme.primary, width: 1.5),

        ),

        border: OutlineInputBorder(

          borderRadius: BorderRadius.circular(AppRadius.md),

          borderSide: BorderSide(

            color: isDark

                ? AppColors.neutral700

                : AppColors.neutral400,

          ),

        ),

      ),

    );

  }

}

