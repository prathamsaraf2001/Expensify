import 'package:expensify/page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'userpage.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final firstname_controller = TextEditingController();
  final lastname_controller = TextEditingController();
  final phone_controller = TextEditingController();
  final email_controller = TextEditingController();
  final address_controller = TextEditingController();
  SharedPreferences logindata;
  bool newuser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => UserPage()));
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    firstname_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightBlue[100],
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            right: 0,
            left: 0,
            top: 30,
            bottom: (MediaQuery.of(context).viewInsets.bottom) + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => PageC()));
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Stack(
                              children: [
                                Text(
                                  "  Complete\n  your Profile",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'proximasoftbold',
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Container(
                        child: Image.asset(
                          "assets/images/userbg.png",
                          scale: 6,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.445,
                        child: TextField(
                          // inputFormatters: [MoneyInputFormatter()],
                          controller: firstname_controller,
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
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                            hintText: 'FirstName',
                            hintStyle: const TextStyle(
                                fontSize: 18,
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
                      SizedBox(width: 10),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.455,
                        child: TextField(
                          controller: lastname_controller,
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
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                            hintText: 'LastName',
                            hintStyle: const TextStyle(
                                fontSize: 18,
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
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Container(
                  width: double.infinity,
                  child: TextField(
                    controller: email_controller,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
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
                      hintText: 'Email-ID',
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
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Container(
                  width: double.infinity,
                  child: TextField(
                    inputFormatters: [PhoneInputFormatter()],
                    controller: phone_controller,
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
                      hintText: 'Phone Number',
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
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Container(
                  width: double.infinity,
                  child: TextField(
                    // inputFormatters: [MoneyInputFormatter()],
                    controller: address_controller,
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
                      hintText: 'Address',
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
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(135, 19, 135, 19),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () {
                      String firstname = firstname_controller.text;
                      String lastname = lastname_controller.text;
                      String emailid = email_controller.text;
                      String phone = phone_controller.text;
                      String address = address_controller.text;
                      if (firstname != '' &&
                          lastname != '' &&
                          emailid != '' &&
                          phone != '' &&
                          address != '') {
                        print('Successfull');
                        logindata.setBool('login', false);
                        logindata.setString('firstname', firstname);
                        logindata.setString('lastname', lastname);
                        logindata.setString('emailid', emailid);
                        logindata.setString('phone', phone);
                        logindata.setString('address', address);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => PageC()));
                      }
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        fontFamily: 'proximasoftbold',
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
