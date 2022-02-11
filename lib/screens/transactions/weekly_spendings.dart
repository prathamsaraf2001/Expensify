import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:expensify/models/pie_data.dart';
import 'package:expensify/models/transaction.dart';
import 'package:expensify/screens/statistics/pie_chart.dart';
import 'package:expensify/screens/statistics/weekly_stats.dart';
import 'package:expensify/widgets/no_trancaction.dart';
import 'package:expensify/widgets/transaction_list_items.dart';

class WeeklySpendings extends StatefulWidget {
  @override
  _WeeklySpendingsState createState() => _WeeklySpendingsState();
}

class _WeeklySpendingsState extends State<WeeklySpendings> {
  bool _showChart = false;
  Transactions trxData;
  // List<Transaction> recentTransaction;
  // List<PieData> recentData;
  // Function deleteFn;

  @override
  void initState() {
    super.initState();

    trxData = Provider.of<Transactions>(context, listen: false);
    // recentTransaction =
    //     Provider.of<Transactions>(context, listen: false).rescentTransactions;

    // deleteFn =
    //     Provider.of<Transactions>(context, listen: false).deleteTransaction;

    // recentData = PieData().pieChartData(recentTransaction);
  }

  @override
  Widget build(BuildContext context) {
    final deleteFn = Provider.of<Transactions>(context).deleteTransaction;
    final recentTransaction =
        Provider.of<Transactions>(context, listen: false).rescentTransactions;
    final recentData = PieData().pieChartData(recentTransaction);
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          recentTransaction.isEmpty
              ? NoTransactions()
              : (_showChart
                  ? weaklyChart(context, recentTransaction, recentData)
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return TransactionListItems(
                            trx: recentTransaction[index],
                            dltTrxItem: deleteFn);
                      },
                      itemCount: recentTransaction.length,
                    ))
        ],
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
        Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          color: Theme.of(context).primaryColorDark,
          child: MyPieChart(pieData: recentData),
        ),
        WeaklyStats(
          rescentTransactions: recentTransaction,
        )
      ],
    );
  }
}
