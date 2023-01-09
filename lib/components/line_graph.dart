
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PointLine {
  final double x;
  final double y;

  PointLine({required this.x, required this.y});
}

class LineChartWidget extends StatelessWidget {
  List<PointLine> points;

  LineChartWidget(this.points, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(lineBarsData: [
          LineChartBarData(
            spots: points.map((point) => FlSpot(point.x, point.y)).toList(),
            isCurved: false,
            dotData: FlDotData(show: false),
          ),
        ]),
      ),
    );
  }
}
