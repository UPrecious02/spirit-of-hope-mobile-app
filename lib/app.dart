import 'package:flutter/material.dart';

/// Root widget. Placeholder only — theme and routing arrive in later segments.
class SpiritOfHopeApp extends StatelessWidget {
  const SpiritOfHopeApp({super.key});

  static const String _appName = 'Spirit of Hope';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _appName,
      home: Scaffold(
        body: Center(child: Text(_appName)),
      ),
    );
  }
}
