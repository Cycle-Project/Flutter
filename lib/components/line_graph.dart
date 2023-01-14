import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PointLine {
  final double x;
  final double y;

  PointLine({required this.x, required this.y});
}

class LineChartWidget extends StatelessWidget {
  final List<PointLine> points;

  const LineChartWidget({Key? key, required this.points}) : super(key: key);

  double maxY() {
    double max = points[0].y;
    if (points.length > 1) {
      for (var i = 1; i < points.length; i++) {
        double y = points[i].y;
        max = y > max ? y : max;
      }
    }
    return max;
  }

  double minY() {
    double min = points[0].y;
    if (points.length > 1) {
      for (var i = 1; i < points.length; i++) {
        double y = points[i].y;
        min = y < min ? y : min;
      }
    }
    return min;
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontSize: 16);
    return AspectRatio(
      aspectRatio: 2,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Column(
              children: [
                Text(maxY().ceil().toString(), style: style),
                const Spacer(),
                Text(minY().floor().toString(), style: style),
              ],
            ),
          ),
          Expanded(
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: points
                        .map((point) => FlSpot(point.x, point.y))
                        .toList(),
                    isCurved: false,
                    dotData: FlDotData(show: false),
                  ),
                ],
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData:
                    FlBorderData(border: const Border(left: BorderSide())),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
