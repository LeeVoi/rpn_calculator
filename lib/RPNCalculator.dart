import 'dart:collection';
import 'dart:math' as math;

class RPNCalculator {
  final ListQueue<double> _stack = ListQueue<double>();

  void enterNumber(double number) {
    _stack.addLast(number);
  }

  void applyOperator(String operator) {
    if (_stack.length < 2) {
      print('Insufficient operands for $operator');
      return;
    }

    final double operand2 = _stack.removeLast();
    final double operand1 = _stack.removeLast();

    switch (operator) {
      case '+':
        _stack.addLast(operand1 + operand2);
        break;
      case '-':
        _stack.addLast(operand1 - operand2);
        break;
      case '*':
        _stack.addLast(operand1 * operand2);
        break;
      case '/':
        if (operand2 == 0) {
          print('Cannot divide by zero');
          _stack.addLast(operand1);
          _stack.addLast(operand2);
        } else {
          _stack.addLast(operand1 / operand2);
        }
        break;
      default:
        print('Invalid operator: $operator');
        _stack.addLast(operand1);
        _stack.addLast(operand2);
        break;
    }
  }

  void undo() {
    if (_stack.isNotEmpty) {
      _stack.removeLast();
    } else {
      print('Stack is empty, nothing to undo.');
    }
  }

  double peek() {
    if (_stack.isEmpty) {
      print('Stack is empty');
      return double.nan;
    }
    return _stack.last;
  }

  void clear() {
    _stack.clear();
  }
}

void main() {
  final calculator = RPNCalculator();

  calculator.enterNumber(3);
  calculator.enterNumber(4);
  calculator.applyOperator('-');
  calculator.enterNumber(5);
  calculator.applyOperator('+');
  print(calculator.peek()); // Output: 4.0

  calculator.clear();

  calculator.enterNumber(3);
  calculator.enterNumber(4);
  calculator.enterNumber(5);
  calculator.applyOperator('*');
  calculator.applyOperator('+');
  print(calculator.peek()); // Output: 23.0

  calculator.undo();
  print(calculator.peek()); // Output: 0.0
}
