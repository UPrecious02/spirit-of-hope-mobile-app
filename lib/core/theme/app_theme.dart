import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'tokens.dart';
import 'typography.dart';

/// The app's single light theme. There is no dark theme (CLAUDE.md §5).
///
/// Colour decisions beyond the token table:
/// - Errors use [AppColors.ink], always paired with an icon and text.
/// - Links and text buttons use [AppColors.primaryGreen]; accentYellow is
///   for icons only.
abstract final class AppTheme {
  static const Size _minTapSize =
      Size(AppSizes.minTapTarget, AppSizes.minTapTarget);

  static const EdgeInsets _buttonPadding = EdgeInsets.symmetric(
    horizontal: AppSpacing.lg,
    vertical: AppSpacing.sm,
  );

  static final RoundedRectangleBorder _buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
  );

  static const ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryGreen,
    onPrimary: AppColors.surface,
    secondary: AppColors.secondaryGrey,
    onSecondary: AppColors.ink,
    tertiary: AppColors.accentYellow,
    onTertiary: AppColors.ink,
    error: AppColors.ink,
    onError: AppColors.surface,
    surface: AppColors.surface,
    onSurface: AppColors.ink,
    onSurfaceVariant: AppColors.inkMuted,
    surfaceContainerLowest: AppColors.surface,
    surfaceContainerLow: AppColors.surfaceAlt,
    surfaceContainer: AppColors.surfaceAlt,
    surfaceContainerHigh: AppColors.secondaryGrey,
    surfaceContainerHighest: AppColors.secondaryGrey,
    surfaceTint: AppColors.surface,
    outline: AppColors.inkMuted,
    outlineVariant: AppColors.secondaryGrey,
    inverseSurface: AppColors.ink,
    onInverseSurface: AppColors.surface,
    inversePrimary: AppColors.accentYellow,
  );

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.surface,
    fontFamily: AppTypography.brandFamily,
    textTheme: AppTypography.textTheme,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    visualDensity: VisualDensity.standard,
    dividerColor: AppColors.secondaryGrey,
    iconTheme: const IconThemeData(
      color: AppColors.accentYellow,
      size: AppSizes.iconMd,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryGreen,
      circularTrackColor: AppColors.secondaryGrey,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: _elevatedStyle),
    filledButtonTheme: FilledButtonThemeData(style: _filledStyle),
    outlinedButtonTheme: OutlinedButtonThemeData(style: _outlinedStyle),
    textButtonTheme: TextButtonThemeData(style: _textStyle),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        minimumSize: _minTapSize,
        iconSize: AppSizes.iconMd,
        tapTargetSize: MaterialTapTargetSize.padded,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      surfaceTintColor: AppColors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        side: const BorderSide(
          color: AppColors.secondaryGrey,
          width: AppSizes.borderMedium,
        ),
      ),
    ),
    inputDecorationTheme: _inputTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryGreen,
      foregroundColor: AppColors.surface,
      surfaceTintColor: AppColors.primaryGreen,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      toolbarHeight: AppSizes.toolbarHeight,
      iconTheme: const IconThemeData(
        color: AppColors.accentYellow,
        size: AppSizes.iconMd,
      ),
      actionsIconTheme: const IconThemeData(
        color: AppColors.accentYellow,
        size: AppSizes.iconMd,
      ),
      titleTextStyle:
          AppTypography.titleLarge.copyWith(color: AppColors.surface),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.ink,
      contentTextStyle:
          AppTypography.bodyMedium.copyWith(color: AppColors.surface),
      actionTextColor: AppColors.accentYellow,
      closeIconColor: AppColors.surface,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      insetPadding: const EdgeInsets.all(AppSpacing.md),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
    ),
  );

  /// Primary: green fill, white label, yellow icon (6.49:1 on green).
  static final ButtonStyle _elevatedStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryGreen,
    foregroundColor: AppColors.surface,
    iconColor: AppColors.accentYellow,
    disabledBackgroundColor: AppColors.secondaryGrey,
    disabledForegroundColor: AppColors.inkMuted,
    disabledIconColor: AppColors.inkMuted,
    elevation: 0,
    minimumSize: _minTapSize,
    padding: _buttonPadding,
    shape: _buttonShape,
    textStyle: AppTypography.labelLarge,
    iconSize: AppSizes.iconMd,
    tapTargetSize: MaterialTapTargetSize.padded,
  );

  /// Secondary: grey fill, ink label. Icons are green — yellow on grey would
  /// be invisible.
  static final ButtonStyle _filledStyle = FilledButton.styleFrom(
    backgroundColor: AppColors.secondaryGrey,
    foregroundColor: AppColors.ink,
    iconColor: AppColors.primaryGreen,
    disabledBackgroundColor: AppColors.secondaryGrey,
    disabledForegroundColor: AppColors.inkMuted,
    disabledIconColor: AppColors.inkMuted,
    minimumSize: _minTapSize,
    padding: _buttonPadding,
    shape: _buttonShape,
    textStyle: AppTypography.labelLarge,
    iconSize: AppSizes.iconMd,
    tapTargetSize: MaterialTapTargetSize.padded,
  );

  static final ButtonStyle _outlinedStyle = OutlinedButton.styleFrom(
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.primaryGreen,
    iconColor: AppColors.primaryGreen,
    disabledForegroundColor: AppColors.inkMuted,
    disabledIconColor: AppColors.inkMuted,
    minimumSize: _minTapSize,
    padding: _buttonPadding,
    shape: _buttonShape,
    textStyle: AppTypography.labelLarge,
    iconSize: AppSizes.iconMd,
    tapTargetSize: MaterialTapTargetSize.padded,
  ).copyWith(
    side: WidgetStateProperty.resolveWith(
      (states) => BorderSide(
        color: states.contains(WidgetState.disabled)
            ? AppColors.inkMuted
            : AppColors.primaryGreen,
        width: AppSizes.borderMedium,
      ),
    ),
  );

  /// Links: green, underlined so they are not signalled by colour alone.
  static final ButtonStyle _textStyle = TextButton.styleFrom(
    foregroundColor: AppColors.primaryGreen,
    iconColor: AppColors.primaryGreen,
    disabledForegroundColor: AppColors.inkMuted,
    disabledIconColor: AppColors.inkMuted,
    minimumSize: _minTapSize,
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
    shape: _buttonShape,
    textStyle: AppTypography.labelLarge.copyWith(
      decoration: TextDecoration.underline,
    ),
    iconSize: AppSizes.iconMd,
    tapTargetSize: MaterialTapTargetSize.padded,
  );

  static OutlineInputBorder _inputBorder(Color color, double width) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
        borderSide: BorderSide(color: color, width: width),
      );

  /// Errors are ink with a thicker border plus error text; feature forms add
  /// an error icon so meaning never relies on colour.
  static final InputDecorationTheme _inputTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface,
    contentPadding: const EdgeInsets.all(AppSpacing.md),
    constraints: const BoxConstraints(minHeight: AppSizes.minTapTarget),
    labelStyle: AppTypography.bodyMedium.copyWith(color: AppColors.inkMuted),
    floatingLabelStyle:
        AppTypography.bodyMedium.copyWith(color: AppColors.primaryGreen),
    hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.inkMuted),
    helperStyle: AppTypography.bodySmall.copyWith(color: AppColors.inkMuted),
    helperMaxLines: 3,
    errorStyle: AppTypography.withWeight(
      AppTypography.bodySmall,
      FontWeight.w600,
    ).copyWith(color: AppColors.ink),
    errorMaxLines: 3,
    prefixIconColor: AppColors.primaryGreen,
    suffixIconColor: AppColors.primaryGreen,
    border: _inputBorder(AppColors.inkMuted, AppSizes.borderThin),
    enabledBorder: _inputBorder(AppColors.inkMuted, AppSizes.borderThin),
    focusedBorder: _inputBorder(AppColors.primaryGreen, AppSizes.borderThick),
    errorBorder: _inputBorder(AppColors.ink, AppSizes.borderThick),
    focusedErrorBorder: _inputBorder(AppColors.ink, AppSizes.borderThick),
    disabledBorder: _inputBorder(AppColors.secondaryGrey, AppSizes.borderThin),
  );
}
