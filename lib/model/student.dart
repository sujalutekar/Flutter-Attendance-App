class Student {
  final int rollNo;
  final String name;
  bool isPresent;

  Student({required this.rollNo, required this.name, required this.isPresent});
}

class AttendanceRecord {
  final String date;
  final List<Student> students;

  AttendanceRecord(this.date, this.students);
}

List<AttendanceRecord> attendanceHistory = [];
