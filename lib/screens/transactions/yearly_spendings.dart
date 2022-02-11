import 'package:flutter/material.dart';

import 'package:expensify/models/pie_data.dart';
import 'package:expensify/models/transaction.dart';
import 'package:expensify/screens/statistics/pie_chart.dart';
import 'package:expensify/screens/statistics/yearly_stats.dart';
import 'package:expensify/widgets/no_trancaction.dart';
import 'package:expensify/widgets/transaction_list_items.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class YearlySpendings extends StatefulWidget {
  @override
  _YearlySpendingsState createState() => _YearlySpendingsState();
}

class _YearlySpendingsState extends State<YearlySpendings> {
  String _selectedYear = DateFormat('yyyy').format(DateTime.now());
  bool _showChart = false;
  Transactions trxData;
  // Function deleteFn;
  List<PieData> yearlyData;
  // List<Map<String, Object>> groupTransFirstSixMonths;
  // List<Map<String, Object>> groupTransLastSixMonths;
  // List<Transaction> yearlyTrans;

  @override
  void initState() {
    super.initState();
    trxData = Provider.of<Transactions>(context, listen: false);
    // deleteFn =
    //     Provider.of<Transactions>(context, listen: false).deleteTransaction;
    // yearlyTrans = Provider.of<Transactions>(context, listen: false)
    //     .yearlyTransactions(_selectedYear);

    // yearlyData = PieData().pieChartData(yearlyTrans);

    // groupTransFirstSixMonths = trxData.firstSixMonthsTransValues(
    //     yearlyTrans, int.parse(_selectedYear));
    // groupTransLastSixMonths =
    //     trxData.lastSixMonthsTransValues(yearlyTrans, int.parse(_selectedYear));
  }

  // bool checkForEmpty(List<Map<String, Object>> groupTrans) {
  //   return groupTrans.every((element) {
  //     if (element['amount'] == 0) {
  //       return true;
  //     }
  //     return false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // final trxData = Provider.of<Transactions>(context, listen: false);

    final deleteFn = Provider.of<Transactions>(context).deleteTransaction;

    final yearlyTrans = Provider.of<Transactions>(context, listen: false)
        .yearlyTransactions(_selectedYear);

    final List<PieData> yearlyData = PieData().pieChartData(yearlyTrans);

    final List<Map<String, Object>> groupTransFirstSixMonths = trxData
        .firstSixMonthsTransValues(yearlyTrans, int.parse(_selectedYear));
    final List<Map<String, Object>> groupTransLastSixMonths =
        trxData.lastSixMonthsTransValues(yearlyTrans, int.parse(_selectedYear));
    bool checkForEmpty(List<Map<String, Object>> groupTrans) {
      return groupTrans.every((element) {
        if (element['amount'] == 0) {
          return true;
        }
        return false;
      });
    }

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          yearlyTrans.isEmpty
              ? NoTransactions()
              : _showChart
                  ? yearlyChart(
                      context,
                      yearlyData,
                      groupTransFirstSixMonths,
                      groupTransLastSixMonths,
                      checkForEmpty,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return TransactionListItems(
                            trx: yearlyTrans[index], dltTrxItem: deleteFn);
                      },
                      itemCount: yearlyTrans.length,
                    ),
        ],
      ),
    );
  }

  Row widgetToSelectYear() {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_left),
          onPressed: int.parse(_selectedYear) == 0
              ? null
              : () {
                  setState(() {
                    _selectedYear = (int.parse(_selectedYear) - 1).toString();
                  });
                },
        ),
        Text(_selectedYear),
        IconButton(
          icon: const Icon(Icons.arrow_right),
          onPressed: _selectedYear == DateFormat('yyyy').format(DateTime.now())
              ? null
              : () {
                  setState(() {
                    _selectedYear = (int.parse(_selectedYear) + 1).toString();
                  });
                },
        ),
      ],
    );
  }

  Column yearlyChart(
    BuildContext context,
    List<PieData> yearlyData,
    List<Map<String, Object>> firstSixMonths,
    List<Map<String, Object>> lastSixMonths,
    Function checkForEmpty,
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
          child: MyPieChart(pieData: yearlyData),
        ),
        checkForEmpty(firstSixMonths)
            ? Container()
            : YearlyStats(
                groupedTransactionValues: firstSixMonths,
              ),
        checkForEmpty(lastSixMonths)
            ? Container()
            : YearlyStats(
                groupedTransactionValues: lastSixMonths,
              ),
      ],
    );
  }
}
