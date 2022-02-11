import 'package:expensify/page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mainpage.dart';

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final username_controller = TextEditingController(text: '0');
  final password_controller = TextEditingController();
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
          context, new MaterialPageRoute(builder: (context) => MyDashboard()));
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[100],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
                context, new MaterialPageRoute(builder: (context) => PageC()));
          },
        ),
        title: Text(
          "Add Budget",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
            fontFamily: 'proximasoftbold',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            right: 20,
            left: 20,
            top: 30,
            bottom: (MediaQuery.of(context).viewInsets.bottom) + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                child: TextField(
                  // inputFormatters: [MoneyInputFormatter()],
                  controller: username_controller,
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
                    hintText: '₹ Budget',
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
              SizedBox(height: 20),
              SizedBox(height: 30),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(125, 19, 125, 19),
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () {
                    String username = username_controller.text;

                    if (username != '') {
                      print('Successfull');
                      logindata.setBool('login', false);
                      logindata.setString('username', username);
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
