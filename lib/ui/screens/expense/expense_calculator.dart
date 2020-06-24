import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:expressions/expressions.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart' as intl;
import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/ui/config/config.dart';

class ExpenseCalculator extends StatefulWidget {
  const ExpenseCalculator({
    Key key,
  }) : super(key: key);
  @override
  _ExpenseCalculatorState createState() => _ExpenseCalculatorState();
}

class _ExpenseCalculatorState extends State<ExpenseCalculator> {
  double value;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var temp = value;
    value = Provider.of<ExpenseViewModel>(context).tempRecord.value;
  }

  @override
  Widget build(BuildContext context) {
    print('ExpensesCalculator build() was called.');
    return Consumer<ExpenseViewModel>(
      builder: (context, model, child) {
        return SimpleCalculator(
            value: value,
            hideExpression: true,
            theme: CalculatorThemeData(
                borderWidth: 0.0,
                operatorColor: Colors.grey[500],
                displayColor: kBlack),
            onChanged: (key, value, expression) {
              print(key);
              print(value);
              print(expression);
              double temp = model.tempRecord.value;
              model.changeValue(value);
              print(
                  "Temp Record value changed: $temp -> ${model.tempRecord.value} ");
            });
      },
    );
  }
}

// Copyright 2019 zuvola. All rights reserved.

/// Display value for the [Calculator].
class CalcDisplay {
  String string;
  double value;

  /// The [NumberFormat] used for display
  final NumberFormat numberFormat;

  /// Maximum number of digits on display.
  final int maximumDigits;

  CalcDisplay(this.numberFormat, this.maximumDigits) {
    clear();
  }

  /// Add a digit to the display.
  void addDigit(int digit) {
    var reg = RegExp(
        "[${numberFormat.symbols.GROUP_SEP}${numberFormat.symbols.DECIMAL_SEP}]");
    if (string.replaceAll(reg, "").length >= maximumDigits) {
      return;
    }
    if (string == numberFormat.symbols.ZERO_DIGIT) {
      string = numberFormat.format(digit);
    } else {
      string += numberFormat.format(digit);
    }
    _reformat();
  }

  /// Add a decimal point.
  void addPoint() {
    if (string.contains(numberFormat.symbols.DECIMAL_SEP)) {
      return;
    }
    string += numberFormat.symbols.DECIMAL_SEP;
  }

  /// Clear value to zero.
  void clear() {
    string = numberFormat.symbols.ZERO_DIGIT;
    value = 0;
  }

  /// Remove the last digit.
  void removeDigit() {
    if (string.length == 1 ||
        (string.startsWith(numberFormat.symbols.MINUS_SIGN) &&
            string.length == 2)) {
      clear();
    } else {
      string = string.substring(0, string.length - 1);
      _reformat();
    }
  }

  /// Set the value.
  void setValue(double val) {
    value = val;
    print('INSIDE CalcDisplay - setValue value: $value');
    string = numberFormat.format(val);
    print('INSIDE CalcDisplay - setValue string: $string');
  }

  /// Toggle between a plus sign and a minus sign.
  void toggleSign() {
    if (value <= 0) {
      string = string.replaceFirst(numberFormat.symbols.MINUS_SIGN, "");
    } else {
      string = numberFormat.symbols.MINUS_SIGN + string;
    }
    _reformat();
  }

  /// Check the validity of the displayed value.
  bool validValue() {
    return !(string == numberFormat.symbols.NAN ||
        string == numberFormat.symbols.INFINITY);
  }

  void _reformat() {
    value = numberFormat.parse(string);
    if (!string.contains(numberFormat.symbols.DECIMAL_SEP)) {
      string = numberFormat.format(value);
    }
  }
}

/// Expression for the [Calculator].
class CalcExpression {
  final ExpressionEvaluator evaluator = const ExpressionEvaluator();
  final String zeroDigit;

  String value = "";
  String internal = "";
  String _op;
  String _right;
  String _rightInternal;
  String _left;
  String _lefInternal;

  /// Create a [CalcExpression] with [zeroDigit].
  CalcExpression({this.zeroDigit = "0"});

  void clear() {
    value = "";
    internal = "";
    _op = null;
    _right = null;
    _left = null;
    _lefInternal = null;
    _rightInternal = null;
  }

  bool needClearDisplay() {
    return _op != null && _right == null;
  }

  /// Perform operations.
  num operate() {
    try {
      return evaluator.eval(Expression.parse(internal), null);
    } catch (e) {
      print(e);
    }
    return double.nan;
  }

  void repeat(CalcDisplay val) {
    if (_right != null) {
      _left = value = val.string;
      _lefInternal = internal = val.value.toString();
      value = "$_left $_op $_right";
      internal = "$_lefInternal${_convertOperator()}$_rightInternal";
      val.setValue(operate());
    }
  }

  /// Set the operation. The [op] must be either +, -, ×, or ÷.
  void setOperator(String op) {
    if (_left == null) {
      _left = _lefInternal = zeroDigit;
    }
    if (_right != null) {
      _left = "$_left $_op $_right";
      _lefInternal = "$_lefInternal${_convertOperator()}$_rightInternal";
      _right = _rightInternal = null;
    }
    _op = op;
    value = "$_left $_op ?";
  }

  /// Set percent value. The [string] is a string representation and [percent] is a value.
  double setPercent(String string, double percent) {
    var base = 1.0;
    if (_op == "+" || _op == "-") {
      base = evaluator.eval(Expression.parse(_lefInternal), null);
    }
    var val = base * percent / 100;
    if (_op == null) {
      _left = value = string;
      _lefInternal = internal = val.toString();
      return val;
    } else {
      _right = string;
      _rightInternal = val.toString();
      value = "$_left $_op $_right";
      internal = "$_lefInternal${_convertOperator()}$val";
      return val;
    }
  }

  /// Set value with [CalcDisplay].
  void setVal(CalcDisplay val) {
    if (_op == null) {
      _left = value = val.string;
      _lefInternal = internal = val.value.toString();
    } else {
      _right = val.string;
      _rightInternal = val.value.toString();
      value = "$_left $_op $_right";
      internal = "$_lefInternal${_convertOperator()}$_rightInternal";
    }
  }

  String _convertOperator() {
    return _op.replaceFirst("×", "*").replaceFirst("÷", "/");
  }
}

/// Calculator
class Calculator {
  final CalcExpression _expression;
  final CalcDisplay _display;
  bool _operated = false;

  /// The [NumberFormat] used for display
  final NumberFormat numberFormat;

  /// Maximum number of digits on display.
  final int maximumDigits;

  /// Create a [Calculator] with [maximumDigits] is 10 and maximumFractionDigits of [numberFormat] is 6.
  Calculator({maximumDigits = 10})
      : this.numberFormat(
            NumberFormat()..maximumFractionDigits = 6, maximumDigits);

  /// Create a [Calculator].
  Calculator.numberFormat(this.numberFormat, this.maximumDigits)
      : _expression =
            CalcExpression(zeroDigit: numberFormat.symbols.ZERO_DIGIT),
        _display = CalcDisplay(numberFormat, maximumDigits);

  /// Display string
  get displayString => _display.string;

  /// Display value
  get displayValue => _display.value;

  /// Expression
  get expression => _expression.value;

  /// Set the value.
  void setValue(double val) {
    allClear();
    _operated = false;
    _display.setValue(val);
    _expression.setVal(_display);
    print('INSIDE CALCULATOR: ${_display.value}');
  }

  /// Add a digit to the display.
  void addDigit(int digit) {
    if (!_display.validValue()) {
      return;
    }
    if (_expression.needClearDisplay()) {
      _display.clear();
    }
    if (_operated) {
      allClear();
      _operated = false;
    }
    _display.addDigit(digit);
    _expression.setVal(_display);
  }

  /// Add a decimal point.
  void addPoint() {
    if (!_display.validValue()) {
      return;
    }
    if (_expression.needClearDisplay()) {
      _display.clear();
    }
    if (_operated) {
      allClear();
      _operated = false;
    }
    _display.addPoint();
    _expression.setVal(_display);
  }

  /// Clear all entries.
  void allClear() {
    _expression.clear();
    _display.clear();
    _expression.setVal(_display);
  }

  /// Clear last entry.
  void clear() {
    _display.clear();
    _expression.setVal(_display);
  }

  /// Perform operations.
  void operate() {
    if (!_display.validValue()) {
      return;
    }
    if (_operated) {
      _expression.repeat(_display);
    } else {
      _display.setValue(_expression.operate());
    }
    _operated = true;
  }

  /// Remove the last digit.
  void removeDigit() {
    if (_check()) return;
    _display.removeDigit();
    _expression.setVal(_display);
  }

  /// Set the operation. The [op] must be either +, -, ×, or ÷.
  void setOperator(String op) {
    if (_check()) return;
    _expression.setOperator(op);
    if (op == "+" || op == "-") {
      operate();
      _operated = false;
    }
  }

  /// Set a percent sign.
  void setPercent() {
    if (_check()) return;
    var string = _display.string + numberFormat.symbols.PERCENT;
    var val = _expression.setPercent(string, _display.value);
    _display.setValue(val);
  }

  /// Toggle between a plus sign and a minus sign.
  void toggleSign() {
    if (_check()) return;
    _display.toggleSign();
    _expression.setVal(_display);
  }

  ///
  bool _check() {
    if (!_display.validValue()) {
      return true;
    }
    if (_operated) {
      _expression.clear();
      _expression.setVal(_display);
      _operated = false;
    }
    return false;
  }
}

/// Signature for callbacks that report that the [SimpleCalculator] value has changed.
typedef CalcChanged = void Function(
    String key, double value, String expression);

/// Holds the color and typography values for the [SimpleCalculator].
class CalculatorThemeData {
  /// The color to use when painting the line.
  final Color borderColor;

  /// Width of the divider border, which is usually 1.0.
  final double borderWidth;

  /// The color of the display panel background.
  final Color displayColor;

  /// The background color of the expression area.
  final Color expressionColor;

  /// The background color of operator buttons.
  final Color operatorColor;

  /// The background color of command buttons.
  final Color commandColor;

  /// The background color of number buttons.
  final Color numColor;

  /// The text style to use for the display panel.
  final TextStyle displayStyle;

  /// The text style to use for the expression area.
  final TextStyle expressionStyle;

  /// The text style to use for operator buttons.
  final TextStyle operatorStyle;

  /// The text style to use for command buttons.
  final TextStyle commandStyle;

  /// The text style to use for number buttons.
  final TextStyle numStyle;

  const CalculatorThemeData(
      {this.displayColor,
      this.borderWidth = 1.0,
      this.expressionColor,
      this.borderColor,
      this.operatorColor,
      this.commandColor,
      this.numColor,
      this.displayStyle,
      this.expressionStyle,
      this.operatorStyle,
      this.commandStyle,
      this.numStyle});
}

/// SimpleCalculator
///
/// {@tool sample}
///
/// This example shows a simple [SimpleCalculator].
///
/// ```dart
/// SimpleCalculator(
///   value: 123.45,
///   hideExpression: true,
///   onChanged: (key, value, expression) {
///     /*...*/
///   },
///   theme: const CalculatorThemeData(
///     displayColor: Colors.black,
///     displayStyle: const TextStyle(fontSize: 80, color: Colors.yellow),
///   ),
/// )
/// ```
/// {@end-tool}
///
class SimpleCalculator extends StatefulWidget {
  /// Visual properties for this widget.
  final CalculatorThemeData theme;

  /// Whether to show surrounding borders.
  final bool hideSurroundingBorder;

  /// Whether to show expression area.
  final bool hideExpression;

  /// The value currently displayed on this calculator.
  final double value;

  /// Called when the button is tapped or the value is changed.
  final CalcChanged onChanged;

  /// The [NumberFormat] used for display
  final intl.NumberFormat numberFormat;

  /// Maximum number of digits on display.
  final int maximumDigits;

  const SimpleCalculator({
    Key key,
    this.theme,
    this.hideExpression = false,
    this.value,
    this.onChanged,
    this.numberFormat,
    this.maximumDigits = 10,
    this.hideSurroundingBorder = false,
  }) : super(key: key);

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String _displayValue;
  String _expression = "";
  String _acLabel = "AC";
  BorderSide _borderSide;
  Calculator _calc;
  int _catId = 0;
  int _accId = 0;

  final List<String> _nums = new List(10);
  final _baseStyle = const TextStyle(
    fontSize: 26,
  );

  @override
  Widget build(BuildContext context) {
    print("SimpleCalculator build() was called.");
    _borderSide = Divider.createBorderSide(
      context,
      color: widget.theme?.borderColor ?? Theme.of(context).dividerColor,
      width: widget.theme?.borderWidth ?? 1.0,
    );
    return Consumer<ExpenseViewModel>(
      builder: (context, model, child) {
        if (model.isScanned) {
          _displayValue = model.tempRecord.value.toString();
          model.toggleScanned();
        }
        _catId = model.tempRecord.categoryId;
        Account account =
            model.userData.getThisAccount(model.tempRecord.accountUid);
        _accId = model.isEditing ? account.index : _accId;
        return Column(children: <Widget>[
          Expanded(child: _getDisplay(model), flex: 3),
          Expanded(child: _getButtons(), flex: 4),
        ]);
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_calc != null) return;
    if (widget.numberFormat == null) {
      var myLocale = Localizations.localeOf(context);
      var nf = intl.NumberFormat.decimalPattern(myLocale.toLanguageTag())
        ..maximumFractionDigits = 6;
      _calc = Calculator.numberFormat(nf, widget.maximumDigits);
    } else {
      _calc =
          Calculator.numberFormat(widget.numberFormat, widget.maximumDigits);
    }
    for (var i = 0; i < 10; i++) {
      _nums[i] = _calc.numberFormat.format(i);
    }
    _calc.setValue(widget.value);
    _displayValue = _calc.displayString;
  }

  Widget _getButtons() {
    return GridButton(
      textStyle: _baseStyle,
      borderColor: _borderSide.color,
      hideSurroundingBorder: widget.hideSurroundingBorder,
      borderWidth: widget.theme?.borderWidth,
      onPressed: (dynamic val) {
        var acLabel;
        switch (val) {
          case "→":
            _calc.removeDigit();
            break;
          case "±":
            _calc.toggleSign();
            break;
          case "+":
          case "-":
          case "×":
          case "÷":
            _calc.setOperator(val);
            break;
          case "=":
            _calc.operate();
            acLabel = "AC";
            break;
          case "AC":
            _calc.allClear();
            break;
          case "C":
            _calc.clear();
            acLabel = "AC";
            break;
          default:
            if (val == _calc.numberFormat.symbols.DECIMAL_SEP) {
              _calc.addPoint();
              acLabel = "C";
            }
            if (val == _calc.numberFormat.symbols.PERCENT) {
              _calc.setPercent();
            }
            if (_nums.contains(val)) {
              _calc.addDigit(_nums.indexOf(val));
            }
            acLabel = "C";
        }
        if (widget.onChanged != null) {
          widget.onChanged(val, _calc.displayValue, _calc.expression);
        }
        setState(() {
          _displayValue = _calc.displayString;
          _expression = _calc.expression;
          _acLabel = acLabel ?? _acLabel;
        });
      },
      items: _getItems(),
    );
  }

  Widget _getDisplay(ExpenseViewModel model) {
    List<bool> isSelected() {
      return model.tempRecord.isIncome ? [false, true] : [true, false];
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: widget.hideSurroundingBorder ? BorderSide.none : _borderSide,
          left: widget.hideSurroundingBorder ? BorderSide.none : _borderSide,
          right: widget.hideSurroundingBorder ? BorderSide.none : _borderSide,
          bottom: widget.hideSurroundingBorder ? BorderSide.none : _borderSide,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              color: widget.theme?.displayColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: Text(
                        "\$",
                        style: widget.theme?.displayStyle ??
                            const TextStyle(fontSize: 60, color: Colors.white),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 300.0),
                        child: AutoSizeText(
                          _displayValue,
                          style: widget.theme?.displayStyle ??
                              TextStyle(fontSize: 60, color: Colors.white),
                          maxLines: 1,
                          stepGranularity: 10,
                          minFontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: widget.theme?.displayColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ToggleButtons(
                        constraints:
                            BoxConstraints.expand(width: 70, height: 50),
                        borderRadius: BorderRadius.circular(10.0),
                        fillColor: isSelected()[0]
                            ? Colors.red[600]
                            : Colors.green[600],
                        selectedColor: Colors.white,
                        children: <Widget>[
                          Text('EXPENSE'),
                          Text('INCOME'),
                        ],
                        isSelected: isSelected(),
                        onPressed: (value) {
                          setState(() {
                            if (value == 1) {
                              model.changeCategory(7);
                              model.tempRecord.isIncome = true;
                            } else {
                              if (model.tempRecord.categoryId == 7) {
                                model.changeCategory(0);
                              }
                              model.tempRecord.isIncome = false;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: PopupMenuButton(
                      initialValue: model.tempRecord.categoryId,
                      onSelected: (input) {
                        setState(() {
                          _catId = input;
                          model.changeCategory(_catId);
                          model.tempRecord.isIncome =
                              _catId == 7 ? true : false;
                        });
                      },
                      itemBuilder: (context) {
                        List<String> categoryTitles =
                            categories.map((e) => e.title).toList();
                        return categoryTitles
                            .map(
                              (e) => PopupMenuItem(
                                value: categoryTitles.indexOf(e),
                                child: ListTile(
                                  leading: categories[categoryTitles.indexOf(e)]
                                      .icon,
                                  title: Text(e),
                                ),
                              ),
                            )
                            .toList();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Category',
                            style: TextStyle(
                              color: Colors.blueGrey[200],
                              fontSize: 12.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            categories[_catId].title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: PopupMenuButton(
                      initialValue: model.tempRecord.accountUid,
                      onSelected: (input) {
                        setState(() {
                          _accId = input;
                          model.changeAccount(_accId);
                        });
                      },
                      itemBuilder: (context) {
                        List<Account> accounts = model.userData.accounts;
                        return accounts
                            .map(
                              (e) => PopupMenuItem(
                                value: e.index,
                                child: ListTile(
                                  title: Text(e.title),
                                ),
                              ),
                            )
                            .toList();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Account',
                            style: TextStyle(
                              color: Colors.blueGrey[200],
                              fontSize: 12.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            model.userData.accounts[_accId].title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: !widget.hideExpression,
            child: Expanded(
              child: Container(
                color: widget.theme?.expressionColor,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(
                      _expression,
                      style: widget.theme?.expressionStyle ??
                          const TextStyle(color: Colors.grey),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<List<GridButtonItem>> _getItems() {
    return [
      [_acLabel, "→", _calc.numberFormat.symbols.PERCENT, "÷"],
      [_nums[7], _nums[8], _nums[9], "×"],
      [_nums[4], _nums[5], _nums[6], "-"],
      [_nums[1], _nums[2], _nums[3], "+"],
      [_calc.numberFormat.symbols.DECIMAL_SEP, _nums[0], "", "="],
    ].map((items) {
      return items.map((title) {
        Color color =
            widget.theme?.numColor ?? Theme.of(context).scaffoldBackgroundColor;
        TextStyle style = widget.theme?.numStyle;
        if (title == "=" ||
            title == "+" ||
            title == "-" ||
            title == "×" ||
            title == "÷") {
          color = widget.theme?.operatorColor ?? Theme.of(context).primaryColor;
          style = widget.theme?.operatorStyle ??
              _baseStyle.copyWith(
                  color: Theme.of(context).primaryTextTheme.headline6.color);
        }
        if (title == _calc.numberFormat.symbols.PERCENT ||
            title == "→" ||
            title == "C" ||
            title == "AC") {
          color = widget.theme?.commandColor ?? Theme.of(context).splashColor;
          style = widget.theme?.commandStyle;
        }
        return GridButtonItem(
          title: title,
          color: color,
          textStyle: style,
        );
      }).toList();
    }).toList();
  }
}
