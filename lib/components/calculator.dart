import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleCalculator(
      hideExpression: true,
      theme: CalculatorThemeData(),
    );
  }
}
