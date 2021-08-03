// import 'package:booksratings/widgets/inputCard.dart';
import 'package:booksratings/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatelessWidget {
  String? userName, passWord, rePassWord;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.yellow.shade300,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(w * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: w * 0.2,
                  backgroundImage: AssetImage("assets/logo.png"),
                ),
                SizedBox(
                  height: h * 0.03,
                ),
                Card(
                  shadowColor: Colors.purple.shade300,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "  Email"),
                    //initialValue: initialValue,
                    onChanged: (value) {
                      userName = value;
                    },
                  ),
                ),
                Card(
                  shadowColor: Colors.purple.shade300,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "  Password"),
                    //initialValue: initialValue,
                    onChanged: (value) {
                      passWord = value;
                    },
                  ),
                ),
                Card(
                  shadowColor: Colors.purple.shade300,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "  Retype-Password"),
                    //initialValue: initialValue,
                    onChanged: (value) {
                      rePassWord = value;
                    },
                  ),
                ),
                SizedBox(
                  height: h * 0.03,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  onPressed: () async {
                    try {
                      if (passWord!.trim() == rePassWord!.trim()) {
                        final User? user =
                            (await _auth.createUserWithEmailAndPassword(
                          email: userName!.trim(),
                          password: passWord!,
                        ))
                                .user;
                        print(user!.uid);
                        print("userName");
                        print(passWord);

                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        sp.setString(ISLOGGEDIN, "Present");
                        sp.setString(EMAIL, user.email!);

                        sp.setString(ID, user.uid);
                        Navigator.pushNamed(context, "/home");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.purple.shade300,
                            content: Text(
                              "Passwords Do Not Match",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  color: Colors.white,
                  child: Text("Register"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
