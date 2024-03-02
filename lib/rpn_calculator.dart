abstract class Command {
  num apply(List<num> stack);
}

class AddCommand implements Command {
  @override
  num apply(List<num> stack) {
    num operand2 = stack.removeLast();
    num operand1 = stack.removeLast();
    return operand1 + operand2;
  }
}

class SubtractCommand implements Command {
  @override
  num apply(List<num> stack) {
    num operand2 = stack.removeLast();
    num operand1 = stack.removeLast();
    return operand1 - operand2;
  }
}

class MultiplyCommand implements Command {
  @override
  num apply(List<num> stack) {
    num operand2 = stack.removeLast();
    num operand1 = stack.removeLast();
    return operand1 * operand2;

  }
}

class DivideCommand implements Command {
  @override
  num apply(List<num> operands) {
    num operand2 = operands.removeLast();
    num operand1 = operands.removeLast();
    return operand1 / operand2;
  }
}

class RPNCalculator {
  List<num> stack = [];

  void push(num value) {
    stack.add(value);
  }

  void execute(Command command) {
    command.apply(stack);
  }
}