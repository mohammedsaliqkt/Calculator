import 'dart:developer';

import 'package:math_expressions/math_expressions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calc_provider.g.dart';

@riverpod
class Calc extends _$Calc {
  @override
  String build() => '0';

  List symbols = ['%', '÷', 'x', '-', '+'];
  // add values
  void addValue({required String str}) {
    List currentState = state.split('');
    if (currentState.length == 1 && currentState[0] == '0') {
      state = str;
    } else if (symbols.contains(currentState[currentState.length - 1]) &&
        symbols.contains(str)) {
      state = state.substring(0, state.length - 1) + str;
      // state = state + str;
    } else {
      state = state + str;
    }
  }

// clear the last value
  void removeLastValue() {
    state.isNotEmpty
        ? state = state.substring(0, state.length - 1)
        : state = '0';
  }

// clear Values
  void clearAllValue() {
    state = '0';
  }

  // evaluation method
  void evaluateState() {
    List newList = state.split('');
    if (symbols.contains(newList[newList.length - 1])) {
      removeLastValue();
    } else {
      // replace symbols with correct operators
      state = state.replaceAll('-', '-');
      state = state.replaceAll('÷', '/');
      state = state.replaceAll('x', '*');
      // Createing the expression via the parser
      Parser p = Parser();
      Expression exp = p.parse(state);
      // Bind variables:
      ContextModel cm = ContextModel();
      double value = exp.evaluate(EvaluationType.REAL, cm);
      state = value.toStringAsFixed(2);
    }
  }

// specify the method upto the button
  buttonEvent({required String str}) {
    switch (str) {
      case 'AC':
        clearAllValue();
        break;
      case '⌫':
        removeLastValue();
        break;
      case '-':
        addValue(str: '-');
        break;
      case '÷':
        addValue(str: "/");
        break;
      case 'x':
        addValue(str: "*");
        break;
      case 'C':
        clearAllValue();
        break;
      case '=':
        evaluateState();
        break;
      default:
        addValue(str: str);
        break;
    }
  }
}
