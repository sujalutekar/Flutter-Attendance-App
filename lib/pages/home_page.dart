import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/student.dart';
import '../widgets/app_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Student> students = [];
  List<Student> presentStudents = [];
  List<String> studentNames = [];
  int presentee = 0;
  bool _isFileUploaded = false;
  final currentUser = FirebaseAuth.instance.currentUser;
  String selectedFile = "";
  String _fileName = "";
  bool _isFileSelected = false;
  bool _showNames = false;

  showSnackBar(String title) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
      ),
    );
  }

  Future<void> _uploadCSV() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );

      setState(() {
        selectedFile = result!.files.single.name;
        _fileName = selectedFile.toString();
        print('File name : $selectedFile');
        _isFileSelected = true;
      });

      if (result != null && result.files.single.path != null) {
        String filePath = result.files.single.path!;
        String csvData = await File(filePath).readAsString();
        List<List<dynamic>> csvTable =
            const CsvToListConverter().convert(csvData, eol: '\n');

        setState(() {
          studentNames = csvTable.map((row) => row[0].toString()).toList();
        });

        setState(() {
          _isFileUploaded = true;
        });

        showSnackBar('File Uploaded Successfully');
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        _isFileUploaded = false;
      });
      showSnackBar(e.toString()); // not showing
    }
  }

  String finalDateTime() {
    DateTime currentDate = DateTime.now();
    String formattedDate =
        "${currentDate.day.toString().padLeft(2, '0')} - ${currentDate.month.toString().padLeft(2, '0')} - ${currentDate.year}";

    String period = currentDate.hour < 12 ? 'AM' : 'PM';
    int hour12 = currentDate.hour == 12 ? 12 : currentDate.hour % 12;
    String formattedTime =
        "    Time : $hour12:${currentDate.minute.toString().padLeft(2, '0')} $period";

    String finalDateTime = formattedDate + formattedTime;

    return finalDateTime;
  }

  void _saveAttendance() {
    List<Student> temp = [];
    for (var student in students) {
      var newStudent = Student(
        rollNo: student.rollNo,
        name: student.name,
        isPresent: student.isPresent,
      );
      temp.add(newStudent);
      if (newStudent.isPresent) {
        presentStudents.add(newStudent);
      }
      student.isPresent = false;
    }

    AttendanceRecord record = AttendanceRecord(finalDateTime(), temp);

    // Save record to your history list or storage here
    print(record.students.length);
    attendanceHistory.add(record);

    setState(() {
      presentee = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance App',
          style: GoogleFonts.lato(),
        ),
        actions: [
          presentee == 0
              ? Container()
              : IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: _saveAttendance,
                )
        ],
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _showNames
                  ? Container()
                  : ElevatedButton(
                      onPressed: () => _uploadCSV(),
                      child: const Text('Import CSV'),
                    ),
              _isFileUploaded
                  ? Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: const Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                        ),
                      ),
                      child: !_showNames ? Text(_fileName) : Container(),
                    )
                  : Container(),
            ],
          ),
          _isFileSelected
              ? !_showNames
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showNames = true;
                        });
                      },
                      child: const Text('Upload'),
                    )
                  : Container()
              : Container(),
          _showNames
              ? Expanded(
                  child: ListView.builder(
                    itemCount: studentNames.length,
                    itemBuilder: (context, index) {
                      bool isSelected = false;
                      List<int> numbers = List.generate(
                          studentNames.length, (index) => index + 1);

                      // adding students to list
                      students.add(
                        Student(
                          rollNo: numbers[index],
                          name: studentNames[index],
                          isPresent: false,
                        ),
                      );
                      // studentList.reversed;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Card(
                          color: Colors.white,
                          elevation: 5,
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            child: ListTile(
                              // onTap: () {
                              //   setState(() {
                              //     students[index].isPresent =
                              //         !students[index].isPresent;
                              //   });

                              //   setState(() {
                              //     isSelected = !isSelected;

                              //     if (isSelected) {
                              //       presentee++;
                              //     } else {
                              //       presentee--;
                              //     }
                              //   });
                              // },
                              title: Text(
                                  '${students[index].rollNo}.   ${students[index].name}'),
                              trailing: Checkbox(
                                value: students[index].isPresent,
                                onChanged: (value) {
                                  setState(() {
                                    students[index].isPresent = value!;
                                  });

                                  setState(() {
                                    isSelected = value!;

                                    if (isSelected) {
                                      presentee++;
                                    } else {
                                      presentee--;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
