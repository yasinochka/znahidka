import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:znahidka/app.dart';

void main() {
  testWidgets('Застосунок відкривається з екрана входу', (tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const ZnahidkaApp());

    expect(find.text('Вхід до акаунта'), findsOneWidget);
    expect(find.text('Увійти'), findsOneWidget);
  });

  testWidgets('Кнопка «Увійти» відкриває головну сторінку', (tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const ZnahidkaApp());
    await tester.tap(find.text('Увійти'));
    await tester.pumpAndSettle();

    expect(find.text('Вітаємо, Ліза!'), findsOneWidget);
  });
}
