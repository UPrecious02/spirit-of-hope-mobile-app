import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spirit_of_hope/core/theme/app_theme.dart';
import 'package:spirit_of_hope/core/theme/tokens.dart';
import 'package:spirit_of_hope/debug/styleguide_screen.dart';

/// Optional: `--dart-define=SCREENSHOT_DIR=<dir>` saves a PNG per viewport,
/// and `--dart-define=ICON_FONT=<path to MaterialIcons-Regular.otf>` renders
/// real icons in them. Neither is needed for the assertions.
const _screenshotDir = String.fromEnvironment('SCREENSHOT_DIR');
const _iconFont = String.fromEnvironment('ICON_FONT');

/// A typical phone, in logical pixels.
const _phone = Size(412, 915);

Future<void> _loadFonts() async {
  final inter = FontLoader('InterTight')
    ..addFont(rootBundle.load('assets/fonts/inter_tight/InterTight-Variable.ttf'));
  final mono = FontLoader('GeistMono')
    ..addFont(rootBundle.load('assets/fonts/geist_mono/GeistMono-Variable.ttf'));
  await Future.wait([inter.load(), mono.load()]);
  if (_iconFont.isNotEmpty) {
    final bytes = File(_iconFont).readAsBytesSync();
    await (FontLoader('MaterialIcons')
          ..addFont(Future.value(ByteData.sublistView(bytes))))
        .load();
  }
}

Future<void> _pumpStyleguide(
  WidgetTester tester, {
  required double textScale,
  required Size size,
}) async {
  tester.view.physicalSize = size * tester.view.devicePixelRatio;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(textScale),
        ),
        child: child!,
      ),
      home: const StyleguideScreen(),
    ),
  );
  // Spinners animate forever, so pump a frame rather than settle.
  await tester.pump(const Duration(milliseconds: 100));
}

Future<void> _screenshot(WidgetTester tester, String name) async {
  if (_screenshotDir.isEmpty) return;
  final image = await captureImage(find.byType(MaterialApp).evaluate().single);
  final bytes = await tester.runAsync(
    () => image.toByteData(format: ui.ImageByteFormat.png),
  );
  File('$_screenshotDir/$name.png')
      .writeAsBytesSync(bytes!.buffer.asUint8List());
}

void main() {
  setUpAll(_loadFonts);

  for (final scale in [1.0, 2.0]) {
    final pct = (scale * 100).round();

    testWidgets('styleguide scrolls end to end without overflow at $pct%',
        (tester) async {
      await _pumpStyleguide(tester, textScale: scale, size: _phone);

      final list = tester.state<ScrollableState>(
        find.byType(Scrollable).first,
      );
      var page = 0;
      while (true) {
        expect(tester.takeException(), isNull, reason: 'page $page');
        await _screenshot(tester, 'styleguide_${pct}_${page.toString().padLeft(2, '0')}');
        final position = list.position;
        if (position.pixels >= position.maxScrollExtent) break;
        position.jumpTo(
          (position.pixels + position.viewportDimension * 0.9)
              .clamp(0, position.maxScrollExtent),
        );
        await tester.pump();
        page++;
      }
    });

    testWidgets('every tap target is at least 56dp at $pct%', (tester) async {
      // Tall viewport so the whole list is laid out at once.
      await _pumpStyleguide(
        tester,
        textScale: scale,
        size: Size(_phone.width, 30000),
      );
      expect(tester.takeException(), isNull);

      final targets = find.byWidgetPredicate(
        (w) => w is ButtonStyleButton || w is InkWell,
      );
      expect(targets, findsWidgets);
      for (final element in targets.evaluate()) {
        final box = element.renderObject! as RenderBox;
        expect(
          box.size.height,
          greaterThanOrEqualTo(AppSizes.minTapTarget),
          reason: '${element.widget.runtimeType} is ${box.size}',
        );
        expect(box.size.width, greaterThanOrEqualTo(AppSizes.minTapTarget));
      }
    });

    testWidgets('every tappable node has a semantic label at $pct%',
        (tester) async {
      final handle = tester.ensureSemantics();
      await _pumpStyleguide(
        tester,
        textScale: scale,
        size: Size(_phone.width, 30000),
      );

      final tappable =
          find.semantics.byAction(SemanticsAction.tap).evaluate().toList();
      expect(tappable.length, greaterThan(10));
      for (final node in tappable) {
        expect(node.label.trim(), isNotEmpty, reason: 'node ${node.id}');
      }
      handle.dispose();
    });
  }
}
