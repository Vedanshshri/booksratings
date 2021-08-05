import 'package:booksratings/widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditBook extends StatefulWidget {
  final String book_name, author, rating;
  EditBook(
      {Key? key,
      required this.author,
      required this.book_name,
      required this.rating})
      : super(key: key);

  @override
  _EditBookState createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {
  String? edbookName, edauthor, edrating;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    putData();
  }

  void putData() {
    setState(() {
      edauthor = widget.author;
      edbookName = widget.book_name;
      edrating = widget.rating;
    });
  }

  void updateData() {
    Map<String, dynamic> data = {
      //"bookName": edbookName,
      "author": edauthor,
      "rating": edrating
    };
    var firebaseUser = FirebaseAuth.instance.currentUser;
    final ref = FirebaseFirestore.instance;
    ref
        .collection(firebaseUser!.uid)
        .doc(widget.book_name)
        .update(data)
        .then((_) {
      print("success!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade400,
      appBar: MyAppBar(title: "Edit Book Details", actions: []),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            shadowColor: Colors.purple.shade300,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: TextFormField(
              initialValue: widget.author,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "  Author"),
              //initialValue: initialValue,
              onChanged: (value) {
                edauthor = value;
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
              initialValue: widget.rating,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "  Rating"),
              //initialValue: initialValue,
              onChanged: (value) {
                edrating = value;
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          MaterialButton(
            splashColor: Colors.purple.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            onPressed: () {
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.yellow.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    title: const Text('Are You Sure??'),
                    content: SingleChildScrollView(
                        // child: ListBody(
                        //   children: const <Widget>[
                        //     const Text('Are You Sure??'),
                        //   ],
                        // ),
                        ),
                    actions: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.purple.shade300,
                            child: const Text('Update'),
                            onPressed: () {
                              if (0 < int.parse(edrating!) &&
                                  int.parse(edrating!) < 6) {
                                updateData();

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
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.purple.shade300,
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
            color: Colors.white,
            child: Text("Update"),
          ),
        ],
      ),
    );
  }
}
