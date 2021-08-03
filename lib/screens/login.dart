// import 'package:booksratings/widgets/inputCard.dart';
import 'package:booksratings/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? userName;
  String? passWord;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.yellow.shade300,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(w * 0.05),
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
              // inputCard(str: userName, hintText: "  Email"),
              // inputCard(str: passWord, hintText: "  Password"),
              SizedBox(
                height: h * 0.03,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                onPressed: () async {
                  try {
                    final User? user = (await _auth.signInWithEmailAndPassword(
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
                  } catch (e) {
                    print(e);
                  }
                },
                color: Colors.white,
                child: Text("Login"),
              ),
              SizedBox(
                height: h * 0.03,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/register");
                },
                child: Text(
                  " New  User / Register",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget inputCard({String? str, initialValue = "", hintText = ""}) {
    return Card(
      shadowColor: Colors.amber.shade600,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextFormField(
        decoration:
            InputDecoration(border: InputBorder.none, hintText: hintText),
        initialValue: initialValue,
        onChanged: (value) {
          str = value;
        },
      ),
    );
  }
}
// class Login extends StatelessWidget {
//   String? userName;
//   String? passWord;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   @override
//   Widget build(BuildContext context) {
//     var w = MediaQuery.of(context).size.width;
//     var h = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: Colors.amber.shade300,
//       body: Center(
//         child: Container(
//           padding: EdgeInsets.all(w * 0.05),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.transparent,
//                 radius: w * 0.2,
//                 backgroundImage: AssetImage("assets/logo.png"),
//               ),
//               SizedBox(
//                 height: h * 0.03,
//               ),
//               inputCard(str: userName, hintText: "  Email"),
//               inputCard(str: passWord, hintText: "  Password"),
//               SizedBox(
//                 height: h * 0.03,
//               ),
//               MaterialButton(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 onPressed: () {
//                   // _auth.signInWithEmailAndPassword(
//                   //     email: userName!, password: passWord!);
//                   print(userName);
//                   print(passWord);
//                 },
//                 color: Colors.white,
//                 child: Text("Login"),
//               ),
//               SizedBox(
//                 height: h * 0.03,
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, "/register");
//                 },
//                 child: Text(
//                   " New  User / Register",
//                   style: TextStyle(color: Colors.black, fontSize: 15),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget inputCard({String? str, initialValue = "", hintText = ""}) {
//     return Card(
//       shadowColor: Colors.amber.shade600,
//       elevation: 10,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       child: TextFormField(
//         decoration:
//             InputDecoration(border: InputBorder.none, hintText: hintText),
//         initialValue: initialValue,
//         onChanged: (value) {
//           str = value;
//         },
//       ),
//     );
//   }
// }
