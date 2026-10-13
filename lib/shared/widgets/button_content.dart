import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/tokens.dart';

/// Icon/spinner + label row shared by the app's buttons. The label wraps
/// rather than overflowing at large text scales.
///
/// Sets the button's accessible name to [semanticLabel] (or [label]) and
/// announces the loading state.
class ButtonContent extends StatelessWidget {
  const ButtonContent({
    super.key,
    required this.label,
    this.icon,
    this.isLoading = false,
    this.semanticLabel,
  });

  final String label;
  final IconData? icon;
  final bool isLoading;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final spokenLabel = semanticLabel ?? label;
    return Semantics(
      label: isLoading
          ? '$spokenLabel${AppStrings.loadingSemanticSuffix}'
          : spokenLabel,
      // A Wrap, not a Row: at large text scales the icon moves above the
      // label instead of squeezing it.
      child: ExcludeSemantics(
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.xxs,
          children: [
            if (isLoading)
              const SizedBox.square(
                dimension: AppSizes.spinnerSm,
                child: CircularProgressIndicator(
                  strokeWidth: AppSizes.spinnerStroke,
                ),
              )
            else if (icon != null)
              Icon(icon),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
