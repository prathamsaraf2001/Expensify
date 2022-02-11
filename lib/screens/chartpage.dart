import 'package:expensify/models/pie_data.dart';
import 'package:expensify/screens/statistics/pie_chart.dart';
import 'package:expensify/screens/statistics/weekly_stats.dart';
import 'package:expensify/screens/statistics/yearly_stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/transaction.dart';
import './transactions/daily_spendings.dart';
import './transactions/monthly_spendings.dart';
import './transactions/yearly_spendings.dart';
import '../widgets/app_drawer.dart';
import './new_transaction.dart';
import './transactions/weekly_spendings.dart';
import 'home_screen.dart';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage>
    with SingleTickerProviderStateMixin {
  String _selectedYear = DateFormat('yyyy').format(DateTime.now());
  String dropdownValue = DateFormat('MMM').format(DateTime.now());
  Transactions trxData;
  List<PieData> yearlyData;
  TabController tabController;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    trxData = Provider.of<Transactions>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final monthlyTrans = Provider.of<Transactions>(context)
        .monthlyTransactions(dropdownValue, _selectedYear);
    final List<PieData> monthlyData = PieData().pieChartData(monthlyTrans);
    final recentTransaction =
        Provider.of<Transactions>(context, listen: false).rescentTransactions;
    final recentData = PieData().pieChartData(recentTransaction);
    final yearlyTrans = Provider.of<Transactions>(context, listen: false)
        .yearlyTransactions(_selectedYear);

    final List<PieData> yearlyData = PieData().pieChartData(yearlyTrans);

    // bool checkForEmpty(List<Map<String, Object>> groupTrans) {
    //   return groupTrans.every((element) {
    //     if (element['amount'] == 0) {
    //       return true;
    //     }
    //     return false;
    //   });
    // }

    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: new TabBar(
        indicator: BoxDecoration(
            border: Border.all(
              width: 3,
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ), // Creates border
            color: Colors.lightBlueAccent[100]),
        unselectedLabelColor: Colors.grey,
        labelColor: Colors.blue[900],
        indicatorColor: Theme.of(context).primaryColorDark,
        tabs: <Widget>[
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              new Tab(
                text: "Weekly",
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              new Tab(
                text: "Monthly",
              ),
            ],
          ),
        ],
        controller: tabController,
      ),
      body: TabBarView(
        children: <Widget>[
          // WeaklyStats(),
          SingleChildScrollView(
              child: weaklyChart(context, recentTransaction, recentData)),
          MyPieChart(pieData: monthlyData),
          // monthlyCharts(),
        ],
        controller: tabController,
      ),
    );
  }

  Column weaklyChart(
    BuildContext context,
    List<Transaction> recentTransaction,
    List<PieData> recentData,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.lightBlueAccent,
              child: Container(
                decoration: BoxDecoration(
                    // border: Border.all(
                    //   width: 3,
                    //   color: Colors.blue,
                    // ),
                    ),
                width: double.infinity,
                child: MyPieChart(pieData: recentData),
              ),
            ),
          ),
        ),
        WeaklyStats(
          rescentTransactions: recentTransaction,
        )
      ],
    );
  }

  Widget weeklyCharts() => Column(
        children: [
          Container(
            height: 100,
            color: Colors.black,
          )
        ],
      );

  Widget monthlyCharts() => Column(
        children: [
          Container(
            color: Colors.black,
          )
        ],
      );

  Widget yearlyCharts() => Column(
        children: [
          Container(
            color: Colors.black,
          )
        ],
      );
}
