// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:lab02_micard/main.dart';

void main() {
  testWidgets('MiCard screen renders contact info', (WidgetTester tester) async {
    await tester.pumpWidget(const MiCardApp());

    expect(find.text('Huynh Van Gia Bao'), findsOneWidget);
    expect(find.text('+84 123 456 789'), findsOneWidget);
    expect(find.text('zsky410@example.com'), findsOneWidget);
  });
}
