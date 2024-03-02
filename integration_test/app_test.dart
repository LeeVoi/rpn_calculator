import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:rpn_calculator/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('RPN Calculator UI Integration Tests', () {

    testWidgets('Initial UI State Test', (WidgetTester tester) async {
      await tester.pumpWidget(RPNCalculatorApp());

      // Verify that the display is initially empty
      expect(find.text(''), findsOneWidget);

    });

    testWidgets('Number Entry Test', (WidgetTester tester) async {
      await tester.pumpWidget(RPNCalculatorApp());

      // Tap number buttons to enter numbers
      await tester.tap(find.byKey(ValueKey('number_button_2')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(ValueKey('number_button_3')));
      await tester.pumpAndSettle();

      // Verify that the numbers are displayed correctly
      expect(find.text('23'), findsOneWidget);
    });


    // I know this test is basically the same as the one above, but why not :)
    testWidgets('Number Button Tap Test', (WidgetTester tester) async {
      await tester.pumpWidget(RPNCalculatorApp());

      // Tap the number buttons '1', '2', '3'
      await tester.tap(find.text('1'));
      await tester.tap(find.text('2'));
      await tester.tap(find.text('3'));
      await tester.pump();

      // Verify that the display shows '123'
      expect(find.text('123'), findsOneWidget);
    });

    testWidgets('Enter Button Tap Test', (WidgetTester tester) async {
      // Pump the RPNCalculatorApp widget
      await tester.pumpWidget(RPNCalculatorApp());

      // Wait for the app to render
      await tester.pumpAndSettle();

      // Find the Enter button
      final enterButtonFinder = find.byKey( ValueKey('enter_button'));

      // Tap the Enter button
      await tester.tap(enterButtonFinder);

      // Wait for the button tap to be processed
      await tester.pumpAndSettle();

      // Expect that the number 0 is displayed after tapping Enter
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('Clear Button Test', (WidgetTester tester) async {
      await tester.pumpWidget(RPNCalculatorApp());

      // Tap number buttons to enter numbers
      await tester.tap(find.byKey(const ValueKey('number_button_2')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('number_button_3')));
      await tester.pumpAndSettle();

      // Tap the Clear button
      await tester.tap(find.byKey(const ValueKey('clear_button')));
      await tester.pumpAndSettle();

      // Verify that the display is empty
      expect(find.text(''), findsOneWidget);

      // Verify that the stack items are empty
      expect(find.byType(Chip), findsNothing);
    });
  });
}
