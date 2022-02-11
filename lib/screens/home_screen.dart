import 'package:expensify/screens/statistics/weekly_stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import 'package:provider/provider.dart';

import '../models/transaction.dart';
import './transactions/daily_spendings.dart';
import './transactions/monthly_spendings.dart';
import './transactions/yearly_spendings.dart';
import '../widgets/app_drawer.dart';
import './new_transaction.dart';
import './transactions/weekly_spendings.dart';
import 'chartpage.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  TabController tabController;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              new Tab(
                text: "Yearly",
              ),
            ],
          ),
        ],
        controller: tabController,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            Navigator.of(context).pushNamed(NewTransaction.routeName),
        // onPressed: () => Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => NewBudget())),
      ),
      body: FutureBuilder(
        future: Provider.of<Transactions>(context, listen: false)
            .fetchTransactions(),
        builder: (ctx, snapshot) =>
            (snapshot.connectionState == ConnectionState.waiting)
                ? Center(child: CircularProgressIndicator())
                : TabBarView(
                    children: <Widget>[
                      new WeeklySpendings(),
                      new MonthlySpendings(),
                      new YearlySpendings(),
                    ],
                    controller: tabController,
                  ),
      ),
      // bottomNavigationBar: SnakeNavigationBar.color(
      //   currentIndex: _selectedIndex,
      //   snakeShape: SnakeShape.circle,
      //   snakeViewColor: Colors.lightBlue,
      //   padding: EdgeInsets.all(0),
      //   backgroundColor: Colors.lightBlue[100],
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: IconButton(
      //         icon: Icon(
      //           Icons.home_rounded,
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.list,
      //         color: Colors.white,
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.pie_chart_rounded,
      //         color: Colors.white,
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.podcasts,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ],
      //   onTap: (index) {
      //     setState(() {
      //       _selectedIndex = index;
      //     });
      //   },
      // ),
      // drawer: Consumer<Transactions>(
      //   builder: (context, trx, child) {
      //     return AppDrawer(total: trx.getTotal(trx.transactions));
      //   },
      // ),
    );
  }
}
