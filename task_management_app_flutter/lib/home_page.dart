import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management_app_flutter/add_task.dart';

class AllTasks extends StatefulWidget {
  const AllTasks({Key? key}) : super(key: key);

  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Tasks",
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Text(
                "Nothing to show for now!",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                ),
              ),
            ),
            Positioned(
              bottom: 25,
              left: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTask(),
                    ),
                  );
                },
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.blue, Colors.blueAccent],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(Icons.add),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
