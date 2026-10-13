import 'package:flutter/material.dart';

import '../../core/theme/tokens.dart';

/// Bordered content card. When [onTap] is set the whole card is one tap
/// target (at least 56dp tall) announced as a button with [semanticLabel].
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.semanticLabel,
    this.padding = const EdgeInsets.all(AppSpacing.md),
  }) : assert(
          onTap == null || semanticLabel != null,
          'A tappable AppCard needs a semanticLabel.',
        );

  final Widget child;
  final VoidCallback? onTap;
  final String? semanticLabel;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final content = Padding(padding: padding, child: child);
    if (onTap == null) return Card(child: content);

    return Card(
      child: Semantics(
        button: true,
        label: semanticLabel,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(minHeight: AppSizes.minTapTarget),
            child: ExcludeSemantics(child: content),
          ),
        ),
      ),
    );
  }
}
