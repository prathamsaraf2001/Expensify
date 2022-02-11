import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:expensify/models/transaction.dart';
import 'package:expensify/constants/categories.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class NewTransaction extends StatefulWidget {
  static const routeName = '/new-transaction';
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final inputTitleController = TextEditingController();
  final inputAmountController = TextEditingController();
  final budgetController = TextEditingController()..text = '2000';
  DateTime _selectedDate = DateTime.now();

  Transactions transactions;
  String dropdownValue = 'Other';

  void chooseDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    transactions = Provider.of<Transactions>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightBlue[100],
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            right: 20,
            left: 20,
            top: 30,
            bottom: (MediaQuery.of(context).viewInsets.bottom) + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      // Text(
                      //   " Add a \n Transaction",
                      //   style: TextStyle(
                      //       foreground: Paint()
                      //         ..style = PaintingStyle.stroke
                      //         ..strokeWidth = 2
                      //         ..color = Colors.blue[900],
                      //       // color: Colors.white,
                      //       fontFamily: 'proximasoftbold',
                      //       fontSize: 30,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      Text(
                        " Add a \n Transaction",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'proximasoftbold',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Spacer(),
                  Image.asset(
                    "assets/images/addpg.png",
                    scale: 3,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                width: 210,
                child: TextField(
                  // inputFormatters: [MoneyInputFormatter()],
                  controller: inputAmountController,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    fontFamily: 'proximasoftbold',
                  ),
                  decoration: InputDecoration(
                    fillColor: Colors.lightBlueAccent[100],
                    filled: true,
                    contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      gapPadding: 2,
                      borderSide: const BorderSide(
                        color: Colors.lightBlue,
                        width: 3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      gapPadding: 4,
                      borderSide: const BorderSide(
                        color: Colors.lightBlue,
                        width: 3,
                      ),
                    ),
                    hintText: '₹ Amount',
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'proximasoftbold'),
                    // prefixIcon: Image.asset(
                    //   "assets/icons/category.png",
                    //   scale: 20,
                    // ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: inputTitleController,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontFamily: 'proximasoftbold',
                ),
                decoration: InputDecoration(
                  fillColor: Colors.lightBlueAccent[100],
                  filled: true,
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    gapPadding: 2,
                    borderSide: const BorderSide(
                      color: Colors.lightBlue,
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    gapPadding: 4,
                    borderSide: const BorderSide(
                      color: Colors.lightBlue,
                      width: 3,
                    ),
                  ),
                  hintText: 'Title',
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'proximasoftbold',
                  ),
                  // prefixIcon: Image.asset(
                  //   "assets/icons/category.png",
                  //   scale: 20,
                  // ),
                ),
              ),

              //onChanged: (value) => inputAmount = value,

              SizedBox(height: 10),
              dropDownToSelectMonth(context),
              SizedBox(height: 10),
              Container(
                height: 65,
                decoration: BoxDecoration(
                    color: Colors.lightBlueAccent[100],
                    border: Border.all(
                      width: 3,
                      color: Colors.lightBlue,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        DateFormat.yMMMd().format(_selectedDate),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'proximasoftbold',
                        ),
                      ),
                      InkWell(
                        onTap: () => chooseDate(),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Choose Date",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              fontFamily: 'proximasoftbold',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                  // child: ElevatedButton(
                  //   child: const Text(
                  //     "Add",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 25,
                  //       fontFamily: 'proximasoftbold',
                  //     ),
                  //   ),
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Colors.lightBlue,
                  //     shape: new RoundedRectangleBorder(
                  //       borderRadius: new BorderRadius.circular(20.0),
                  //     ),
                  //     padding: EdgeInsets.fromLTRB(130, 20, 130, 20),
                  //   ),
                  //   onPressed: () {
                  //     FocusScope.of(context).unfocus();
                  //     if (inputTitleController.text.isNotEmpty &&
                  //         (int.parse(inputAmountController.text)) >= 0 &&
                  //         _selectedDate != null) {
                  //       final enteredTitle = inputTitleController.text;
                  //       final enteredAmount =
                  //           int.parse(inputAmountController.text);
                  //       final budget = int.parse(budgetController.text);

                  //       transactions.addTransactions(
                  //         Transaction(
                  //           id: DateTime.now().toString(),
                  //           title: enteredTitle,
                  //           amount: enteredAmount,
                  //           budget: budget,
                  //           date: _selectedDate,
                  //           category: dropdownValue,
                  //         ),
                  //       );
                  //       //Navigator.of(context).pop();
                  //       inputTitleController.clear();
                  //       inputAmountController.clear();
                  //       setState(() {
                  //         // _selectedDate = DateTime.now();
                  //         dropdownValue = 'Other';
                  //       });
                  //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(
                  //           backgroundColor: Theme.of(context).primaryColorLight,
                  //           content: Text(
                  //             "Data added Succesfully!",
                  //             style: Theme.of(context).textTheme.headline1,
                  //             textAlign: TextAlign.center,
                  //           ),
                  //         ),
                  //       );
                  //     } else {
                  //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(
                  //           backgroundColor: Theme.of(context).errorColor,
                  //           content: Text(
                  //             "Fields can't be empty!",
                  //             style: Theme.of(context).textTheme.headline1,
                  //             textAlign: TextAlign.center,
                  //           ),
                  //         ),
                  //       );
                  //     }
                  //   },
                  // ),
                  child: RaisedButton(
                child: const Text("Add"),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (inputTitleController.text.isNotEmpty &&
                      (int.parse(inputAmountController.text)) >= 0 &&
                      _selectedDate != null) {
                    final enteredTitle = inputTitleController.text;
                    final enteredAmount = int.parse(inputAmountController.text);

                    transactions.addTransactions(
                      Transaction(
                        id: DateTime.now().toString(),
                        title: enteredTitle,
                        amount: enteredAmount,
                        date: _selectedDate,
                        category: dropdownValue,
                      ),
                    );
                    //Navigator.of(context).pop();
                    inputTitleController.clear();
                    inputAmountController.clear();
                    setState(() {
                      // _selectedDate = DateTime.now();
                      dropdownValue = 'Other';
                    });
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Theme.of(context).primaryColorLight,
                        content: Text(
                          "Data added Succesfully!",
                          style: Theme.of(context).textTheme.headline1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Theme.of(context).errorColor,
                        content: Text(
                          "Fields can't be empty!",
                          style: Theme.of(context).textTheme.headline1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropDownToSelectMonth(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent[100],
          border: Border.all(
            width: 3,
            color: Colors.lightBlue,
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 8, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Category :',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'proximasoftbold',
              ),
            ),
            DropdownButton<String>(
              dropdownColor: Colors.lightBlueAccent[100],
              borderRadius: BorderRadius.circular(20),
              value: dropdownValue,
              icon: const Icon(
                Icons.expand_more,
                color: Colors.lightBlue,
              ),
              elevation: 16,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                fontFamily: 'proximasoftbold',
              ),
              underline: Container(
                height: 2,
                color: Colors.lightBlueAccent[100],
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'proximasoftbold',
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
