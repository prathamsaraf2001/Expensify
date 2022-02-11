import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:expensify/models/pie_data.dart';
import 'package:expensify/models/transaction.dart';
import 'package:expensify/screens/statistics/pie_chart.dart';
import 'package:expensify/widgets/no_trancaction.dart';
import 'package:expensify/widgets/transaction_list_items.dart';

class DailySpendings extends StatefulWidget {
  @override
  _DailySpendingsState createState() => _DailySpendingsState();
}

class _DailySpendingsState extends State<DailySpendings> {
  bool _showChart = false;
  Transactions trxData;
  Function deleteFn;

  @override
  void initState() {
    super.initState();
    trxData = Provider.of<Transactions>(context, listen: false);

    deleteFn =
        Provider.of<Transactions>(context, listen: false).deleteTransaction;
  }

  @override
  Widget build(BuildContext context) {
    final dailyTrans = Provider.of<Transactions>(context).dailyTransactions();

    final List<PieData> dailyData = PieData().pieChartData(dailyTrans);

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          dailyTrans.isEmpty
              ? NoTransactions()
              : (_showChart
                  ? MyPieChart(pieData: dailyData)
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return TransactionListItems(
                            trx: dailyTrans[index], dltTrxItem: deleteFn);
                      },
                      itemCount: dailyTrans.length,
                    ))
        ],
      ),
    );
  }
}
