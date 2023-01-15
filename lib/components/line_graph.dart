import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PointLine {
  final double x;
  final double y;

  PointLine({required this.x, required this.y});
}

class LineChartWidget extends HookWidget {
  final List<PointLine> points;
  final Function(int) onTouch;

  const LineChartWidget({
    Key? key,
    required this.points,
    required this.onTouch,
  }) : super(key: key);

  double max(double a, double b) => a > b ? a : b;
  double min(double a, double b) => a < b ? a : b;

  double maxY() {
    int l = 0, r = points.length - 1;
    double maxValue = points[0].y;
    while (l < r) {
      int m = (l + r) ~/ 2;
      maxValue = max(maxValue, max(points[m].y, points[m + 1].y));
      if (points[m].y > points[m + 1].y) {
        r = m;
      } else {
        l = m + 1;
      }
    }
    return maxValue;
  }

  double minY() {
    int l = 0, r = points.length - 1;
    double minValue = points[0].y;
    while (l < r) {
      int m = (l + r) ~/ 2;
      minValue = min(minValue, min(points[m].y, points[m + 1].y));
      if (points[m].y < points[m + 1].y) {
        r = m;
      } else {
        l = m + 1;
      }
    }
    return minValue;
  }

  @override
  Widget build(BuildContext context) {
    final spotIndex = useState(0);
    const style = TextStyle(fontSize: 16);
    final lineBarsData = [
      LineChartBarData(
        isCurved: false,
        dotData: FlDotData(show: false),
        spots: points.map((p) => FlSpot(p.x, p.y)).toList(),
      ),
    ];

    touch(event, response) {
      if (response?.lineBarSpots != null && event is FlTapUpEvent) {
        spotIndex.value = response?.lineBarSpots?[0].spotIndex ?? 0;
        onTouch(spotIndex.value);
      }
    }

    return AspectRatio(
      aspectRatio: 2,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Column(
              children: [
                Text(maxY().floor().toString(), style: style),
                const Spacer(),
                Text(minY().floor().toString(), style: style),
              ],
            ),
          ),
          Expanded(
            child: LineChart(
              LineChartData(
                lineBarsData: lineBarsData,
                showingTooltipIndicators: [
                  ShowingTooltipIndicators([
                    LineBarSpot(
                      lineBarsData[0],
                      spotIndex.value,
                      lineBarsData[0].spots[spotIndex.value],
                    )
                  ])
                ],
                lineTouchData:
                    LineTouchData(enabled: true, touchCallback: touch),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
