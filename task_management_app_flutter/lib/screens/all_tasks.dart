import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_management_app_flutter/screens/add_task.dart';
import 'package:task_management_app_flutter/constants.dart';

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
        automaticallyImplyLeading: false,
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
  DateTime? _updatedDateTime;
  DateTime? _updatedSelectedDate;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  final _titleController = TextEditingController();
  final _textController = TextEditingController();

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
                              elevation: 5,
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
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (BuildContext context) {
                                              return Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.7,
                                                color: Colors.white,
                                                child: Column(
                                                  children: [
                                                    TableCalendar(
                                                      focusedDay: _focusedDay,
                                                      firstDay: DateTime(2021),
                                                      lastDay: DateTime(2030),
                                                      calendarFormat:
                                                          _calendarFormat,
                                                      selectedDayPredicate:
                                                          (day) {
                                                        return isSameDay(
                                                            _updatedSelectedDate,
                                                            day);
                                                      },
                                                      onDaySelected:
                                                          (selectedDate,
                                                              focusedDay) {
                                                        if (!isSameDay(
                                                            _updatedSelectedDate,
                                                            selectedDate)) {
                                                          setState(() {
                                                            _updatedSelectedDate =
                                                                selectedDate;
                                                            _focusedDay =
                                                                focusedDay;
                                                          });
                                                        }
                                                      },
                                                      onFormatChanged:
                                                          (format) {
                                                        if (_calendarFormat !=
                                                            format) {
                                                          setState(() {
                                                            _calendarFormat =
                                                                format;
                                                          });
                                                        }
                                                      },
                                                      onPageChanged:
                                                          (focusedDay) {
                                                        _focusedDay =
                                                            focusedDay;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TimePickerSpinner(
                                                      is24HourMode: true,
                                                      normalTextStyle:
                                                          GoogleFonts.poppins(
                                                              fontSize: 20),
                                                      onTimeChange: (time) {
                                                        setState(() {
                                                          _updatedDateTime =
                                                              time;
                                                        });
                                                      },
                                                    ),
                                                    TextField(
                                                      controller:
                                                          _titleController,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Provide your title",
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextField(
                                                      controller:
                                                          _textController,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Provide your text",
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        String formatedDate =
                                                            DateFormat(
                                                                    "MM-dd-yyyy")
                                                                .format(
                                                                    _updatedSelectedDate!);
                                                        String formattedTime =
                                                            DateFormat("HH:mm")
                                                                .format(
                                                                    _updatedDateTime!);
                                                        setState(() {
                                                          doc.reference.update({
                                                            'title':
                                                                _titleController
                                                                    .text,
                                                            'text':
                                                                _textController
                                                                    .text,
                                                            'date':
                                                                formatedDate,
                                                            'time':
                                                                formattedTime,
                                                            'email':
                                                                loggedInUser!
                                                                    .email,
                                                          });
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("Edit Task"),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
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
