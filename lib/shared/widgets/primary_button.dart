import 'package:flutter/material.dart';

import 'button_content.dart';

/// Main call to action: green fill, minimum 56dp tall (from the theme).
///
/// While [isLoading] the button is disabled and shows a spinner, so a
/// double tap cannot submit twice.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
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
      child: ElevatedButton(
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
