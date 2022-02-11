import 'package:expensify/models/pie_data.dart';
import 'package:expensify/widgets/pie_chart_widgets/indicators_widget.dart';
import 'package:expensify/widgets/pie_chart_widgets/pie_chart_sections.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyPieChart extends StatefulWidget {
  final List<PieData> pieData;

  const MyPieChart({
    Key key,
    this.pieData,
  }) : super(key: key);

  @override
  _MyPieChartState createState() => _MyPieChartState();
}

class _MyPieChartState extends State<MyPieChart> {
  int touchedIndex;
  @override
  Widget build(BuildContext context) {
    final screenWidht = MediaQuery.of(context).size.width;
    return Expanded(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Analysis',
                  style: TextStyle(
                      color: Colors.white, //Color(0xff0f4a3c),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'proximasoftbold'),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Last Seven Days',
                  style: TextStyle(
                      color: Colors.white, //const Color(0xff379982),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'proximasoftbold'),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 300,
                  color: Colors.black,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (pieTouchResponse) {
                          setState(() {
                            if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                pieTouchResponse.touchInput is FlPanEnd) {
                              touchedIndex = -1;
                            } else {
                              touchedIndex =
                                  pieTouchResponse.touchedSectionIndex;
                            }
                          });
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: getSections(
                          touchedIndex, widget.pieData, screenWidht),
                    ),
                  ),
                ),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  direction: Axis.horizontal,
                  children: [
                    IndicatorsWidget(
                      pieData: widget.pieData,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
