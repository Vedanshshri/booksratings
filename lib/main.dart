import 'package:booksratings/screens/addBook.dart';
import 'package:booksratings/screens/editBook.dart';
import 'package:booksratings/screens/home.dart';
import 'package:booksratings/screens/login.dart';
import 'package:booksratings/screens/profile.dart';
import 'package:booksratings/screens/register.dart';
import 'package:booksratings/screens/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "splash",
      routes: {
        "splash": (context) => MySplash(),
        "/home": (context) => Home(),
        "/login": (context) => Login(),
        "/register": (context) => Register(),
        "/addBook": (context) => AddBook(),
        "/profile": (context) => Profile(),
      },
    );
  }
}
