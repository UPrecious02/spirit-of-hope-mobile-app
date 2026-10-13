import 'package:flutter/painting.dart';

/// Brand palette — CLAUDE.md section 5. The only place colours are defined.
abstract final class AppColors {
  /// Primary buttons, headers, key accents.
  static const Color primaryGreen = Color(0xFF00544A);

  /// Secondary buttons, dividers, subtle fills.
  static const Color secondaryGrey = Color(0xFFECECEC);

  /// Icons only. 1.37:1 on white, so never text, links or large blocks.
  static const Color accentYellow = Color(0xFFFFDA44);

  /// Default background.
  static const Color surface = Color(0xFFFFFFFF);

  /// Alternating sections.
  static const Color surfaceAlt = Color(0xFFFAFBFA);

  /// Body text. Also used for error states, always paired with an icon.
  static const Color ink = Color(0xFF1F2933);

  /// Secondary text.
  static const Color inkMuted = Color(0xFF5B6670);
}

/// Spacing on a 4dp scale.
abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

/// Fixed component dimensions. Never wrap text in these — sizes are minimums
/// or apply to non-text elements only, so 200% text scaling still works.
abstract final class AppSizes {
  /// Minimum tap target — CLAUDE.md section 6, deliberately above 48dp.
  static const double minTapTarget = 56;

  static const double toolbarHeight = 64;

  static const double radiusSm = 8;
  static const double radiusMd = 12;

  static const double borderThin = 1;
  static const double borderMedium = 2;
  static const double borderThick = 3;

  static const double iconMd = 28;
  static const double iconLg = 56;

  static const double spinnerSm = 24;
  static const double spinnerLg = 48;
  static const double spinnerStroke = 3;

  /// Readable line length on tablets.
  static const double maxContentWidth = 600;
}
