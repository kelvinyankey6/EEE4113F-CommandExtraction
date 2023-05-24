import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class LineChartDisplay extends StatefulWidget {

  final List<LineChartDataPoint> points;

  const LineChartDisplay({super.key, required this.points});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LineChartDisplay();
  }


}

class LineChartDataPoint {
  final DateTime date;
  final double value;

  LineChartDataPoint(this.date, this.value);
}


class _LineChartDisplay extends State<LineChartDisplay> {

  double _minX = 0;
  double _maxX = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AspectRatio(
        aspectRatio: 1.7,
        child: LineChart(
            LineChartData(
                lineBarsData: [LineChartBarData(
                  spots: getData(),
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                )],
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                      sideTitles: _bottomTitles()
                  ),
                  leftTitles: AxisTitles(
                      sideTitles: _leftTitles()
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false
                    )
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false
                    )
                  )
                ),
                gridData: FlGridData(
                    show: false,
                    drawVerticalLine: false,
                    drawHorizontalLine: false
                ),

                maxY: 60,
                minY: 0



            )
        )
    );
  }

  List<FlSpot> getData() {
    return widget.points.map((e) {
      var mili = e.date.millisecondsSinceEpoch.toDouble();
      if (mili > _maxX) {
        _maxX = mili;
      } else if (mili < _minX) {
        _minX = mili;
      }

      return FlSpot(mili, e.value);
    },).toList();
  }

  SideTitles _bottomTitles() {
    return SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
        return Text(DateFormat.s().format(date), style: const TextStyle(
            color: Colors.black,
            fontSize: 14
        ),);
      },

    );
  }


  SideTitles _leftTitles() {
    return SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        return Container();
      },
    );
  }


}