import 'dart:io';

import 'package:expensify/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicator/progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addbudget.dart';

class MyDashboard extends StatefulWidget {
  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  String _selectedYear = DateFormat('yyyy').format(DateTime.now());
  String currentdate = DateFormat('EEE, MMM dd, yyyy').format(DateTime.now());
  String dropdownValue = DateFormat('MMM').format(DateTime.now());

  Transactions trxData;
  Function deleteFn;

  SharedPreferences logindata;
  String username;
  @override
  void initState() {
    super.initState();
    trxData = Provider.of<Transactions>(context, listen: false);
    deleteFn =
        Provider.of<Transactions>(context, listen: false).deleteTransaction;
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username');
    });
  }

  String currentmonth = DateFormat('LLLL').format(DateTime.now());

  bool isLoading = false;
  int left = 0;
  double left1 = 0;
  int left2 = 0;

  @override
  Widget build(BuildContext context) {
    final formatCurrency =
        new NumberFormat.simpleCurrency(locale: Platform.localeName);
    if (username != null) {
      left1 = double.parse('${username}');
    } else {
      left1 = 0;
    }

    final monthlyTrans = Provider.of<Transactions>(context)
        .monthlyTransactions(dropdownValue, _selectedYear);
    double left2 = trxData.getTotal(monthlyTrans).toDouble();

    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14.0, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      currentdate,
                      style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          fontFamily: 'proximasoftbold'),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                      child: Text(
                        "Edit Budget",
                        style: TextStyle(
                            color: Colors.blue[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            fontFamily: 'proximasoftbold'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                          color: Colors.lightBlueAccent[700],
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                          fontFamily: 'proximasoftbold'),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        logindata.setBool('login', true);
                        Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => MyLoginPage()));
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.lightBlueAccent[100],
                constraints: BoxConstraints(minHeight: 200),
                padding: EdgeInsets.all(0),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/cardbg.png",
                        ),
                        fit: BoxFit.contain),
                    border: Border.all(
                      width: 3,
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Text(
                          '${formatCurrency.format((left1 - left2))}',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 30,
                              fontFamily: 'proximasoftbold'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 5, 0, 0),
                        child: Text(
                          "Balance",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'proximasoftbold',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: BarProgress(
                          percentage: (left2 * 100 / left1),
                          backColor: Colors.grey,
                          gradient: LinearGradient(
                              colors: [Colors.yellow, Colors.red]),
                          stroke: 7,
                          round: true,
                          showPercentage: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  color: Colors.lightBlueAccent[100],
                  height: 100,
                  width: 400,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/images/cardbg1.png",
                          ),
                          fit: BoxFit.cover),
                      border: Border.all(
                        width: 3,
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(27, 20, 27, 0),
                          child: Row(
                            children: [
                              Text(
                                "Expenses for " + currentmonth,
                                style: TextStyle(
                                  fontFamily: 'proximabold',
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '${formatCurrency.format(left2)}',
                                style: TextStyle(
                                  fontFamily: 'proximabold',
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                          child: BarProgress(
                            percentage: left2 * 100 / left1,
                            backColor: Colors.grey,
                            gradient: LinearGradient(
                                colors: [Colors.yellow, Colors.red]),
                            stroke: 7,
                            round: true,
                            showPercentage: false,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
