import 'package:flutter/material.dart';

import 'tokens.dart';

/// Text style scale — CLAUDE.md section 6: body ≥ 18sp, captions ≥ 15sp.
///
/// Both fonts are bundled variable fonts, so every style sets the weight
/// twice: [FontWeight] for the framework and a `wght` [FontVariation] so the
/// glyphs actually render at that weight. To change a weight, use
/// [AppTypography.withWeight] rather than `copyWith(fontWeight:)`.
abstract final class AppTypography {
  static const String brandFamily = 'InterTight';
  static const String monoFamily = 'GeistMono';

  static const double _headingHeight = 1.2;
  static const double _bodyHeight = 1.45;

  static final TextStyle displayLarge =
      _inter(40, FontWeight.w700, height: _headingHeight);
  static final TextStyle displayMedium =
      _inter(36, FontWeight.w700, height: _headingHeight);
  static final TextStyle displaySmall =
      _inter(34, FontWeight.w700, height: _headingHeight);

  static final TextStyle headlineLarge =
      _inter(32, FontWeight.w700, height: _headingHeight);
  static final TextStyle headlineMedium =
      _inter(28, FontWeight.w600, height: _headingHeight);
  static final TextStyle headlineSmall =
      _inter(24, FontWeight.w600, height: _headingHeight);

  static final TextStyle titleLarge =
      _inter(22, FontWeight.w600, height: _headingHeight);
  static final TextStyle titleMedium =
      _inter(20, FontWeight.w600, height: _headingHeight);
  static final TextStyle titleSmall =
      _inter(18, FontWeight.w600, height: _headingHeight);

  static final TextStyle bodyLarge =
      _inter(20, FontWeight.w400, height: _bodyHeight);
  static final TextStyle bodyMedium =
      _inter(18, FontWeight.w400, height: _bodyHeight);

  /// Captions — the 15sp floor.
  static final TextStyle bodySmall =
      _inter(15, FontWeight.w400, height: _bodyHeight);

  /// Button labels.
  static final TextStyle labelLarge =
      _inter(18, FontWeight.w600, height: _headingHeight);
  static final TextStyle labelMedium =
      _inter(16, FontWeight.w600, height: _headingHeight);
  static final TextStyle labelSmall =
      _inter(15, FontWeight.w600, height: _headingHeight);

  /// Geist Mono, for small uppercase labels only (eyebrows, category tags).
  /// Flutter has no text-transform: callers pass upper-cased strings.
  static final TextStyle eyebrow = TextStyle(
    fontFamily: monoFamily,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    fontVariations: const [FontVariation.weight(500)],
    letterSpacing: 1.2,
    height: _headingHeight,
    color: AppColors.inkMuted,
  );

  /// Every Material slot is filled so no component falls back to the
  /// framework's 11–14sp defaults.
  static final TextTheme textTheme = TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );

  /// Returns [style] at [weight], keeping the variable-font axis in step.
  static TextStyle withWeight(TextStyle style, FontWeight weight) =>
      style.copyWith(
        fontWeight: weight,
        fontVariations: [FontVariation.weight(weight.value.toDouble())],
      );

  static TextStyle _inter(double size, FontWeight weight,
          {required double height}) =>
      TextStyle(
        fontFamily: brandFamily,
        fontSize: size,
        fontWeight: weight,
        fontVariations: [FontVariation.weight(weight.value.toDouble())],
        height: height,
        color: AppColors.ink,
      );
}
