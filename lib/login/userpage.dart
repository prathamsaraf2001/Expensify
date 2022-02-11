import 'dart:io';

import 'package:expensify/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicator/progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import 'adduser.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  File _image;
  final picker = ImagePicker();
  String _selectedYear = DateFormat('yyyy').format(DateTime.now());
  String currentdate = DateFormat('EEE, MMM dd, yyyy').format(DateTime.now());
  String dropdownValue = DateFormat('MMM').format(DateTime.now());

  Transactions trxData;
  Function deleteFn;

  SharedPreferences logindata;
  String firstname;
  String lastname;
  String emailid;
  String address;
  String phone;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trxData = Provider.of<Transactions>(context, listen: false);
    deleteFn =
        Provider.of<Transactions>(context, listen: false).deleteTransaction;
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      firstname = logindata.getString(
        'firstname',
      );
      lastname = logindata.getString(
        'lastname',
      );
      phone = logindata.getString(
        'phone',
      );
      emailid = logindata.getString(
        'emailid',
      );
      address = logindata.getString(
        'address',
      );
    });
  }

  String currentmonth = DateFormat('LLLL').format(DateTime.now());

  bool _showChart = false;

  bool isLoading = false;
  int left = 0;
  int left1 = 0;
  int left2 = 0;

  @override
  Widget build(BuildContext context) {
    final formatCurrency =
        new NumberFormat.simpleCurrency(locale: Platform.localeName);

    final monthlyTrans = Provider.of<Transactions>(context)
        .monthlyTransactions(dropdownValue, _selectedYear);

    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/userbg1.png",
              ),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          "Edit Profile",
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
                        "Profile",
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
                                  builder: (context) => AddUser()));
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
            Container(
              width: double.infinity,
              height: 170,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          child: Center(
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      height: 100,
                                      width: 100,
                                      child: Image.asset(
                                        'assets/images/user.png',
                                        height: 100,
                                      ) // set a placeholder image when no photo is set

                                      ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        '  ${firstname} ${lastname}',
                        style: TextStyle(
                            color: Colors.lightBlueAccent[700],
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            fontFamily: 'proximasoftbold'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 5, 0, 5),
              child: Text(
                "Email",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontFamily: 'proximasoftbold'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 1, 0, 5),
              child: Text(
                '${emailid} ',
                style: TextStyle(
                    color: Colors.lightBlueAccent[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    fontFamily: 'proximasoftbold'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 5, 0, 5),
              child: Text(
                "Phone",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontFamily: 'proximasoftbold'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 1, 0, 5),
              child: Text(
                '${phone} ',
                style: TextStyle(
                    color: Colors.lightBlueAccent[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    fontFamily: 'proximasoftbold'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 5, 0, 5),
              child: Text(
                "Address",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontFamily: 'proximasoftbold'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 1, 0, 5),
              child: Text(
                '${address} ',
                style: TextStyle(
                    color: Colors.lightBlueAccent[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    fontFamily: 'proximasoftbold'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future selectOrTakePhoto(ImageSource imageSource) async {
  //   final pickedFile = await picker.getImage(source: imageSource);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //       Navigator.pushNamed(context, routeEdit, arguments: _image);
  //     } else
  //       print('No photo was selected or taken');
  //   });
  // }

  // /// Selection dialog that prompts the user to select an existing photo or take a new one
  // Future _showSelectionDialog() async {
  //   await showDialog(
  //     builder: (context) => SimpleDialog(
  //       title: Text('Select photo'),
  //       children: <Widget>[
  //         SimpleDialogOption(
  //           child: Text('From gallery'),
  //           onPressed: () {
  //             selectOrTakePhoto(ImageSource.gallery);
  //             Navigator.pop(context);
  //           },
  //         ),
  //         SimpleDialogOption(
  //           child: Text('Take a photo'),
  //           onPressed: () {
  //             selectOrTakePhoto(ImageSource.camera);
  //             Navigator.pop(context);
  //           },
  //         ),
  //       ],
  //     ),
  //     context: context,
  //   );
  // }

}
