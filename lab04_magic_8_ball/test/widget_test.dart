// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:lab04_magic_8_ball/main.dart';

void main() {
  testWidgets('Magic 8 Ball renders', (WidgetTester tester) async {
    await tester.pumpWidget(const Magic8BallApp());

    expect(find.text('Ask Me Anything'), findsOneWidget);
    expect(find.text('Tap the ball to get an answer'), findsOneWidget);
    expect(find.text('Shake'), findsOneWidget);
  });
}
