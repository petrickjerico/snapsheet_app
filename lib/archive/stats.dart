import 'package:charts_flutter/flutter.dart' as charts;
import 'package:random_color/random_color.dart';

class Stats {
  String title;
  double value;
  charts.Color color;
  static RandomColor _randomColor = RandomColor();

  Stats(this.title, this.value)
      : this.color = charts.ColorUtil.fromDartColor(
            _randomColor.randomColor(colorHue: ColorHue.blue));
}
