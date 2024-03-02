import 'package:flutter/material.dart';
import 'package:rpn_calculator/rpn_calculator.dart';

void main() {
  runApp(RPNCalculatorApp());
}

class RPNCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPN Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  RPNCalculator calculator = RPNCalculator();
  String display = '';
  List<String> stackItems = [];

  void _onNumberPressed(String digit) {
    setState(() {
      display += digit; // Accumulate digits
    });
  }

  void _onOperationPressed(Command command) {
    setState(() {
      if (display.isNotEmpty) {
        // If there's a number in the display, push it onto the stack
        calculator.push(double.parse(display));
        display = '';
      }
      if (calculator.stack.length >= 2) {
        // Apply the operation to the first two numbers in the stack
        num operand2 = calculator.stack.removeLast();
        num operand1 = calculator.stack.removeLast();
        num result = command.apply([operand1, operand2]);
        // Clear the display as the result will be added to the stack
        display = '';
        // Push the result back onto the stack
        calculator.push(result);
      }
      // Concatenate the stack items into a single string
      stackItems = [calculator.stack.join(", ")];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RPN Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            display,
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(height: 20.0),
          Wrap(
            spacing: 8.0,
            children: stackItems
                .map((item) => Chip(
              label: Text(item),
              backgroundColor: Colors.grey[300],
            ))
                .toList(),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton('1'),
              _buildNumberButton('2'),
              _buildNumberButton('3'),
              _buildOperationButton(AddCommand(), '+'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton('4'),
              _buildNumberButton('5'),
              _buildNumberButton('6'),
              _buildOperationButton(SubtractCommand(), '-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton('7'),
              _buildNumberButton('8'),
              _buildNumberButton('9'),
              _buildOperationButton(DivideCommand(), '/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton('0'),
              _buildEnterButton(),
              _buildClearButton(),
              _buildOperationButton(MultiplyCommand(), '*'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return ElevatedButton(
      onPressed: () => _onNumberPressed(number),
      child: Text(number),
    );
  }

  Widget _buildOperationButton(Command command, String symbol) {
    return ElevatedButton(
      onPressed: () {
        if (display.isNotEmpty) {
          calculator.push(double.parse(display));
          stackItems.add(display);
          display = '';
        }
        _onOperationPressed(command);
      },
      child: Text(symbol),
    );
  }

  Widget _buildEnterButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (display.isNotEmpty) {
            calculator.push(double.parse(display));
            stackItems.add(display);
            display = '';
          }
        });
      },
      child: Text('Enter'),
    );
  }

  Widget _buildClearButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          display = '';
          calculator.stack.clear();
          stackItems.clear();
        });
      },
      child: Text('C'),
    );
  }
}
