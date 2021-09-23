import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management_app_flutter/screens/add_task.dart';
import 'package:task_management_app_flutter/constants.dart';
import 'package:task_management_app_flutter/models/list_items.dart';

final _firestore = FirebaseFirestore.instance;

class AllTasks extends StatefulWidget {
  static const String id = "all_tasks";
  const AllTasks({Key? key}) : super(key: key);

  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        bottomOpacity: 0,
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
            icon: Icon(FontAwesomeIcons.signOutAlt),
          ),
        ],
        title: Text(
          "All Tasks",
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: TaskList(),
    );
  }
}

class TaskList extends StatefulWidget {
  final String? id;
  const TaskList({Key? key, this.id}) : super(key: key);
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final _auth = FirebaseAuth.instance;
  String? email;
  bool? isLoggedIn = false;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      setState(() {
        if (user != null) {
          loggedInUser = user;
          isLoggedIn = true;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return (isLoggedIn == false)
        ? Center(child: CircularProgressIndicator())
        : StreamBuilder(
            stream: _firestore
                .collection('tasks')
                .where('email', isEqualTo: loggedInUser!.email)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddTask()),
                          );
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomRight,
                              colors: [Colors.blue, Colors.blueAccent],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding:
                      EdgeInsets.only(top: 50, bottom: 50, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            DocumentSnapshot doc = snapshot.data!.docs[index];
                            return Card(
                              color: Colors.blueAccent,
                              elevation: 0,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                  left: 10,
                                  right: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Title: ${doc['title']}",
                                              style: kNormalTextStyle),
                                          Text(
                                            "Text: ${doc['text']}",
                                            style: kNormalTextStyle,
                                          ),
                                          Text(
                                            "Date: ${doc['date']}",
                                            style: kNormalTextStyle,
                                          ),
                                          Text(
                                            "Time: ${doc['time']}",
                                            style: kNormalTextStyle,
                                          ),
                                          Text(
                                            "Email: ${doc['email']}",
                                            style: kNormalTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        doc.reference.delete();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: snapshot.data!.docs.length,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddTask()),
                          );
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 35,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            });
  }
}
