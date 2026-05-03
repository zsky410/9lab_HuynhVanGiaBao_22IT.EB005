// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:lab07_destini/main.dart';

void main() {
  testWidgets('Destini renders story and choice buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const DestiniApp());

    expect(find.textContaining('Xe của bạn nổ lốp'), findsOneWidget);
    expect(find.text('Lên xe xin đi nhờ.'), findsOneWidget);
    expect(find.text('Từ chối và đợi cứu hộ.'), findsOneWidget);
  });
}
