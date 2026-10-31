import 'package:flutter/material.dart';



/// Design tokens: Violet brand, Neutral UI, Blue/Cyan/Pink accents, status colors.

abstract final class AppColors {

  // —— Brand / Violet ——

  static const violet50 = Color(0xFFF5F0FF);

  static const violet100 = Color(0xFFE9DFFF);

  static const violet500 = Color(0xFF7856C9);

  static const violet600 = Color(0xFF6244AE);

  static const violet700 = Color(0xFF503791);



  static const primary = violet500;

  static const primaryDark = violet600;

  static const primaryContainer = violet100;



  // —— Accent ——

  static const cyan500 = Color(0xFF20AFC0);

  static const pink500 = Color(0xFFD6539D);

  static const secondary = cyan500;

  static const accent = pink500;



  // —— Brand / Blue (links, info) ——

  static const blue500 = Color(0xFF3978D4);



  // —— Neutral ——

  static const neutral0 = Color(0xFFFFFFFF);

  static const neutral50 = Color(0xFFFAFAF9);

  static const neutral100 = Color(0xFFF5F5F3);

  static const neutral200 = Color(0xFFE9E9E6);

  static const neutral300 = Color(0xFFD4D4CF);

  static const neutral400 = Color(0xFFB0B0AA);

  static const neutral500 = Color(0xFF8A8A84);

  static const neutral600 = Color(0xFF666660);

  static const neutral700 = Color(0xFF45453F);

  static const neutral800 = Color(0xFF292925);

  static const neutral900 = Color(0xFF151512);



  // —— Status ——

  static const success = Color(0xFF35A86B);

  static const warning = Color(0xFFD99A25);

  static const error = Color(0xFFD9534F);

  static const error700 = Color(0xFF91312E);

  static const info = blue500;



  // —— Surfaces (light) ——

  static const lightBackground = neutral50;

  static const lightSurface = neutral0;

  static const lightSurfaceVariant = neutral100;



  // —— Surfaces (dark) ——

  static const darkBackground = Color(0xFF151512);

  static const darkSurface = Color(0xFF292925);

  static const darkSurfaceVariant = Color(0xFF45453F);



  // —— Dialog (light-first; dark uses same hues where noted) ——

  static const dialogTextPrimary = neutral800;

  static const dialogTextSecondary = neutral600;

  static const dialogDestructive = error;

  static const dialogSecondaryButton = Color(0xFFF0F4F8);

  static const dialogCloseBackground = Color(0xFF1A1C29);



  static const gradientStart = violet500;

  static const gradientMid = Color(0xFF9A78E8);

  static const gradientEnd = cyan500;



  static LinearGradient get brandGradient => const LinearGradient(

        begin: Alignment.topLeft,

        end: Alignment.bottomRight,

        colors: [gradientStart, gradientMid, gradientEnd],

      );



  static LinearGradient subtleGradient(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LinearGradient(

      begin: Alignment.topCenter,

      end: Alignment.bottomCenter,

      colors: isDark

          ? [violet700.withValues(alpha: 0.45), darkBackground]

          : [violet50, neutral50],

    );

  }



  /// Close control on modals — readable on white cards in light theme.

  static Color dialogCloseBackgroundFor(Brightness brightness) {

    return brightness == Brightness.light

        ? dialogCloseBackground

        : neutral700;

  }

}

