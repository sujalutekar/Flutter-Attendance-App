import 'package:flutter/material.dart';

import '../model/student.dart';

class AttendanceCardDetailsPage extends StatelessWidget {
  final AttendanceRecord attendanceRecord;

  const AttendanceCardDetailsPage({super.key, required this.attendanceRecord});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Details'),
      ),
      body: ListView.builder(
        itemCount: attendanceRecord.students.length,
        itemBuilder: (context, index) {
          print(attendanceRecord.students.length);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Card(
              color: Colors.white,
              elevation: 5,
              child: Container(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                      '${attendanceRecord.students[index].rollNo}: ${attendanceRecord.students[index].name}'),
                  leading: Checkbox(
                    value: attendanceRecord.students[index].isPresent,
                    onChanged: null,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
