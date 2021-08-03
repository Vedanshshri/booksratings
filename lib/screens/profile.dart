import 'dart:ui';

import 'package:booksratings/utils/constants.dart';
import 'package:booksratings/widgets/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? email;
  String? firebaseId;
  String? login;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLog();
  }

  void getLog() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      login = sp.getString(ISLOGGEDIN);
      email = sp.getString(EMAIL);
      firebaseId = sp.getString(ID);
      print(email);
    });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          _auth.signOut();
          Navigator.pushNamed(context, "/login");
          SharedPreferences sp = await SharedPreferences.getInstance();
          sp.clear();
        },
        label: Text(
          "Logout",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.yellow.shade300,
      appBar: MyAppBar(
        title: "Profile",
        actions: [],
      ),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          shadowColor: Colors.purple.shade300,
          elevation: 10,
          color: Colors.white,
          child: Container(
            height: h * 0.7,
            width: w * 0.9,
            child: Container(
              padding: EdgeInsets.all(w * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Email : ",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          email.toString(),
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Status : ",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          login.toString(),
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ID : ",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          firebaseId.toString(),
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
