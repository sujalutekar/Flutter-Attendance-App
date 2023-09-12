import 'package:attendence/model/student.dart';
import 'package:attendence/widgets/history_tile.dart';
import 'package:flutter/material.dart';

import './attendance_card_details_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: ListView.builder(
        itemCount: attendanceHistory.length,
        itemBuilder: (context, index) {
          return HistoryTile(
            date: 'Date: ${attendanceHistory[index].date.toString()}',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AttendanceCardDetailsPage(
                    attendanceRecord: attendanceHistory[index],
                  ),
                ),
              );
            },
            present:
                'Present: ${attendanceHistory[index].students.where((student) => student.isPresent).length} / ${attendanceHistory[index].students.length}',
          );
        },
      ),
    );
  }
}
