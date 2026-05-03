// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab09_clima/main.dart';

void main() {
  testWidgets('Clima page renders input and action button', (WidgetTester tester) async {
    await tester.pumpWidget(const ClimaApp());

    expect(find.text('Clima - Thời tiết'), findsOneWidget);
    expect(find.textContaining('Nhập thành phố'), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
  });
}
