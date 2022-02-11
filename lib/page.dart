import 'package:expensify/budget/addbudget.dart';
import 'package:expensify/login/userpage.dart';
import 'package:expensify/screens/chartpage.dart';
import 'package:expensify/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:intl/intl.dart';

import 'budget/mainpage.dart';

class PageC extends StatefulWidget {
  static const routeName = '/page';
  @override
  _PageCState createState() => _PageCState();
}

class _PageCState extends State<PageC> {
  int selectedPage = 0;
  String _selectedYear = DateFormat('yyyy').format(DateTime.now());
  String dropdownValue = DateFormat('MMM').format(DateTime.now());
  String currentmonth = DateFormat('LLLL').format(DateTime.now());
  final _pageOptions = [
    MyDashboard(),
    HomeScreen(),
    ChartPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pageOptions[selectedPage],
      bottomNavigationBar: SnakeNavigationBar.color(
        currentIndex: selectedPage,
        snakeShape: SnakeShape.circle,
        snakeViewColor: Colors.lightBlue,
        padding: EdgeInsets.all(0),
        backgroundColor: Colors.lightBlue[100],
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(
                Icons.home_rounded,
                color: Colors.white,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.pie_chart_rounded,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.podcasts,
              color: Colors.white,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}
