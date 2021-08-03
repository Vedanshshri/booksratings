import 'package:booksratings/utils/constants.dart';
import 'package:booksratings/widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  String? bookName, author, rating;

  String? firebaseId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLog();
  }

  void getLog() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      firebaseId = sp.getString(ID);
    });
  }

  void setBook() {
    Map<String, dynamic> data = {
      "bookName": bookName,
      "author": author,
      "rating": int.parse(rating!)
    };
    final ref = FirebaseFirestore.instance
        .collection(firebaseId!)
        .doc(bookName)
        .set(data);
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.yellow.shade400,
      appBar: MyAppBar(
        title: "Add Your Book",
        actions: [],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(w * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  shadowColor: Colors.purple.shade300,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "  Book Name"),
                    //initialValue: initialValue,
                    onChanged: (value) {
                      bookName = value;
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
                        border: InputBorder.none, hintText: "  Author"),
                    //initialValue: initialValue,
                    onChanged: (value) {
                      author = value;
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
                        border: InputBorder.none, hintText: "  Rating"),
                    //initialValue: initialValue,
                    onChanged: (value) {
                      rating = value;
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
                  onPressed: () {
                    if (0 < int.parse(rating!) && int.parse(rating!) < 6) {
                      setBook();

                      Navigator.pushNamed(context, "/home");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.purple.shade300,
                          content: Text(
                            "Rating Must be From 1-5",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    }
                  },
                  color: Colors.white,
                  child: Text("Add Book"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
