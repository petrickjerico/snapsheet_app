import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/archive/temp_data.dart';

class NewCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TempData>(builder: (context, tempData, child) {
      return SimpleCalculator(
        // I just realised Simple Calculator takes this as a parameter:
        onChanged: (key, value, expression) {
          print(key);
          print(value);
          print(expression);

          // TempData works just like UserData, but only holds one variable:
          // double dummyVar
          double temp = tempData.dummyVar;
          tempData.changeValue(value);
          print('value changed: $temp -> ${tempData.dummyVar}');
        },
      );
    });
  }
}
