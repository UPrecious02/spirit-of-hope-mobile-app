import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/tokens.dart';
import 'state_layout.dart';

/// Full-area loading indicator with a visible, announced message.
class LoadingState extends StatelessWidget {
  const LoadingState({super.key, this.message = AppStrings.loading});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      liveRegion: true,
      container: true,
      child: StateLayout(
        children: [
          const SizedBox.square(
            dimension: AppSizes.spinnerLg,
            child: CircularProgressIndicator(
              strokeWidth: AppSizes.spinnerStroke,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
