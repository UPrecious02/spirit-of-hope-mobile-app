import 'package:flutter/material.dart';

import '../core/theme/tokens.dart';
import '../core/theme/typography.dart';
import '../shared/widgets/app_card.dart';
import '../shared/widgets/call_us_button.dart';
import '../shared/widgets/empty_state.dart';
import '../shared/widgets/error_state.dart';
import '../shared/widgets/loading_state.dart';
import '../shared/widgets/primary_button.dart';
import '../shared/widgets/secondary_button.dart';
import '../shared/widgets/section_heading.dart';
import 'styleguide_strings.dart';

/// TEMPORARY debug screen: every token, text style, button state and shared
/// widget on one scrollable page. Registered only outside release builds.
class StyleguideScreen extends StatelessWidget {
  const StyleguideScreen({super.key});

  static const String routeName = '/debug/styleguide';

  static const List<(String, Color)> _colours = [
    ('primaryGreen', AppColors.primaryGreen),
    ('secondaryGrey', AppColors.secondaryGrey),
    ('accentYellow', AppColors.accentYellow),
    ('surface', AppColors.surface),
    ('surfaceAlt', AppColors.surfaceAlt),
    ('ink', AppColors.ink),
    ('inkMuted', AppColors.inkMuted),
  ];

  static const List<(String, double)> _spacing = [
    ('xxs', AppSpacing.xxs),
    ('xs', AppSpacing.xs),
    ('sm', AppSpacing.sm),
    ('md', AppSpacing.md),
    ('lg', AppSpacing.lg),
    ('xl', AppSpacing.xl),
    ('xxl', AppSpacing.xxl),
  ];

  static final List<(String, TextStyle)> _styles = [
    ('displayLarge', AppTypography.displayLarge),
    ('headlineLarge', AppTypography.headlineLarge),
    ('headlineMedium', AppTypography.headlineMedium),
    ('titleLarge', AppTypography.titleLarge),
    ('bodyLarge', AppTypography.bodyLarge),
    ('bodyMedium', AppTypography.bodyMedium),
    ('bodySmall (caption)', AppTypography.bodySmall),
    ('labelLarge', AppTypography.labelLarge),
  ];

  static String _hex(Color colour) =>
      '#${(colour.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';

  static String _sp(TextStyle style) =>
      '${style.fontSize?.toStringAsFixed(0) ?? '?'}sp';

  static void _noop() {}

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          action: SnackBarAction(
            label: StyleguideStrings.snackBarAction,
            onPressed: _noop,
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    const gap = SizedBox(height: AppSpacing.sm);
    const sectionGap = SizedBox(height: AppSpacing.xxl);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StyleguideStrings.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: const [CallUsButton.appBar()],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            _SectionTitle(StyleguideStrings.colours),
            for (final (name, colour) in _colours) ...[
              Row(
                children: [
                  Container(
                    width: AppSpacing.xxl,
                    height: AppSpacing.xxl,
                    decoration: BoxDecoration(
                      color: colour,
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                      border: Border.all(
                        color: AppColors.inkMuted,
                        width: AppSizes.borderThin,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: theme.textTheme.titleSmall),
                        Text(_hex(colour), style: muted),
                      ],
                    ),
                  ),
                ],
              ),
              gap,
            ],
            sectionGap,
            _SectionTitle(StyleguideStrings.spacing),
            for (final (name, value) in _spacing) ...[
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '$name · ${value.toStringAsFixed(0)}dp',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  Container(
                    width: value,
                    height: AppSpacing.md,
                    color: AppColors.primaryGreen,
                  ),
                ],
              ),
              gap,
            ],
            sectionGap,
            _SectionTitle(StyleguideStrings.typography),
            for (final (name, style) in _styles) ...[
              Text('$name · ${_sp(style)}', style: muted),
              Text(StyleguideStrings.sampleText, style: style),
              const SizedBox(height: AppSpacing.md),
            ],
            Text('eyebrow (Geist Mono) · ${_sp(AppTypography.eyebrow)}',
                style: muted),
            Text(
              StyleguideStrings.sampleText.toUpperCase(),
              semanticsLabel: StyleguideStrings.sampleText,
              style: AppTypography.eyebrow,
            ),
            sectionGap,
            _SectionTitle(StyleguideStrings.buttons),
            _Caption(StyleguideStrings.primary),
            const PrimaryButton(
              label: StyleguideStrings.enabled,
              onPressed: _noop,
            ),
            gap,
            const PrimaryButton(
              label: StyleguideStrings.withIcon,
              icon: Icons.check,
              onPressed: _noop,
            ),
            gap,
            const PrimaryButton(
              label: StyleguideStrings.loading,
              isLoading: true,
              onPressed: _noop,
            ),
            gap,
            const PrimaryButton(
              label: StyleguideStrings.disabled,
              onPressed: null,
            ),
            const SizedBox(height: AppSpacing.lg),
            _Caption(StyleguideStrings.secondary),
            const SecondaryButton(
              label: StyleguideStrings.enabled,
              onPressed: _noop,
            ),
            gap,
            const SecondaryButton(
              label: StyleguideStrings.withIcon,
              icon: Icons.check,
              onPressed: _noop,
            ),
            gap,
            const SecondaryButton(
              label: StyleguideStrings.loading,
              isLoading: true,
              onPressed: _noop,
            ),
            gap,
            const SecondaryButton(
              label: StyleguideStrings.disabled,
              onPressed: null,
            ),
            const SizedBox(height: AppSpacing.lg),
            _Caption(StyleguideStrings.themeButtons),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: const [
                ElevatedButton(
                  onPressed: _noop,
                  child: Text(StyleguideStrings.elevated),
                ),
                OutlinedButton(
                  onPressed: _noop,
                  child: Text(StyleguideStrings.outlined),
                ),
                OutlinedButton(
                  onPressed: null,
                  child: Text(StyleguideStrings.disabled),
                ),
                TextButton(
                  onPressed: _noop,
                  child: Text(StyleguideStrings.textLink),
                ),
                TextButton(
                  onPressed: null,
                  child: Text(StyleguideStrings.disabled),
                ),
              ],
            ),
            sectionGap,
            _SectionTitle(StyleguideStrings.callUs),
            const CallUsButton(),
            gap,
            const CallUsButton(variant: CallUsButtonVariant.secondary),
            gap,
            Text(StyleguideStrings.appBarVariantNote, style: muted),
            sectionGap,
            _SectionTitle(StyleguideStrings.inputs),
            const TextField(
              decoration: InputDecoration(
                labelText: StyleguideStrings.fieldLabel,
                hintText: StyleguideStrings.fieldHint,
                helperText: StyleguideStrings.fieldHelper,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const TextField(
              decoration: InputDecoration(
                labelText: StyleguideStrings.fieldLabel,
                errorText: StyleguideStrings.fieldError,
                suffixIcon: Icon(Icons.error_outline),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const TextField(
              enabled: false,
              decoration: InputDecoration(
                labelText: StyleguideStrings.fieldDisabled,
              ),
            ),
            sectionGap,
            _SectionTitle(StyleguideStrings.cards),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StyleguideStrings.cardStaticTitle,
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    StyleguideStrings.cardStaticBody,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            gap,
            AppCard(
              semanticLabel: StyleguideStrings.cardTapSemantic,
              onTap: () => _showSnack(context, StyleguideStrings.cardTapped),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StyleguideStrings.cardTapTitle,
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          StyleguideStrings.cardTapBody,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: theme.colorScheme.primary),
                ],
              ),
            ),
            sectionGap,
            _SectionTitle(StyleguideStrings.headings),
            const SectionHeading(
              eyebrow: StyleguideStrings.headingEyebrow,
              title: StyleguideStrings.headingTitle,
              subtitle: StyleguideStrings.headingSubtitle,
            ),
            sectionGap,
            _SectionTitle(StyleguideStrings.snackBar),
            SecondaryButton(
              label: StyleguideStrings.showSnackBar,
              onPressed: () =>
                  _showSnack(context, StyleguideStrings.snackBarMessage),
            ),
            sectionGap,
            _SectionTitle(StyleguideStrings.states),
            const _Framed(
              child: LoadingState(message: StyleguideStrings.loadingMessage),
            ),
            gap,
            _Framed(
              child: EmptyState(
                title: StyleguideStrings.emptyTitle,
                message: StyleguideStrings.emptyMessage,
                actionLabel: StyleguideStrings.emptyAction,
                onAction: () => _showSnack(context, StyleguideStrings.emptyAction),
              ),
            ),
            gap,
            _Framed(
              child: ErrorState(
                message: StyleguideStrings.errorMessage,
                onRetry: () =>
                    _showSnack(context, StyleguideStrings.retryPressed),
              ),
            ),
            gap,
            _Caption(StyleguideStrings.errorNoRetry),
            const _Framed(
              child: ErrorState(message: StyleguideStrings.errorMessage),
            ),
            sectionGap,
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Semantics(
        header: true,
        child: Text(text, style: Theme.of(context).textTheme.headlineLarge),
      ),
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Text(
        text,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

/// Outlines a state widget so its bounds are visible on the page.
class _Framed extends StatelessWidget {
  const _Framed({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(
          color: AppColors.secondaryGrey,
          width: AppSizes.borderMedium,
        ),
      ),
      child: child,
    );
  }
}
