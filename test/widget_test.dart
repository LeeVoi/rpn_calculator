import 'package:flutter_test/flutter_test.dart';

import 'package:rpn_calculator/main.dart';

void main() {
  testWidgets('Test RPN Calculator Adding Numbers', (WidgetTester tester) async {
    await tester.pumpWidget(RPNCalculatorApp());

    await tester.tap(find.text('1'));
    await tester.pump();
    await tester.tap(find.text('2'));
    await tester.pump();
    await tester.tap(find.text('3'));
    await tester.pump();
    await tester.tap(find.text('Enter'));
    await tester.pump();

    expect(find.text('123'), findsOneWidget);
  });

  testWidgets('Test RPN Calculator Addition', (WidgetTester tester) async {
    await tester.pumpWidget(RPNCalculatorApp());

    await tester.tap(find.text('1'));
    await tester.pump();
    await tester.tap(find.text('2'));
    await tester.pump();
    await tester.tap(find.text('Enter'));
    await tester.pump();

    await tester.tap(find.text('3'));
    await tester.pump();
    await tester.tap(find.text('+'));
    await tester.pump();

    expect(find.text('15.0'), findsOneWidget);
  });

  testWidgets('Test RPN Calculator Subtraction', (WidgetTester tester) async {
    await tester.pumpWidget(RPNCalculatorApp());

    await tester.tap(find.text('5'));
    await tester.pump();
    await tester.tap(find.text('3'));
    await tester.pump();
    await tester.tap(find.text('Enter'));
    await tester.pump();

    await tester.tap(find.text('2'));
    await tester.pump();
    await tester.tap(find.text('-'));
    await tester.pump();

    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('Test RPN Calculator Clearing Stack', (WidgetTester tester) async {
    await tester.pumpWidget(RPNCalculatorApp());

    await tester.tap(find.text('1'));
    await tester.pump();
    await tester.tap(find.text('2'));
    await tester.pump();
    await tester.tap(find.text('Enter'));
    await tester.pump();

    await tester.tap(find.text('3'));
    await tester.pump();
    await tester.tap(find.text('C'));
    await tester.pump();

    expect(find.text('0'), findsOneWidget);
  });
}
