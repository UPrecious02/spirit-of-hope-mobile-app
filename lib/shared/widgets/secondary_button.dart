import 'package:flutter/material.dart';

import 'button_content.dart';

/// Lower-emphasis action: grey fill, minimum 56dp tall (from the theme).
///
/// While [isLoading] the button is disabled and shows a spinner.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.semanticLabel,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;

  /// Spoken instead of [label] when the visible text is not enough.
  final String? semanticLabel;

  /// Fill the available width.
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expand ? double.infinity : null,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        child: ButtonContent(
          label: label,
          icon: icon,
          isLoading: isLoading,
          semanticLabel: semanticLabel,
        ),
      ),
    );
  }
}
