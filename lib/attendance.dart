import 'package:flutter/material.dart';
import 'package:samplews/constants/drawer.dart';
import 'db.dart';
import 'home.dart';
import 'codered_classes.dart';

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final TextEditingController subjectController = TextEditingController();
  List<Attendance> attendanceRecords = [];
  DatabaseHelper helper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    helper.getAttendance().then((value) {
      setState(() {
        attendanceRecords = value;
      });
    });
  }

  Future<void> _deleteAttendance(int? id) async {
    await helper.deleteAttendance(id ?? 0);
    setState(() {
      attendanceRecords.removeWhere((element) => element.id == id);
    });
  }

  Future<void> _addSubject(String subject) async {
    Attendance attendance = Attendance(
      subject: subject,
      attendanceCount: 0,
    );
    await helper.insertSubject(attendance);
    setState(() {
      attendanceRecords.add(attendance);
    });
  }

  Future<void> _showAddSubjectDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Subject'),
          content: TextField(
            controller: subjectController,
            decoration: InputDecoration(labelText: 'Subject'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the AlertDialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addSubject(subjectController.text);
                subjectController.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Subject added'),
                  ),
                );
                Navigator.of(context).pop(); // Close the AlertDialog
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Management'),
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: attendanceRecords.length,
              itemBuilder: (context, index) {
                final record = attendanceRecords[index];
                return ListTile(
                  visualDensity: VisualDensity(vertical: 4),
                  title: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      record.subject,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            record.attendanceCount++;
                          });
                        },
                      ),
                      Text(
                        record.attendanceCount.toString(),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            record.attendanceCount--;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteAttendance(record.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () async {
            await helper.updateAttendance(attendanceRecords);
            //notify user
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Attendance Updated'),
              ),
            );
          },
          child: Text('Update Attendance'),
        ),
      ],
      persistentFooterAlignment: AlignmentDirectional.center,

      //update attendance

      //add subject
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddSubjectDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
