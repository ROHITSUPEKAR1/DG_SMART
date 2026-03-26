import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../core/theme/app_theme.dart';

class DummyDataService {
  // ─── STUDENTS ─────────────────────────────────────────────────────────────

  static List<Student> get students => [
    Student(
      id: 's001', name: 'Aryan Mehta', rollNo: 'STU-089',
      className: '9', division: 'A', parentName: 'Rajesh Mehta',
      parentPhone: '+91 98765 43210', email: 'aryan@school.in',
      dob: '12 May 2010', address: 'Pune, Maharashtra',
      admissionNo: 'ADM-2022-0089', classTeacher: 'Mrs. Patil',
      feeStatus: FeeStatus.paid, attendance: 88.0,
      avgScore: 82.0, classRank: 3, activities: 4,
    ),
    Student(
      id: 's002', name: 'Priya Rathi', rollNo: 'STU-090',
      className: '7', division: 'B', parentName: 'Sunita Rathi',
      parentPhone: '+91 98711 23456', email: 'priya@school.in',
      dob: '8 Jan 2011', address: 'Pune, Maharashtra',
      admissionNo: 'ADM-2023-0090', classTeacher: 'Mr. Kulkarni',
      feeStatus: FeeStatus.paid, attendance: 92.0,
      avgScore: 91.5, classRank: 1, activities: 5,
    ),
    Student(
      id: 's003', name: 'Sahil Khan', rollNo: 'STU-091',
      className: '10', division: 'A', parentName: 'Farhan Khan',
      parentPhone: '+91 99887 65432', email: 'sahil@school.in',
      dob: '22 Mar 2009', address: 'Pune, Maharashtra',
      admissionNo: 'ADM-2021-0091', classTeacher: 'Mr. Sharma',
      feeStatus: FeeStatus.pending, attendance: 74.0,
      avgScore: 66.0, classRank: 28, activities: 1,
    ),
    Student(
      id: 's004', name: 'Ananya More', rollNo: 'STU-092',
      className: '6', division: 'C', parentName: 'Vijay More',
      parentPhone: '+91 97654 32109', email: 'ananya@school.in',
      dob: '5 Jun 2012', address: 'Pune, Maharashtra',
      admissionNo: 'ADM-2024-0092', classTeacher: 'Ms. Patil',
      feeStatus: FeeStatus.paid, attendance: 95.0,
      avgScore: 94.0, classRank: 1, activities: 6,
    ),
    Student(
      id: 's005', name: 'Raj Desai', rollNo: 'STU-093',
      className: '8', division: 'B', parentName: 'Meena Desai',
      parentPhone: '+91 96543 21098', email: 'raj@school.in',
      dob: '15 Sep 2010', address: 'Pune, Maharashtra',
      admissionNo: 'ADM-2022-0093', classTeacher: 'Mrs. More',
      feeStatus: FeeStatus.overdue, attendance: 61.0,
      avgScore: 56.0, classRank: 38, activities: 0,
    ),
    Student(
      id: 's006', name: 'Kavya Patil', rollNo: 'STU-094',
      className: '9', division: 'B', parentName: 'Suresh Patil',
      parentPhone: '+91 95432 10987', email: 'kavya@school.in',
      dob: '30 Nov 2010', address: 'Pune, Maharashtra',
      admissionNo: 'ADM-2022-0094', classTeacher: 'Mr. Rane',
      feeStatus: FeeStatus.paid, attendance: 91.0,
      avgScore: 88.0, classRank: 5, activities: 3,
    ),
  ];

  // ─── TEACHERS ──────────────────────────────────────────────────────────────

  static List<Teacher> get teachers => [
    Teacher(
      id: 't001', name: 'Mr. R. Sharma', employeeId: 'EMP-001',
      subject: 'Mathematics', department: 'Math Dept.',
      phone: '+91 98765 11111', email: 'sharma@dgsmart.in',
      qualification: 'M.Sc. Mathematics', classes: ['9A', '9B', '10A'],
      attendance: 96.0, status: 'Active', experience: 12,
    ),
    Teacher(
      id: 't002', name: 'Mrs. S. Desai', employeeId: 'EMP-002',
      subject: 'Science', department: 'Science Dept.',
      phone: '+91 98765 22222', email: 'sneha@dgsmart.in',
      qualification: 'M.Sc. Chemistry', classes: ['8A', '9A', '9B'],
      attendance: 94.0, status: 'Active', experience: 8,
    ),
    Teacher(
      id: 't003', name: 'Ms. M. Kulkarni', employeeId: 'EMP-003',
      subject: 'English', department: 'English Dept.',
      phone: '+91 98765 33333', email: 'kulkarni@dgsmart.in',
      qualification: 'M.A. English Literature', classes: ['7B', '8A', '9A'],
      attendance: 98.0, status: 'Active', experience: 10,
    ),
    Teacher(
      id: 't004', name: 'Mrs. P. Joshi', employeeId: 'EMP-004',
      subject: 'History', department: 'History Dept.',
      phone: '+91 98765 44444', email: 'joshi@dgsmart.in',
      qualification: 'M.A. History', classes: ['6A', '7A', '8B'],
      attendance: 78.0, status: 'On Leave', experience: 15,
    ),
    Teacher(
      id: 't005', name: 'Mr. V. Patil', employeeId: 'EMP-005',
      subject: 'Geography', department: 'Geography Dept.',
      phone: '+91 98765 55555', email: 'vpatil@dgsmart.in',
      qualification: 'M.Sc. Geography', classes: ['7C', '8A', '9B'],
      attendance: 91.0, status: 'Active', experience: 7,
    ),
  ];

  // ─── ATTENDANCE SUMMARY (Student) ──────────────────────────────────────────

  static AttendanceSummary get studentAttendanceSummary => AttendanceSummary(
    present: 22,
    absent: 3,
    holiday: 2,
    late: 0,
    percentage: 88.0,
    monthlyData: {
      1: AttendanceStatus.holiday, 2: AttendanceStatus.holiday,
      3: AttendanceStatus.present, 4: AttendanceStatus.present,
      5: AttendanceStatus.present, 6: AttendanceStatus.present,
      7: AttendanceStatus.present, 8: AttendanceStatus.holiday,
      9: AttendanceStatus.holiday,
      10: AttendanceStatus.present, 11: AttendanceStatus.present,
      12: AttendanceStatus.absent, 13: AttendanceStatus.present,
      14: AttendanceStatus.present, 15: AttendanceStatus.holiday,
      16: AttendanceStatus.holiday,
      17: AttendanceStatus.present, 18: AttendanceStatus.present,
      19: AttendanceStatus.present, 20: AttendanceStatus.absent,
      21: AttendanceStatus.present, 22: AttendanceStatus.holiday,
      23: AttendanceStatus.holiday,
      24: AttendanceStatus.present, 25: AttendanceStatus.present,
      26: AttendanceStatus.present, 27: AttendanceStatus.present,
      28: AttendanceStatus.present, 29: AttendanceStatus.holiday,
      30: AttendanceStatus.holiday,
      31: AttendanceStatus.absent,
    },
  );

  static List<AttendanceRecord> get recentAttendance => [
    AttendanceRecord(
      id: 'a001', studentId: 's001', studentName: 'Aryan Mehta',
      date: DateTime(2026, 3, 24), status: AttendanceStatus.present,
      checkInTime: '8:07 AM', className: '9A', subject: 'All',
    ),
    AttendanceRecord(
      id: 'a002', studentId: 's001', studentName: 'Aryan Mehta',
      date: DateTime(2026, 3, 21), status: AttendanceStatus.present,
      checkInTime: '8:12 AM', className: '9A', subject: 'All',
    ),
    AttendanceRecord(
      id: 'a003', studentId: 's001', studentName: 'Aryan Mehta',
      date: DateTime(2026, 3, 20), status: AttendanceStatus.absent,
      checkInTime: null, className: '9A', subject: 'All',
    ),
    AttendanceRecord(
      id: 'a004', studentId: 's001', studentName: 'Aryan Mehta',
      date: DateTime(2026, 3, 19), status: AttendanceStatus.present,
      checkInTime: '8:05 AM', className: '9A', subject: 'All',
    ),
  ];

  // ─── HOMEWORK ──────────────────────────────────────────────────────────────

  static List<Homework> get homeworks => [
    Homework(
      id: 'hw001', title: 'Chapter 7 – Quadratic Equations',
      subject: 'Mathematics', teacherName: 'Mr. Sharma',
      className: '9A', description: 'Exercise 7.3 – Q1 to Q10',
      dueDate: DateTime(2026, 3, 24), isCompleted: false,
      submittedCount: null, totalCount: null,
    ),
    Homework(
      id: 'hw002', title: 'Essay – Impact of Climate Change',
      subject: 'English', teacherName: 'Ms. Kulkarni',
      className: '9A', description: 'Min 500 words · A4 size',
      dueDate: DateTime(2026, 3, 26), isCompleted: false,
      submittedCount: null, totalCount: null,
    ),
    Homework(
      id: 'hw003', title: 'Periodic Table – Elements 1–20',
      subject: 'Science', teacherName: 'Mrs. Desai',
      className: '9A', description: 'Learn all elements from 1–20',
      dueDate: DateTime(2026, 3, 22), isCompleted: true,
      submittedCount: null, totalCount: null,
    ),
    Homework(
      id: 'hw004', title: 'Map Work – Rivers of India',
      subject: 'Geography', teacherName: 'Mr. Patil',
      className: '9A', description: 'Mark and label all major rivers',
      dueDate: DateTime(2026, 3, 21), isCompleted: true,
      submittedCount: null, totalCount: null,
    ),
  ];

  static List<Homework> get teacherHomeworks => [
    Homework(
      id: 'hw010', title: 'Photosynthesis – Diagram',
      subject: 'Science', teacherName: 'Mrs. Desai',
      className: '9A', description: 'Draw and label photosynthesis process',
      dueDate: DateTime(2026, 3, 25), isCompleted: false,
      submittedCount: 38, totalCount: 48,
    ),
    Homework(
      id: 'hw011', title: 'Periodic Table – Elements',
      subject: 'Science', teacherName: 'Mrs. Desai',
      className: '8A', description: 'Learn first 20 elements',
      dueDate: DateTime(2026, 3, 24), isCompleted: false,
      submittedCount: 12, totalCount: 42,
    ),
    Homework(
      id: 'hw012', title: 'Chapter 7 – Chemical Reactions',
      subject: 'Science', teacherName: 'Mrs. Desai',
      className: '9A', description: 'Solve exercise 7.2, Q1 to Q8',
      dueDate: DateTime(2026, 3, 26), isCompleted: false,
      submittedCount: 0, totalCount: 48,
    ),
  ];

  // ─── EXAM RESULTS ──────────────────────────────────────────────────────────

  static ExamResult get studentExamResult => ExamResult(
    id: 'ex001', examName: 'Unit Test 1',
    studentName: 'Aryan Mehta', className: '9A',
    subjects: [
      SubjectMark(subject: 'Mathematics', marks: 87, maxMarks: 100, grade: 'A', remarks: '', color: const Color(0xFF3b9ef5)),
      SubjectMark(subject: 'Science', marks: 91, maxMarks: 100, grade: 'A+', remarks: '', color: const Color(0xFF1a9e75)),
      SubjectMark(subject: 'English', marks: 74, maxMarks: 100, grade: 'B+', remarks: '', color: const Color(0xFFe8a020)),
      SubjectMark(subject: 'History', marks: 68, maxMarks: 100, grade: 'B', remarks: '', color: const Color(0xFFc83a3a)),
      SubjectMark(subject: 'Geography', marks: 80, maxMarks: 100, grade: 'A', remarks: '', color: const Color(0xFF7b5edb)),
    ],
    avgPercentage: 84.0,
    grade: 'A',
    rank: 3,
  );

  // Marks entry list for teacher
  static List<Map<String, dynamic>> get marksEntryList => [
    {'name': 'Aryan Mehta', 'marks': 46, 'grade': 'A+', 'remarks': 'Excellent', 'color': const Color(0xFF1a9e75)},
    {'name': 'Priya Rathi', 'marks': 48, 'grade': 'A+', 'remarks': 'Outstanding', 'color': const Color(0xFF1a9e75)},
    {'name': 'Sahil Khan', 'marks': 31, 'grade': 'B', 'remarks': 'Needs work', 'color': const Color(0xFFe8a020)},
    {'name': 'Ananya More', 'marks': 49, 'grade': 'A+', 'remarks': 'Topper!', 'color': const Color(0xFF1a9e75)},
    {'name': 'Raj Desai', 'marks': 22, 'grade': 'D', 'remarks': 'Remedial', 'color': const Color(0xFFc83a3a)},
    {'name': 'Kavya Patil', 'marks': 44, 'grade': 'A', 'remarks': 'Good', 'color': const Color(0xFF1a9e75)},
  ];

  // ─── TIMETABLE ─────────────────────────────────────────────────────────────

  static List<TimetablePeriod> get timetable => [
    TimetablePeriod(
      subject: 'Mathematics', teacher: 'Mr. Sharma', room: 'Room 204',
      startTime: '8:00 AM', endTime: '9:00 AM',
      bgColor: AppColors.chipBlueBg, textColor: AppColors.chipBlueText,
      icon: '➗', isNow: false,
    ),
    TimetablePeriod(
      subject: 'Science', teacher: 'Mrs. Desai', room: 'Lab · Room 301',
      startTime: '9:00 AM', endTime: '10:00 AM',
      bgColor: Colors.white, textColor: AppColors.textPrimary,
      icon: '🔬', isNow: true,
    ),
    TimetablePeriod(
      subject: 'English', teacher: 'Ms. Kulkarni', room: 'Room 102',
      startTime: '10:15 AM', endTime: '11:15 AM',
      bgColor: AppColors.chipAmberBg, textColor: AppColors.chipAmberText,
      icon: '📖', isNow: false,
    ),
    TimetablePeriod(
      subject: 'Geography', teacher: 'Mr. Patil', room: 'Room 205',
      startTime: '11:15 AM', endTime: '12:15 PM',
      bgColor: AppColors.chipPurpleBg, textColor: AppColors.chipPurpleText,
      icon: '🌍', isNow: false,
    ),
    TimetablePeriod(
      subject: 'History', teacher: 'Mrs. Joshi', room: 'Room 103',
      startTime: '1:00 PM', endTime: '2:00 PM',
      bgColor: AppColors.chipRedBg, textColor: AppColors.chipRedText,
      icon: '📜', isNow: false,
    ),
    TimetablePeriod(
      subject: 'Computer Science', teacher: 'Mr. Rane', room: 'Lab · Room 401',
      startTime: '2:00 PM', endTime: '3:00 PM',
      bgColor: AppColors.chipGreenBg, textColor: AppColors.chipGreenText,
      icon: '🖥️', isNow: false,
    ),
  ];

  // ─── NOTICES ───────────────────────────────────────────────────────────────

  static List<Notice> get notices => [
    Notice(
      id: 'n001', title: 'Annual Sports Day – Registration Open',
      description: 'Last date: 28 March 2026',
      date: DateTime(2026, 3, 24), icon: '📢',
      dotColor: AppColors.error, targetAudience: 'All Classes',
      deliveredCount: 1248,
    ),
    Notice(
      id: 'n002', title: 'Unit Test – Maths & Science',
      description: 'Scheduled: 1 April 2026',
      date: DateTime(2026, 3, 23), icon: '📆',
      dotColor: AppColors.warning, targetAudience: 'Class 8–10',
      deliveredCount: 432,
    ),
    Notice(
      id: 'n003', title: 'Science Olympiad – Register Now',
      description: 'Last date: 2 April 2026',
      date: DateTime(2026, 3, 20), icon: '🏆',
      dotColor: AppColors.primary, targetAudience: 'Class 6–10',
      deliveredCount: 780,
    ),
    Notice(
      id: 'n004', title: 'Parent-Teacher Meeting – 30 March',
      description: 'All parents · 10 AM onwards',
      date: DateTime(2026, 3, 28), icon: '👨‍👩‍👧',
      dotColor: AppColors.success, targetAudience: 'All Parents',
      deliveredCount: null,
    ),
    Notice(
      id: 'n005', title: 'Fee Due Reminder – March Term',
      description: 'Kindly clear dues before 31 March',
      date: DateTime(2026, 3, 22), icon: '💰',
      dotColor: AppColors.primary, targetAudience: 'Parents',
      deliveredCount: 47,
    ),
  ];

  // ─── FEE ITEMS ─────────────────────────────────────────────────────────────

  static List<FeeItem> get feeItems => [
    FeeItem(name: 'Tuition Fee – Term 1', amount: 8000, status: FeeStatus.paid, paidDate: '5 Jun 2025'),
    FeeItem(name: 'Tuition Fee – Term 2', amount: 8000, status: FeeStatus.paid, paidDate: '2 Jan 2026'),
    FeeItem(name: 'Annual Charges', amount: 3500, status: FeeStatus.paid, paidDate: '5 Jun 2025'),
    FeeItem(name: 'Transport Fee (Both Terms)', amount: 6000, status: FeeStatus.paid, paidDate: '5 Jun 2025'),
    FeeItem(name: 'Library Fee', amount: 500, status: FeeStatus.paid, paidDate: '5 Jun 2025'),
  ];

  static List<FeeTransaction> get feeTransactions => [
    FeeTransaction(
      id: 'ft001', title: 'Fee Receipt – Jan 2026',
      subtitle: 'Tuition Term 2 · 2 Jan 2026',
      amount: 8000, date: DateTime(2026, 1, 2), isCredit: true,
    ),
    FeeTransaction(
      id: 'ft002', title: 'Fee Receipt – Jun 2025',
      subtitle: 'Tuition T1 + Annual + Transport + Library',
      amount: 15000, date: DateTime(2025, 6, 5), isCredit: true,
    ),
  ];

  // ─── LEAVE REQUESTS ────────────────────────────────────────────────────────

  static List<LeaveRequest> get leaveRequests => [
    LeaveRequest(
      id: 'lv001', teacherName: 'Mrs. P. Joshi', teacherId: 't004',
      leaveType: 'Medical Leave', fromDate: DateTime(2026, 3, 25),
      toDate: DateTime(2026, 3, 28), reason: 'Medical checkup',
      status: LeaveStatus.pending, days: 4,
    ),
    LeaveRequest(
      id: 'lv002', teacherName: 'Mr. A. Rane', teacherId: 't006',
      leaveType: 'Casual Leave', fromDate: DateTime(2026, 3, 30),
      toDate: DateTime(2026, 3, 30), reason: 'Personal work',
      status: LeaveStatus.pending, days: 1,
    ),
  ];

  // Teacher own leave history
  static List<LeaveRequest> get teacherLeaveHistory => [
    LeaveRequest(
      id: 'lv010', teacherName: 'Mrs. S. Desai', teacherId: 't002',
      leaveType: 'Medical Leave', fromDate: DateTime(2026, 3, 25),
      toDate: DateTime(2026, 3, 28), reason: 'Medical checkup',
      status: LeaveStatus.pending, days: 4,
    ),
    LeaveRequest(
      id: 'lv011', teacherName: 'Mrs. S. Desai', teacherId: 't002',
      leaveType: 'Casual Leave', fromDate: DateTime(2026, 2, 10),
      toDate: DateTime(2026, 2, 10), reason: 'Personal work',
      status: LeaveStatus.approved, days: 1,
    ),
  ];

  // ─── MEETINGS ──────────────────────────────────────────────────────────────

  static List<Meeting> get meetings => [
    Meeting(
      id: 'm001', parentName: 'Mrs. Sunita Mehta',
      teacherName: 'Mrs. S. Desai', subject: 'Science',
      date: DateTime(2026, 3, 30), time: '10:00 AM',
      room: 'Room 301', status: 'Confirmed',
      message: "I'd like to discuss Aryan's History performance.",
    ),
  ];

  // ─── ADMIN STATS ───────────────────────────────────────────────────────────

  static Map<String, dynamic> get adminDashboardStats => {
    'totalStudents': 1248,
    'totalTeachers': 64,
    'feeCollected': '₹4.2L',
    'feePending': 47,
    'avgAttendance': 91.0,
    'totalClasses': 32,
  };

  static List<Map<String, dynamic>> get classAttendanceOverview => [
    {'class': 'Class 10', 'attendance': 96.0, 'color': AppColors.success},
    {'class': 'Class 9', 'attendance': 94.0, 'color': AppColors.success},
    {'class': 'Class 7', 'attendance': 91.0, 'color': AppColors.primary},
    {'class': 'Class 8', 'attendance': 89.0, 'color': AppColors.primary},
    {'class': 'Class 6', 'attendance': 78.0, 'color': AppColors.warning},
  ];

  // ─── AUTH ──────────────────────────────────────────────────────────────────

  static AppUser? authenticate(String credential, String password, UserRole role) {
    // Dummy authentication - in production this calls a real API
    switch (role) {
      case UserRole.teacher:
        if (credential == 'EMP-002' || credential == 'sneha@dgsmart.in') {
          return AppUser(
            id: 't002', name: 'Mrs. Sneha Desai',
            email: 'sneha@dgsmart.in', phone: '+91 98765 22222',
            role: UserRole.teacher, avatarInitials: 'SD',
            employeeId: 'EMP-002',
          );
        }
        // Any teacher credential for demo
        return AppUser(
          id: 't001', name: 'Mr. R. Sharma',
          email: 'sharma@dgsmart.in', phone: '+91 98765 11111',
          role: UserRole.teacher, avatarInitials: 'RS',
          employeeId: 'EMP-001',
        );

      case UserRole.parent:
        return AppUser(
          id: 'p001', name: 'Mrs. Sunita Mehta',
          email: 'sunita@gmail.com', phone: '+91 98765 43210',
          role: UserRole.parent, avatarInitials: 'SM',
          parentOf: 'Aryan Mehta',
        );

      case UserRole.student:
        return AppUser(
          id: 's001', name: 'Aryan Mehta',
          email: 'aryan@school.in', phone: '+91 98765 43210',
          role: UserRole.student, avatarInitials: 'AM',
          studentId: 'STU-089',
        );

      case UserRole.admin:
        return AppUser(
          id: 'admin001', name: 'Admin User',
          email: 'admin@dgsmart.in', phone: '+91 20 2745 6789',
          role: UserRole.admin, avatarInitials: 'AD',
        );
    }
  }

  // ─── TEACHER CLASSES ───────────────────────────────────────────────────────

  static List<Map<String, dynamic>> get teacherTodayClasses => [
    {'subject': 'Science', 'class': 'Class 9A', 'time': '9:00 – 10:00 AM', 'room': 'Lab Room 301', 'status': 'Now', 'bgColor': AppColors.chipPurpleBg, 'textColor': AppColors.chipPurpleText, 'icon': '🔬'},
    {'subject': 'Science', 'class': 'Class 8A', 'time': '10:15 – 11:15 AM', 'room': 'Room 204', 'status': 'Next', 'bgColor': AppColors.chipBlueBg, 'textColor': AppColors.chipBlueText, 'icon': '🔬'},
    {'subject': 'Science', 'class': 'Class 9B', 'time': '1:00 – 2:00 PM', 'room': 'Room 301', 'status': 'Later', 'bgColor': AppColors.chipGreenBg, 'textColor': AppColors.chipGreenText, 'icon': '🧪'},
  ];

  // ─── ATTENDANCE GRID (for teacher mark attendance) ─────────────────────────

  static List<Map<String, dynamic>> get classStudentsAttendance => [
    {'name': 'Aryan M.', 'status': 'P'},
    {'name': 'Priya R.', 'status': 'P'},
    {'name': 'Sahil K.', 'status': 'A'},
    {'name': 'Ananya M.', 'status': 'P'},
    {'name': 'Raj D.', 'status': 'L'},
    {'name': 'Kavya P.', 'status': 'P'},
    {'name': 'Rohan K.', 'status': 'P'},
    {'name': 'Sneha W.', 'status': 'A'},
    {'name': 'Amit S.', 'status': 'P'},
    {'name': 'Neha J.', 'status': 'P'},
  ];
}
