import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_management_app_flutter/models/list_items.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  List<ListItems> itemList = [];
  DateTime? _dateTime;
  DateTime? _selectedDate;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  final _titleController = TextEditingController();
  final _textController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Tasks",
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                TableCalendar(
                  focusedDay: _focusedDay,
                  firstDay: DateTime(2021),
                  lastDay: DateTime(2030),
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDate, day);
                  },
                  onDaySelected: (selectedDate, focusedDay) {
                    if (!isSameDay(_selectedDate, selectedDate)) {
                      setState(() {
                        _selectedDate = selectedDate;
                        _focusedDay = focusedDay;
                      });
                    }
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TimePickerSpinner(
                  is24HourMode: true,
                  normalTextStyle: GoogleFonts.poppins(fontSize: 20),
                  onTimeChange: (time) {
                    setState(() {
                      _dateTime = time;
                    });
                  },
                ),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: "Provide your title",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: "Provide your text",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  child: Text("Add Task"),
                  onPressed: () {
                    setState(() {
                      itemList.add(
                        ListItems(
                          title: _titleController.text,
                          text: _textController.text,
                          selectedDayTime: _selectedDate,
                          selectedTime: _dateTime,
                        ),
                      );
                    });
                    Navigator.pop(context, itemList);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
