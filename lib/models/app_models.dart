import 'package:flutter/material.dart';

// ─── ENUMS ─────────────────────────────────────────────────────────────────

enum UserRole { student, teacher, parent, admin }

enum AttendanceStatus { present, absent, late, leave, holiday }

enum FeeStatus { paid, pending, overdue }

enum LeaveStatus { pending, approved, rejected }

// ─── USER MODEL ────────────────────────────────────────────────────────────

class AppUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final UserRole role;
  final String avatarInitials;
  final String? employeeId;
  final String? studentId;
  final String? parentOf;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.avatarInitials,
    this.employeeId,
    this.studentId,
    this.parentOf,
  });
}

// ─── STUDENT ───────────────────────────────────────────────────────────────

class Student {
  final String id;
  final String name;
  final String rollNo;
  final String className;
  final String division;
  final String parentName;
  final String parentPhone;
  final String email;
  final String dob;
  final String address;
  final String admissionNo;
  final String classTeacher;
  final FeeStatus feeStatus;
  final double attendance;
  final double avgScore;
  final int classRank;
  final int activities;

  Student({
    required this.id,
    required this.name,
    required this.rollNo,
    required this.className,
    required this.division,
    required this.parentName,
    required this.parentPhone,
    required this.email,
    required this.dob,
    required this.address,
    required this.admissionNo,
    required this.classTeacher,
    required this.feeStatus,
    required this.attendance,
    required this.avgScore,
    required this.classRank,
    required this.activities,
  });

  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}';
    return name.substring(0, 2).toUpperCase();
  }

  String get fullClass => '$className\u2013$division';
}

// ─── TEACHER ───────────────────────────────────────────────────────────────

class Teacher {
  final String id;
  final String name;
  final String employeeId;
  final String subject;
  final String department;
  final String phone;
  final String email;
  final String qualification;
  final List<String> classes;
  final double attendance;
  final String status;
  final int experience;

  Teacher({
    required this.id,
    required this.name,
    required this.employeeId,
    required this.subject,
    required this.department,
    required this.phone,
    required this.email,
    required this.qualification,
    required this.classes,
    required this.attendance,
    required this.status,
    required this.experience,
  });

  String get initials {
    final parts = name.replaceAll('Mr. ', '').replaceAll('Mrs. ', '').replaceAll('Ms. ', '').split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[parts.length - 1][0]}';
    return name.substring(0, 2).toUpperCase();
  }
}

// ─── ATTENDANCE ────────────────────────────────────────────────────────────

class AttendanceRecord {
  final String id;
  final String studentId;
  final String studentName;
  final DateTime date;
  final AttendanceStatus status;
  final String? checkInTime;
  final String className;
  final String subject;

  AttendanceRecord({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.date,
    required this.status,
    this.checkInTime,
    required this.className,
    required this.subject,
  });
}

class AttendanceSummary {
  final int present;
  final int absent;
  final int holiday;
  final int late;
  final double percentage;
  final Map<int, AttendanceStatus> monthlyData;

  AttendanceSummary({
    required this.present,
    required this.absent,
    required this.holiday,
    required this.late,
    required this.percentage,
    required this.monthlyData,
  });
}

// ─── HOMEWORK ──────────────────────────────────────────────────────────────

class Homework {
  final String id;
  final String title;
  final String subject;
  final String teacherName;
  final String className;
  final String description;
  final DateTime dueDate;
  final bool isCompleted;
  final String? attachment;
  final int? submittedCount;
  final int? totalCount;

  Homework({
    required this.id,
    required this.title,
    required this.subject,
    required this.teacherName,
    required this.className,
    required this.description,
    required this.dueDate,
    required this.isCompleted,
    this.attachment,
    this.submittedCount,
    this.totalCount,
  });
}

// ─── MARKS / RESULT ────────────────────────────────────────────────────────

class SubjectMark {
  final String subject;
  final int marks;
  final int maxMarks;
  final String grade;
  final String remarks;
  final Color color;

  SubjectMark({
    required this.subject,
    required this.marks,
    required this.maxMarks,
    required this.grade,
    required this.remarks,
    required this.color,
  });

  double get percentage => (marks / maxMarks) * 100;
}

class ExamResult {
  final String id;
  final String examName;
  final String studentName;
  final String className;
  final List<SubjectMark> subjects;
  final double avgPercentage;
  final String grade;
  final int rank;

  ExamResult({
    required this.id,
    required this.examName,
    required this.studentName,
    required this.className,
    required this.subjects,
    required this.avgPercentage,
    required this.grade,
    required this.rank,
  });
}

// ─── TIMETABLE ─────────────────────────────────────────────────────────────

class TimetablePeriod {
  final String subject;
  final String teacher;
  final String room;
  final String startTime;
  final String endTime;
  final Color bgColor;
  final Color textColor;
  final String icon;
  final bool isNow;

  TimetablePeriod({
    required this.subject,
    required this.teacher,
    required this.room,
    required this.startTime,
    required this.endTime,
    required this.bgColor,
    required this.textColor,
    required this.icon,
    this.isNow = false,
  });
}

// ─── NOTICE ────────────────────────────────────────────────────────────────

class Notice {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String icon;
  final Color dotColor;
  final String targetAudience;
  final int? deliveredCount;

  Notice({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.icon,
    required this.dotColor,
    this.targetAudience = 'All',
    this.deliveredCount,
  });
}

// ─── FEE ───────────────────────────────────────────────────────────────────

class FeeItem {
  final String name;
  final double amount;
  final FeeStatus status;
  final String? paidDate;
  final String? dueDate;

  FeeItem({
    required this.name,
    required this.amount,
    required this.status,
    this.paidDate,
    this.dueDate,
  });
}

class FeeTransaction {
  final String id;
  final String title;
  final String subtitle;
  final double amount;
  final DateTime date;
  final bool isCredit;

  FeeTransaction({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.isCredit,
  });
}

// ─── LEAVE ─────────────────────────────────────────────────────────────────

class LeaveRequest {
  final String id;
  final String teacherName;
  final String teacherId;
  final String leaveType;
  final DateTime fromDate;
  final DateTime toDate;
  final String reason;
  final LeaveStatus status;
  final int days;

  LeaveRequest({
    required this.id,
    required this.teacherName,
    required this.teacherId,
    required this.leaveType,
    required this.fromDate,
    required this.toDate,
    required this.reason,
    required this.status,
    required this.days,
  });
}

// ─── MEETING ───────────────────────────────────────────────────────────────

class Meeting {
  final String id;
  final String parentName;
  final String teacherName;
  final String subject;
  final DateTime date;
  final String time;
  final String room;
  final String status;
  final String? message;

  Meeting({
    required this.id,
    required this.parentName,
    required this.teacherName,
    required this.subject,
    required this.date,
    required this.time,
    required this.room,
    required this.status,
    this.message,
  });
}
