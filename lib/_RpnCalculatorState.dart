import 'package:flutter/material.dart';
import 'RPNCalculator.dart';

class RpnCalculator extends StatefulWidget {
  @override
  _RpnCalculatorState createState() => _RpnCalculatorState();
}

class _RpnCalculatorState extends State<RpnCalculator> {
  final RPNCalculator _calculator = RPNCalculator(); // Initialize RPNCalculator
  String _input = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _input = '';
        _calculator.clear(); // Clear the calculator when 'C' is pressed
      } else if (buttonText == 'Enter') {
        _calculate();
      } else {
        _input += buttonText;
      }
    });
  }

  void _calculate() {
    // Pass input to calculator and display result
    try {
      final result = double.parse(_input);
      _calculator.enterNumber(result);
      _input = '';
    } catch (e) {
      print('Invalid input: $_input');
      _input = '';
      return;
    }

    setState(() {
      _input = _calculator.peek().toString();
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
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                _input,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          Divider(),
          Expanded(
            flex: 2,
            child: GridView.count(
              crossAxisCount: 4,
              children: [
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('/'),
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildButton('*'),
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('-'),
                _buildButton('C'),
                _buildButton('0'),
                _buildButton('Enter'),
                _buildButton('+'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return GestureDetector(
      onTap: () => _onButtonPressed(buttonText),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: buttonText == 'Enter' ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
