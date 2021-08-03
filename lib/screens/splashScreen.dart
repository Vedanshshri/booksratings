import 'package:booksratings/screens/home.dart';
import 'package:booksratings/screens/login.dart';
import 'package:booksratings/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class MySplash extends StatefulWidget {
  const MySplash({Key? key}) : super(key: key);

  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  var isLoggedIn;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoginInfo();
  }

  void getLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var islogin = sp.getString(ISLOGGEDIN);
    if (islogin == null) {
      sp.setString(ISLOGGEDIN, "Absent");
    } else {
      setState(() {
        isLoggedIn = islogin;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      text: """Welcome To Books App
    Manage Your Books With Ease.....""",
      navigateRoute: isLoggedIn == "Present" ? Home() : Login(),
      duration: 5000,
      imageSize: 250,
      imageSrc: "assets/logo.png",
      backgroundColor: Colors.yellow.shade300,
    );
  }
}
