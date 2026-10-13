import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/utils/phone_launcher.dart';
import 'button_content.dart';
import 'primary_button.dart';
import 'secondary_button.dart';

enum CallUsButtonVariant { primary, secondary, appBar }

/// Dials the agency (CLAUDE.md §6: "Call us" is always reachable).
///
/// If no phone app can take the call, a SnackBar shows the number instead.
class CallUsButton extends StatelessWidget {
  const CallUsButton({
    super.key,
    this.variant = CallUsButtonVariant.primary,
    this.expand = true,
  });

  /// Compact form for [AppBar.actions]: light label on the green bar.
  const CallUsButton.appBar({super.key})
      : variant = CallUsButtonVariant.appBar,
        expand = false;

  final CallUsButtonVariant variant;
  final bool expand;

  Future<void> _call(BuildContext context) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    final launched = await launchAgencyCall();
    if (!launched) {
      messenger
        ?..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text(AppStrings.callFailed)));
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case CallUsButtonVariant.primary:
        return PrimaryButton(
          label: AppStrings.callUsWithNumber,
          icon: Icons.phone,
          semanticLabel: AppStrings.callUsSemantic,
          expand: expand,
          onPressed: () => _call(context),
        );
      case CallUsButtonVariant.secondary:
        return SecondaryButton(
          label: AppStrings.callUsWithNumber,
          icon: Icons.phone,
          semanticLabel: AppStrings.callUsSemantic,
          expand: expand,
          onPressed: () => _call(context),
        );
      case CallUsButtonVariant.appBar:
        final theme = Theme.of(context);
        return TextButton(
          style: TextButton.styleFrom(
            foregroundColor: theme.colorScheme.onPrimary,
            iconColor: theme.colorScheme.tertiary,
            textStyle: theme.textTheme.labelLarge,
          ),
          onPressed: () => _call(context),
          child: const ButtonContent(
            label: AppStrings.callUs,
            icon: Icons.phone,
            semanticLabel: AppStrings.callUsSemantic,
          ),
        );
    }
  }
}
