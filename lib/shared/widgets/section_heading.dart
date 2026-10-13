import 'package:flutter/material.dart';

import '../../core/theme/tokens.dart';
import '../../core/theme/typography.dart';

/// Section title with an optional Geist Mono eyebrow above and subtitle below.
class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
    this.eyebrow,
    this.subtitle,
  });

  final String title;

  /// Rendered upper-case; read by screen readers as written.
  final String? eyebrow;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final eyebrowText = eyebrow;
    final subtitleText = subtitle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (eyebrowText != null) ...[
          Text(
            eyebrowText.toUpperCase(),
            semanticsLabel: eyebrowText,
            style: AppTypography.eyebrow,
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
        Semantics(
          header: true,
          child: Text(title, style: theme.textTheme.headlineMedium),
        ),
        if (subtitleText != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            subtitleText,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}
