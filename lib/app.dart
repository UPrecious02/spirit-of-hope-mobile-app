import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'debug/styleguide_screen.dart';
import 'shared/widgets/call_us_button.dart';

/// Root widget. Home is still a placeholder — features arrive in later
/// segments.
class SpiritOfHopeApp extends StatelessWidget {
  const SpiritOfHopeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      routes: {
        '/': (_) => const _PlaceholderHome(),
        // TEMPORARY: debug-only styleguide. Remove once features land.
        if (!kReleaseMode)
          StyleguideScreen.routeName: (_) => const StyleguideScreen(),
      },
    );
  }
}

class _PlaceholderHome extends StatelessWidget {
  const _PlaceholderHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.appName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: const [CallUsButton.appBar()],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(AppStrings.appName),
            if (!kReleaseMode)
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(StyleguideScreen.routeName),
                child: const Text(AppStrings.debugStyleguideLink),
              ),
          ],
        ),
      ),
    );
  }
}
