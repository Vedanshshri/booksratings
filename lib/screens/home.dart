import 'package:booksratings/screens/editBook.dart';
import 'package:booksratings/utils/constants.dart';
import 'package:booksratings/widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  String? id;
  List data = [];
  bool isloading = true;
  late AnimationController animationController;
  late Animation animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    animationController.repeat(reverse: true);
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  void getData() async {
    data.clear();
    setState(() {
      isloading = true;
    });

    SharedPreferences sp = await SharedPreferences.getInstance();
    id = sp.getString(ID);
    var ref =
        FirebaseFirestore.instance.collection(id!).get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        setState(() {
          data.add(result.data());
        });
      });
    }).then((value) {
      setState(() {
        isloading = false;
      });
    });
  }

  void getSortByRatingData() async {
    data.clear();
    setState(() {
      isloading = true;
    });

    SharedPreferences sp = await SharedPreferences.getInstance();
    id = sp.getString(ID);
    var ref = FirebaseFirestore.instance
        .collection(id!)
        .orderBy("rating", descending: true)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        setState(() {
          data.add(result.data());
        });
      });
    }).then((value) {
      setState(() {
        isloading = false;
      });
    });
  }

  Future<void> showDialogForSort() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.yellow.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: const Text('SORT BY'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                const Text('Which Type Of Sort You Want ??'),
              ],
            ),
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
                  child: const Text('Normal'),
                  onPressed: () {
                    getData();
                    Navigator.of(context).pop();
                  },
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.purple.shade300,
                  child: const Text('Sort By Rating'),
                  onPressed: () {
                    getSortByRatingData();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void deleteDoc(String name) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    var ref = FirebaseFirestore.instance
        .collection(firebaseUser!.uid)
        .doc(name)
        .delete()
        .then((_) {
      print(" delete success!");
    });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.yellow.shade300,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 10,
        onPressed: () => Navigator.pushNamed(context, "/addBook"),
      ),
      appBar: MyAppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialogForSort();
              },
              icon: Icon(Icons.sort)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/profile");
              },
              icon: Icon(Icons.person_outline_rounded))
        ],
        title: "My Books",
      ),
      body: isloading
          ? Center(
              child: Text("Loading....."),
            )
          : data.length > 0
              ? ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, index) {
                    return Stack(alignment: Alignment.topCenter, children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(
                                    animation.value + 1, animation.value + 1),
                                end: Alignment(
                                    animation.value - 1, animation.value - 1),
                                colors: [
                                  Colors.lightBlue.shade300,
                                  // Colors.purple.shade300,
                                  Colors.lightGreen.shade300,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          height: h * 0.2,
                          width: w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Book Name : ",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        data[index]["bookName"],
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Author : ",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        data[index]["author"],
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellowAccent,
                                    size: w * 0.2,
                                  ),
                                  Text(
                                    data[index]["rating"].toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        color: Colors.white,
                        shadowColor: Colors.purple,
                        elevation: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            color: Colors.purple.shade300,
                                            child: const Text('Delete'),
                                            onPressed: () {
                                              deleteDoc(
                                                  data[index]["bookName"]);
                                              Navigator.of(context).pop();
                                              getData();
                                              // Navigator.pushNamed(context, "/home");
                                            },
                                          ),
                                          MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
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
                            icon: Icon(Icons.delete),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditBook(
                                            author: data[index]["author"]
                                                .toString(),
                                            book_name: data[index]["bookName"],
                                            rating: data[index]["rating"]
                                                .toString())));
                              },
                              icon: Icon(Icons.edit)),
                        ],
                      ),
                    ]);
                  },
                  separatorBuilder: (BuildContext context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: h * 0.02,
                        ),
                        Divider(
                          endIndent: w * 0.1,
                          indent: w * 0.1,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: h * 0.02,
                        )
                      ],
                    );
                  },
                  itemCount: data.length)
              : Center(
                  child: Text("No Books Added Yet"),
                ),
    );
  }
}
