import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/tokens.dart';
import 'call_us_button.dart';
import 'primary_button.dart';
import 'state_layout.dart';

/// Failure state for any network call: icon + title + [message], an
/// optional retry, and always a call-us fallback.
class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    required this.message,
    this.onRetry,
    this.title = AppStrings.errorTitle,
  });

  final String message;
  final VoidCallback? onRetry;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final retry = onRetry;
    return Semantics(
      liveRegion: true,
      container: true,
      child: StateLayout(
        children: [
          const Icon(Icons.error_outline, size: AppSizes.iconLg),
          const SizedBox(height: AppSpacing.md),
          Semantics(
            header: true,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: AppSpacing.lg),
          if (retry != null) ...[
            PrimaryButton(
              label: AppStrings.tryAgain,
              icon: Icons.refresh,
              onPressed: retry,
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          Text(
            AppStrings.errorCallFallback,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          CallUsButton(
            variant: retry == null
                ? CallUsButtonVariant.primary
                : CallUsButtonVariant.secondary,
          ),
        ],
      ),
    );
  }
}
