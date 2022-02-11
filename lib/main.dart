import 'package:expensify/page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './screens/home_screen.dart';
import './screens/new_transaction.dart';
import './models/transaction.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Transactions(),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Expensify',
            theme: ThemeData(
              primaryColor: Colors.lightBlue,
              accentColor: Colors.lightBlueAccent,
              fontFamily: 'proximasoftbold',
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline1: const TextStyle(
                      fontFamily: 'proximasoftbold',
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    button: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
              appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                      headline1: const TextStyle(
                        fontFamily: 'proximasoftbold',
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
              ),
            ),
            // home: PageC(),
            initialRoute: PageC.routeName,
            routes: {
              PageC.routeName: (_) => PageC(),
              HomeScreen.routeName: (_) => HomeScreen(),
              NewTransaction.routeName: (_) => NewTransaction(),
            },
          );
        });
  }
}
