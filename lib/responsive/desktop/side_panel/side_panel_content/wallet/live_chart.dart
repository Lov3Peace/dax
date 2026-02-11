import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';

class LiveChartController {
  static const int maxPoints = 100;

  final ValueNotifier<List<FlSpot>> points = ValueNotifier<List<FlSpot>>([]);

  double _x = 0;

  /// Add a new price point (y = price)
  void addPrice(double price) {
    final next = List<FlSpot>.from(points.value)..add(FlSpot(_x++, price));

    // 🔒 Hard cap at 100 points
    if (next.length > maxPoints) {
      next.removeRange(0, next.length - maxPoints);
    }

    points.value = next;
  }

  /// Reset when switching asset or range
  void reset() {
    _x = 0;
    points.value = [];
  }

  void dispose() {
    points.dispose();
  }
}
