import 'package:flutter/material.dart';

import '../../core/theme/tokens.dart';
import 'secondary_button.dart';
import 'state_layout.dart';

/// Shown when a request succeeds but returns nothing.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    this.message,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
  }) : assert(
          (actionLabel == null) == (onAction == null),
          'actionLabel and onAction must be set together.',
        );

  final String title;
  final String? message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final body = message;
    final label = actionLabel;
    return StateLayout(
      children: [
        Icon(icon, size: AppSizes.iconLg),
        const SizedBox(height: AppSpacing.md),
        Semantics(
          header: true,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall,
          ),
        ),
        if (body != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            body,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        if (label != null) ...[
          const SizedBox(height: AppSpacing.lg),
          SecondaryButton(label: label, onPressed: onAction),
        ],
      ],
    );
  }
}
