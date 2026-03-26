import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../models/app_models.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/dummy_data_service.dart';
import '../../auth/screens/login_screen.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  int _selectedNav = 0;

  final _navItems = [
    {'icon': '🏠', 'label': 'Dashboard', 'section': 'Main'},
    {'icon': '👨‍🎓', 'label': 'Student List', 'section': 'Students'},
    {'icon': '📋', 'label': 'Admission Form', 'section': 'Students'},
    {'icon': '🏫', 'label': 'Classes', 'section': 'Academic'},
    {'icon': '📚', 'label': 'Subjects', 'section': 'Academic'},
    {'icon': '👩‍🏫', 'label': 'Teachers', 'section': 'Academic'},
    {'icon': '📅', 'label': 'Timetable', 'section': 'Academic'},
    {'icon': '📝', 'label': 'Exams & Results', 'section': 'Academic'},
    {'icon': '💰', 'label': 'Fee Management', 'section': 'Finance'},
    {'icon': '📢', 'label': 'Notices', 'section': 'Communication'},
    {'icon': '👥', 'label': 'HR Module', 'section': 'HR & Staff'},
    {'icon': '🚌', 'label': 'Transport', 'section': 'More'},
    {'icon': '📖', 'label': 'Library', 'section': 'More'},
    {'icon': '⚙️', 'label': 'Settings', 'section': 'More'},
  ];

  Widget _buildPage() {
    switch (_selectedNav) {
      case 0: return _buildDashboard();
      case 1: return _buildStudentList();
      case 2: return _buildAdmissionForm();
      case 3: return _buildClasses();
      case 5: return _buildTeachers();
      case 7: return _buildExams();
      case 8: return _buildFees();
      case 9: return _buildNotices();
      case 10: return _buildHR();
      default: return _buildComingSoon(_navItems[_selectedNav]['label'] as String);
    }
  }

  // ─── DASHBOARD ─────────────────────────────────────────────────────────────

  Widget _buildDashboard() {
    final students = DummyDataService.students;
    final notices = DummyDataService.notices;
    final attendance = DummyDataService.classAttendanceOverview;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Good Morning, Admin 👋', style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                  Text('Monday, 24 March 2026 · DG Smart School', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textMuted)),
                ],
              ),
              _AdminBtn(label: '+ Quick Add', isPrimary: true, onTap: () {}),
            ],
          ),
          const SizedBox(height: 20),

          // Stat grid
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 13,
            mainAxisSpacing: 13,
            childAspectRatio: 1.4,
            children: [
              _StatCard(icon: '👨‍🎓', iconBg: AppColors.primaryLight, value: '1,248', label: 'Total Students', change: '↑ 12 this month', isUp: true),
              _StatCard(icon: '👩‍🏫', iconBg: AppColors.successLight, value: '64', label: 'Total Teachers', change: '↑ 2 new', isUp: true),
              _StatCard(icon: '💰', iconBg: AppColors.warningLight, value: '₹4.2L', label: 'Fee Collected', change: '↑ 18% vs last month', isUp: true),
              _StatCard(icon: '⚠️', iconBg: AppColors.errorLight, value: '47', label: 'Fee Pending', change: '5 overdue', isUp: false),
              _StatCard(icon: '📊', iconBg: AppColors.purpleLight, value: '91%', label: 'Avg Attendance', change: '↑ 3% this week', isUp: true),
              _StatCard(icon: '🏫', iconBg: AppColors.primaryLight, value: '32', label: 'Classes', change: '8 divisions', isUp: true),
            ],
          ),
          const SizedBox(height: 20),

          // Two column layout
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left
              Expanded(
                child: Column(
                  children: [
                    // Recent admissions
                    _AdminCard(
                      title: 'Recent Admissions',
                      subtitle: 'Last 7 days',
                      trailing: _AdminBtn(label: 'View All', isPrimary: false, onTap: () => setState(() => _selectedNav = 1)),
                      child: _buildAdmissionsTable(students),
                    ),
                    const SizedBox(height: 14),
                    // Notices card
                    _AdminCard(
                      title: 'Latest Notices',
                      trailing: _AdminBtn(label: '+ New', isPrimary: false, onTap: () => setState(() => _selectedNav = 9)),
                      child: Column(
                        children: notices.take(4).map((n) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Container(width: 7, height: 7, decoration: BoxDecoration(shape: BoxShape.circle, color: n.dotColor)),
                              const SizedBox(width: 11),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(n.title, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                                    Text('${n.targetAudience} · ${n.date.day} Mar', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textMuted)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              // Right
              Expanded(
                child: Column(
                  children: [
                    // Attendance overview
                    _AdminCard(
                      title: 'Attendance Overview',
                      trailing: AppChip.green('This Week', fontSize: 10),
                      child: Column(
                        children: attendance.map((a) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(a['class'] as String, style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w700)),
                                  Text('${(a['attendance'] as double).toInt()}%', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w700, color: a['color'] as Color)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              AppProgressBar(percentage: a['attendance'] as double, fillColor: a['color'] as Color, height: 6),
                            ],
                          ),
                        )).toList(),
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Fee summary
                    _AdminCard(
                      title: 'Fee Summary',
                      trailing: AppChip.amber('March 2026', fontSize: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              _FeeMini(label: 'Collected', value: '₹4.2L', bg: AppColors.chipGreenBg, textColor: AppColors.chipGreenText),
                              const SizedBox(width: 8),
                              _FeeMini(label: 'Pending', value: '₹0.8L', bg: AppColors.chipRedBg, textColor: AppColors.chipRedText),
                              const SizedBox(width: 8),
                              _FeeMini(label: 'Collected', value: '84%', bg: AppColors.chipBlueBg, textColor: AppColors.chipBlueText),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ...[
                            {'label': 'Tuition Fee', 'amount': '₹2,80,000'},
                            {'label': 'Transport Fee', 'amount': '₹84,000'},
                            {'label': 'Library Fee', 'amount': '₹32,000'},
                            {'label': 'Pending', 'amount': '₹80,000', 'isRed': true},
                          ].map((f) => Container(
                            padding: const EdgeInsets.symmetric(vertical: 9),
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(f['label'] as String, style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                                Text(f['amount'] as String, style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w900, color: f['isRed'] == true ? AppColors.error : AppColors.success)),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdmissionsTable(students) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(AppColors.background),
        dataRowMinHeight: 46,
        dataRowMaxHeight: 56,
        columnSpacing: 16,
        columns: ['Student', 'Class', 'Date', 'Status'].map((h) =>
            DataColumn(label: Text(h, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.textMuted, letterSpacing: 0.05)))).toList(),
        rows: students.take(5).map((s) => DataRow(cells: [
          DataCell(Row(children: [
            Container(width: 27, height: 27, decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(9)), child: Center(child: Text(s.initials, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.primary)))),
            const SizedBox(width: 7),
            Text(s.name, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w800)),
          ])),
          DataCell(Text('${s.className}-${s.division}', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w600))),
          DataCell(Text('${24 - students.indexOf(s)} Mar', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w600))),
          DataCell(s.feeStatus == FeeStatus.overdue ? AppChip.red('Inactive') : AppChip.green('Active')),
        ])).toList(),
      ),
    );
  }

  // ─── STUDENT LIST ──────────────────────────────────────────────────────────

  Widget _buildStudentList() {
    final students = DummyDataService.students;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Student List', style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                  Text('${students.length} students shown (1,248 total enrolled)', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textMuted)),
                ],
              ),
              _AdminBtn(label: '+ New Admission', isPrimary: true, onTap: () => setState(() => _selectedNav = 2)),
            ],
          ),
          const SizedBox(height: 16),
          _AdminCard(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(AppColors.background),
                dataRowMinHeight: 50,
                dataRowMaxHeight: 60,
                columnSpacing: 16,
                columns: ['Student', 'Roll No', 'Class', 'Parent', 'Fee Status', 'Attendance', 'Action']
                    .map((h) => DataColumn(label: Text(h, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.textMuted))))
                    .toList(),
                rows: students.map((s) => DataRow(cells: [
                  DataCell(Row(children: [
                    Container(width: 27, height: 27, decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(9)), child: Center(child: Text(s.initials, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.primary)))),
                    const SizedBox(width: 7),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(s.name, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w800)),
                      Text(s.email, style: GoogleFonts.nunito(fontSize: 10, color: AppColors.textMuted)),
                    ]),
                  ])),
                  DataCell(Text(s.rollNo, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w600))),
                  DataCell(Text('${s.className}-${s.division}', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w600))),
                  DataCell(Text(s.parentName, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w600))),
                  DataCell(s.feeStatus == FeeStatus.paid ? AppChip.green('Paid') : s.feeStatus == FeeStatus.pending ? AppChip.amber('Pending') : AppChip.red('Overdue')),
                  DataCell(Text('${s.attendance.toInt()}%', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w900, color: s.attendance >= 80 ? AppColors.success : s.attendance >= 75 ? AppColors.warning : AppColors.error))),
                  DataCell(_AdminBtn(label: 'View', isPrimary: false, onTap: () {})),
                ])).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── ADMISSION FORM ────────────────────────────────────────────────────────

  Widget _buildAdmissionForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Student Admission Form', style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
              Row(children: [
                _AdminBtn(label: 'Save Draft', isPrimary: false, onTap: () {}),
                const SizedBox(width: 8),
                _AdminBtn(label: 'Submit Admission', isPrimary: true, onTap: () {}),
              ]),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _AdminCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FormSection('📋 Personal Information'),
                      _AdminFormGrid([
                        _FormField(label: 'First Name *', hint: 'First name'),
                        _FormField(label: 'Last Name *', hint: 'Last name'),
                        _FormField(label: 'Date of Birth *', hint: 'DD/MM/YYYY'),
                        _FormSelect(label: 'Gender *', options: ['Male', 'Female', 'Other']),
                        _FormSelect(label: 'Blood Group', options: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']),
                        _FormField(label: 'Aadhaar No.', hint: 'XXXX XXXX XXXX'),
                      ]),
                      _FormSection('🏫 Academic Details'),
                      _AdminFormGrid([
                        _FormSelect(label: 'Class *', options: ['Class 6', 'Class 7', 'Class 8', 'Class 9', 'Class 10']),
                        _FormSelect(label: 'Division *', options: ['A', 'B', 'C']),
                        _FormField(label: 'Admission Date *', hint: 'DD/MM/YYYY'),
                        _FormField(label: 'Previous School', hint: 'School name'),
                      ]),
                      _FormSection('🏠 Address'),
                      _FormField(label: 'Full Address *', hint: 'House no, Street, Area...',  multiline: true),
                      const SizedBox(height: 10),
                      _AdminFormGrid([
                        _FormField(label: 'City *', hint: 'City'),
                        _FormField(label: 'PIN Code *', hint: '411001'),
                      ]),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _AdminCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FormSection('👨‍👩‍👦 Parent / Guardian'),
                      _AdminFormGrid([
                        _FormField(label: "Father's Name *", hint: 'Full name'),
                        _FormField(label: "Father's Phone *", hint: '+91 XXXXX XXXXX'),
                        _FormField(label: "Mother's Name", hint: 'Full name'),
                        _FormField(label: "Mother's Phone", hint: '+91 XXXXX XXXXX'),
                        _FormField(label: 'Email', hint: 'parent@email.com'),
                        _FormField(label: 'Occupation', hint: 'Occupation'),
                      ]),
                      _FormSection('💰 Fee & Transport'),
                      _AdminFormGrid([
                        _FormSelect(label: 'Fee Category', options: ['General', 'EWS', 'SC/ST', 'Staff Ward']),
                        _FormSelect(label: 'Transport Required', options: ['No', 'Yes']),
                        _FormSelect(label: 'Bus Route', options: ['N/A', 'Route A – Wakad', 'Route B – Hinjewadi']),
                        _FormSelect(label: 'Library Membership', options: ['Yes', 'No']),
                      ]),
                      _FormSection('📄 Documents Upload'),
                      ...[
                        {'icon': '📎', 'title': 'Birth Certificate', 'sub': 'Click to upload PDF/JPG'},
                        {'icon': '📎', 'title': 'Transfer Certificate', 'sub': 'Click to upload PDF/JPG'},
                        {'icon': '🖼️', 'title': 'Student Photo', 'sub': 'JPG/PNG · max 2MB'},
                      ].map((d) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(9), border: Border.all(color: AppColors.border, style: BorderStyle.solid)),
                        child: Column(
                          children: [
                            Text(d['icon'] as String, style: const TextStyle(fontSize: 18)),
                            const SizedBox(height: 3),
                            Text(d['title'] as String, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textMuted)),
                            Text(d['sub'] as String, style: GoogleFonts.nunito(fontSize: 10, color: AppColors.textMuted)),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── CLASSES ───────────────────────────────────────────────────────────────

  Widget _buildClasses() {
    final classes = [
      {'name': 'Class 6', 'divisions': ['Division A · 42 students · Mrs. Joshi', 'Division B · 38 students · Mr. Kulkarni', 'Division C · 40 students · Ms. Patil'], 'chip': 'blue'},
      {'name': 'Class 7', 'divisions': ['Division A · 44 students · Mrs. Desai', 'Division B · 41 students · Mr. Sharma', 'Division C · 39 students · Mrs. Rane'], 'chip': 'green'},
      {'name': 'Class 8', 'divisions': ['Division A · 46 students · Mr. Patil', 'Division B · 43 students · Mrs. More'], 'chip': 'amber'},
      {'name': 'Class 9', 'divisions': ['Division A · 48 students · Mrs. Patil', 'Division B · 46 students · Mr. Rane'], 'chip': 'purple'},
      {'name': 'Class 10', 'divisions': ['Division A · 50 students · Mr. Sharma', 'Division B · 48 students · Mrs. Kulkarni'], 'chip': 'green'},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Classes & Divisions', style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
              _AdminBtn(label: '+ Add Class', isPrimary: true, onTap: () {}),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: 1.3),
            itemCount: classes.length + 1,
            itemBuilder: (_, i) {
              if (i == classes.length) {
                return GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border, width: 2, style: BorderStyle.solid)),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text('➕', style: TextStyle(fontSize: 26)),
                      const SizedBox(height: 7),
                      Text('Add New Class', style: GoogleFonts.nunito(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.textMuted)),
                    ]),
                  ),
                );
              }
              final c = classes[i];
              return _AdminCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(c['name'] as String, style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                        c['chip'] == 'blue' ? AppChip.blue('${(c['divisions'] as List).length} Divisions') :
                        c['chip'] == 'green' ? AppChip.green('${(c['divisions'] as List).length} Divisions') :
                        c['chip'] == 'amber' ? AppChip.amber('${(c['divisions'] as List).length} Divisions') :
                        AppChip.purple('${(c['divisions'] as List).length} Divisions'),
                      ],
                    ),
                    const SizedBox(height: 11),
                    ...(c['divisions'] as List<String>).map((d) {
                      final parts = d.split(' · ');
                      return Container(
                        margin: const EdgeInsets.only(bottom: 7),
                        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
                        decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(9)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(parts[0], style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                              Text('${parts[1]} · ${parts[2]}', style: GoogleFonts.nunito(fontSize: 10, color: AppColors.textMuted)),
                            ]),
                            _AdminBtn(label: 'Edit', isPrimary: false, onTap: () {}),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─── TEACHERS ──────────────────────────────────────────────────────────────

  Widget _buildTeachers() {
    final teachers = DummyDataService.teachers;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Teachers', style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w900)),
              _AdminBtn(label: '+ Add Teacher', isPrimary: true, onTap: () {}),
            ],
          ),
          const SizedBox(height: 16),
          _AdminCard(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(AppColors.background),
                dataRowMinHeight: 50,
                columnSpacing: 16,
                columns: ['Teacher', 'Emp ID', 'Subject', 'Classes', 'Phone', 'Attendance', 'Status', 'Action']
                    .map((h) => DataColumn(label: Text(h, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.textMuted))))
                    .toList(),
                rows: teachers.map((t) => DataRow(cells: [
                  DataCell(Row(children: [
                    Container(width: 27, height: 27, decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(9)), child: Center(child: Text(t.initials, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.primary)))),
                    const SizedBox(width: 7),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(t.name, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w800)),
                      Text(t.department, style: GoogleFonts.nunito(fontSize: 10, color: AppColors.textMuted)),
                    ]),
                  ])),
                  DataCell(Text(t.employeeId, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w600))),
                  DataCell(Text(t.subject, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w600))),
                  DataCell(Text(t.classes.join(', '), style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w600))),
                  DataCell(Text(t.phone, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w600))),
                  DataCell(Text('${t.attendance.toInt()}%', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w900, color: t.attendance >= 80 ? AppColors.success : AppColors.warning))),
                  DataCell(t.status == 'Active' ? AppChip.green('Active') : AppChip.amber('On Leave')),
                  DataCell(_AdminBtn(label: 'View', isPrimary: false, onTap: () {})),
                ])).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── EXAMS ─────────────────────────────────────────────────────────────────

  Widget _buildExams() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Exams & Results', style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w900)),
              _AdminBtn(label: '+ Create Exam', isPrimary: true, onTap: () {}),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _AdminCard(
                  title: 'Upcoming Exams',
                  child: Column(
                    children: [
                      _ExamCard(title: 'Unit Test – Term 2', sub: 'Class 8–10 · Maths & Science', date: '1 Apr', borderColor: AppColors.primary, chipType: 'amber'),
                      const SizedBox(height: 10),
                      _ExamCard(title: 'Mid-Term Examination', sub: 'All Classes · All Subjects', date: '15 Apr', borderColor: AppColors.purple, chipType: 'purple'),
                      const SizedBox(height: 10),
                      _ExamCard(title: 'Science Practical Exam', sub: 'Class 9, 10 · Lab sessions', date: '20 Apr', borderColor: AppColors.success, chipType: 'green'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _AdminCard(
                  title: 'Result Overview – Unit Test 1',
                  trailing: _AdminBtn(label: '📄 Report Cards', isPrimary: false, onTap: () {}),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: WidgetStateProperty.all(AppColors.background),
                      columnSpacing: 14,
                      columns: ['Student', 'Math', 'Sci', 'Eng', 'Avg', 'Grade']
                          .map((h) => DataColumn(label: Text(h, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.textMuted))))
                          .toList(),
                      rows: [
                        ['Aryan Mehta', '87', '91', '74', '84%', 'A'],
                        ['Priya Rathi', '95', '88', '92', '92%', 'A+'],
                        ['Sahil Khan', '61', '70', '68', '66%', 'B'],
                        ['Ananya More', '98', '94', '90', '94%', 'A+'],
                        ['Raj Desai', '52', '60', '55', '56%', 'C'],
                      ].map((r) => DataRow(cells: [
                        DataCell(Text(r[0], style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w800))),
                        DataCell(Text(r[1], style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w600))),
                        DataCell(Text(r[2], style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w600))),
                        DataCell(Text(r[3], style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w600))),
                        DataCell(Text(r[4], style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w900, color: double.parse(r[4].replaceAll('%', '')) >= 80 ? AppColors.success : AppColors.warning))),
                        DataCell(AppChip.green(r[5])),
                      ])).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── FEES ──────────────────────────────────────────────────────────────────

  Widget _buildFees() {
    final students = DummyDataService.students.where((s) => s.feeStatus != FeeStatus.paid).toList();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Fee Management', style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w900)),
              Row(children: [
                _AdminBtn(label: '📄 Generate Receipt', isPrimary: false, onTap: () {}),
                const SizedBox(width: 8),
                _AdminBtn(label: '+ Collect Fee', isPrimary: true, onTap: () {}),
              ]),
            ],
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 13,
            mainAxisSpacing: 13,
            childAspectRatio: 2.2,
            children: [
              _StatCard(icon: '💵', iconBg: AppColors.successLight, value: '₹4.2L', label: 'Total Collected'),
              _StatCard(icon: '⏳', iconBg: AppColors.errorLight, value: '₹0.8L', label: 'Pending'),
              _StatCard(icon: '⚠️', iconBg: AppColors.warningLight, value: '47', label: 'Students Due'),
              _StatCard(icon: '📄', iconBg: AppColors.primaryLight, value: '312', label: 'Receipts'),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _AdminCard(
                  title: 'Fee Structure – 2025–26',
                  trailing: _AdminBtn(label: 'Edit', isPrimary: false, onTap: () {}),
                  child: Column(
                    children: [
                      ...['Tuition Fee (Term 1) · ₹8,000', 'Tuition Fee (Term 2) · ₹8,000', 'Annual Charges · ₹3,500', 'Transport (per term) · ₹3,000', 'Library Fee · ₹500']
                          .asMap().entries.map((e) => Container(
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(e.value.split(' · ')[0], style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700)),
                            Text(e.value.split(' · ')[1], style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w900)),
                          ],
                        ),
                      )),
                      Container(
                        padding: const EdgeInsets.only(top: 9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total per year', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w900)),
                            Text('₹23,000', style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.primary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _AdminCard(
                  title: 'Pending Fees',
                  trailing: AppChip.red('${students.length + 2} students', fontSize: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 14,
                      headingRowColor: WidgetStateProperty.all(AppColors.background),
                      columns: ['Student', 'Class', 'Amount', 'Due Since', 'Action']
                          .map((h) => DataColumn(label: Text(h, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.textMuted))))
                          .toList(),
                      rows: [
                        ['Sahil Khan', '10-A', '₹8,000', '1 Mar'],
                        ['Raj Desai', '8-B', '₹11,500', '15 Feb'],
                        ['Rohan Kadam', '7-A', '₹8,000', '1 Mar'],
                        ['Sneha Pawar', '6-C', '₹3,500', '10 Mar'],
                      ].map((r) => DataRow(cells: [
                        DataCell(Text(r[0], style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w800))),
                        DataCell(Text(r[1], style: GoogleFonts.nunito(fontSize: 12))),
                        DataCell(Text(r[2], style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.error))),
                        DataCell(Text(r[3], style: GoogleFonts.nunito(fontSize: 12))),
                        DataCell(_AdminBtn(label: 'Collect', isPrimary: true, onTap: () {})),
                      ])).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── NOTICES ───────────────────────────────────────────────────────────────

  Widget _buildNotices() {
    final notices = DummyDataService.notices;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Notices & Circulars', style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w900)),
              _AdminBtn(label: '+ New Notice', isPrimary: true, onTap: () {}),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _AdminCard(
                  title: 'Create Notice / Circular',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FormField(label: 'Title *', hint: 'Notice title...'),
                      const SizedBox(height: 8),
                      _FormField(label: 'Message *', hint: 'Write the notice content...', multiline: true),
                      const SizedBox(height: 8),
                      Text('Target Audience', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                      const SizedBox(height: 4),
                      ...[['✓ All Students', true], ['✓ Parents', true], ['  Teachers', false]].map((c) =>
                          Row(children: [
                            Icon(c[1] as bool ? Icons.check_box : Icons.check_box_outline_blank, size: 16, color: AppColors.primary),
                            const SizedBox(width: 5),
                            Text(c[0] as String, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700)),
                          ])
                      ),
                      const SizedBox(height: 8),
                      _FormSelect(label: 'Class (optional)', options: ['All Classes', 'Class 6', 'Class 7', 'Class 8', 'Class 9', 'Class 10']),
                      const SizedBox(height: 10),
                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(9)),
                          child: Text('📢 Send Notice', textAlign: TextAlign.center, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _AdminCard(
                  title: 'Sent Notices',
                  child: Column(
                    children: notices.map((n) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      child: Row(
                        children: [
                          Container(
                            width: 32, height: 32,
                            decoration: BoxDecoration(color: n.dotColor.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(9)),
                            child: Center(child: Text(n.icon, style: const TextStyle(fontSize: 14))),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(n.title, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w800)),
                                Text('${n.targetAudience} · ${n.date.day} Mar${n.deliveredCount != null ? ' · ${n.deliveredCount} delivered' : ''}', style: GoogleFonts.nunito(fontSize: 10, color: AppColors.textMuted)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── HR ────────────────────────────────────────────────────────────────────

  Widget _buildHR() {
    final leaves = DummyDataService.leaveRequests;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('HR Module', style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w900)),
              _AdminBtn(label: '+ Add Staff', isPrimary: true, onTap: () {}),
            ],
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 4, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 13, mainAxisSpacing: 13, childAspectRatio: 2.2,
            children: [
              _StatCard(icon: '👥', iconBg: AppColors.primaryLight, value: '86', label: 'Total Staff'),
              _StatCard(icon: '✅', iconBg: AppColors.successLight, value: '79', label: 'Present Today'),
              _StatCard(icon: '📋', iconBg: AppColors.warningLight, value: '7', label: 'On Leave'),
              _StatCard(icon: '💵', iconBg: AppColors.purpleLight, value: '₹12.4L', label: 'Monthly Payroll'),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _AdminCard(
                  title: 'Staff Directory',
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: WidgetStateProperty.all(AppColors.background),
                      columnSpacing: 14,
                      columns: ['Name', 'Role', 'Dept.', 'Attendance', 'Status']
                          .map((h) => DataColumn(label: Text(h, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.textMuted))))
                          .toList(),
                      rows: DummyDataService.teachers.take(5).map((t) => DataRow(cells: [
                        DataCell(Row(children: [
                          Container(width: 27, height: 27, decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(9)), child: Center(child: Text(t.initials, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.primary)))),
                          const SizedBox(width: 7),
                          Text(t.name, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w800)),
                        ])),
                        DataCell(Text('Teacher', style: GoogleFonts.nunito(fontSize: 12))),
                        DataCell(Text(t.department.split(' ').first, style: GoogleFonts.nunito(fontSize: 12))),
                        DataCell(Text('${t.attendance.toInt()}%', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w900, color: t.attendance >= 80 ? AppColors.success : AppColors.warning))),
                        DataCell(t.status == 'Active' ? AppChip.green('Active') : AppChip.amber('On Leave')),
                      ])).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  children: [
                    _AdminCard(
                      title: 'Leave Requests',
                      trailing: AppChip.amber('${leaves.length} Pending', fontSize: 10),
                      child: Column(
                        children: leaves.map((l) => Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          padding: const EdgeInsets.all(11),
                          decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text(l.teacherName, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w800)),
                                    Text('${l.leaveType} · ${l.fromDate.day}–${l.toDate.day} Mar · ${l.days} days', style: GoogleFonts.nunito(fontSize: 10, color: AppColors.textMuted)),
                                  ]),
                                  AppChip.amber('Pending'),
                                ],
                              ),
                              const SizedBox(height: 7),
                              Row(children: [
                                _AdminBtn(label: '✓ Approve', isPrimary: true, onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Approved ${l.teacherName} leave')))),
                                const SizedBox(width: 6),
                                _AdminBtn(label: '✗ Reject', isPrimary: false, isRed: true, onTap: () {}),
                              ]),
                            ],
                          ),
                        )).toList(),
                      ),
                    ),
                    const SizedBox(height: 14),
                    _AdminCard(
                      title: 'Payroll – March 2026',
                      trailing: _AdminBtn(label: 'Process All', isPrimary: true, onTap: () {}),
                      child: Column(
                        children: [
                          'Teachers (64) · ₹9,60,000',
                          'Admin Staff (12) · ₹1,44,000',
                          'Support Staff (10) · ₹60,000',
                        ].map((p) => Container(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(p.split(' · ')[0], style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700)),
                              Text(p.split(' · ')[1], style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.success)),
                            ],
                          ),
                        )).followedBy([
                          Container(
                            padding: const EdgeInsets.only(top: 9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Payroll', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w900)),
                                Text('₹12,64,000', style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.primary)),
                              ],
                            ),
                          ),
                        ]).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComingSoon(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🚧', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text(title, style: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          Text('Coming Soon', style: GoogleFonts.nunito(fontSize: 14, color: AppColors.textMuted)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 220,
            color: AppColors.sidebarBg,
            child: Column(
              children: [
                // Logo
                Container(
                  padding: const EdgeInsets.fromLTRB(18, 20, 18, 16),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0x0FFFFFFF)))),
                  child: Row(
                    children: [
                      Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(10)), child: const Center(child: Text('🎓', style: TextStyle(fontSize: 18)))),
                      const SizedBox(width: 10),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('DG Smart', style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w900, color: Colors.white)),
                        Text('Admin Panel', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.4))),
                      ]),
                    ],
                  ),
                ),
                // Nav items
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildNavItems(),
                    ),
                  ),
                ),
                // Logout
                GestureDetector(
                  onTap: () async {
                    await context.read<AuthProvider>().logout();
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (_) => false);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(children: [
                      const Text('🚪', style: TextStyle(fontSize: 15)),
                      const SizedBox(width: 10),
                      Text('Logout', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.7))),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: Column(
              children: [
                // Header
                Container(
                  height: 60,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(child: Text(_navItems[_selectedNav]['label'] as String, style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.textPrimary))),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(color: AppColors.background, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(9)),
                        child: Text('🔍  Search students, teachers...', style: GoogleFonts.nunito(fontSize: 12, color: AppColors.textMuted)),
                      ),
                      const SizedBox(width: 12),
                      Stack(children: [
                        Container(width: 34, height: 34, decoration: BoxDecoration(color: AppColors.background, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(9)), child: const Center(child: Text('🔔', style: TextStyle(fontSize: 15)))),
                        Positioned(top: 6, right: 7, child: Container(width: 7, height: 7, decoration: BoxDecoration(color: AppColors.error, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 1.5)))),
                      ]),
                      const SizedBox(width: 12),
                      Row(children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text('Admin User', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                          Text('DG Smart School', style: GoogleFonts.nunito(fontSize: 10, color: AppColors.textMuted)),
                        ]),
                        const SizedBox(width: 8),
                        Container(width: 34, height: 34, decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(9)), child: Center(child: Text('AD', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.primary)))),
                      ]),
                    ],
                  ),
                ),
                Expanded(child: SingleChildScrollView(child: _buildPage())),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildNavItems() {
    final groupedItems = <String, List<Map<String, dynamic>>>{};
    for (int i = 0; i < _navItems.length; i++) {
      final item = _navItems[i];
      final section = item['section'] as String;
      groupedItems.putIfAbsent(section, () => []);
      groupedItems[section]!.add({...item, 'index': i});
    }

    final result = <Widget>[];
    for (final section in groupedItems.keys) {
      result.add(Padding(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 5),
        child: Text(section.toUpperCase(), style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w800, color: Colors.white.withValues(alpha: 0.28), letterSpacing: 0.1)),
      ));
      for (final item in groupedItems[section]!) {
        final i = item['index'] as int;
        final isActive = _selectedNav == i;
        result.add(GestureDetector(
          onTap: () => setState(() => _selectedNav = i),
          child: Container(
            margin: const EdgeInsets.fromLTRB(12, 1, 12, 1),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Text(item['icon'] as String, style: const TextStyle(fontSize: 15)),
                const SizedBox(width: 10),
                Expanded(child: Text(item['label'] as String, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700, color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.7)))),
                if (i == 8) Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppColors.error, borderRadius: BorderRadius.circular(9)), child: Text('3', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.white))),
              ],
            ),
          ),
        ));
      }
    }
    return result;
  }
}

// ─── HELPER WIDGETS ────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final String icon;
  final Color iconBg;
  final String value;
  final String label;
  final String? change;
  final bool? isUp;

  const _StatCard({required this.icon, required this.iconBg, required this.value, required this.label, this.change, this.isUp});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 40, height: 40, decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(11)), child: Center(child: Text(icon, style: const TextStyle(fontSize: 19)))),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: GoogleFonts.nunito(fontSize: 21, fontWeight: FontWeight.w900, color: AppColors.textPrimary, height: 1)),
                Text(label, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textMuted)),
                if (change != null) Text(change!, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: isUp == true ? AppColors.success : AppColors.error)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminCard extends StatelessWidget {
  final Widget child;
  final String? title;
  final String? subtitle;
  final Widget? trailing;

  const _AdminCard({required this.child, this.title, this.subtitle, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title!, style: GoogleFonts.nunito(fontSize: 13, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                  if (subtitle != null) Text(subtitle!, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textMuted)),
                ]),
                if (trailing != null) trailing!,
              ],
            ),
            const SizedBox(height: 12),
          ],
          child,
        ],
      ),
    );
  }
}

class _AdminBtn extends StatelessWidget {
  final String label;
  final bool isPrimary;
  final bool isRed;
  final VoidCallback onTap;

  const _AdminBtn({required this.label, required this.isPrimary, required this.onTap, this.isRed = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isRed ? AppColors.errorLight : isPrimary ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
          border: isPrimary || isRed ? null : Border.all(color: AppColors.primary),
        ),
        child: Text(label, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w800, color: isRed ? AppColors.error : isPrimary ? Colors.white : AppColors.primary)),
      ),
    );
  }
}

class _FeeMini extends StatelessWidget {
  final String label;
  final String value;
  final Color bg;
  final Color textColor;

  const _FeeMini({required this.label, required this.value, required this.bg, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Text(value, style: GoogleFonts.nunito(fontSize: 17, fontWeight: FontWeight.w900, color: textColor)),
            Text(label, style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w800, color: textColor.withValues(alpha: 0.8))),
          ],
        ),
      ),
    );
  }
}

class _ExamCard extends StatelessWidget {
  final String title;
  final String sub;
  final String date;
  final Color borderColor;
  final String chipType;

  const _ExamCard({required this.title, required this.sub, required this.date, required this.borderColor, required this.chipType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(11), border: Border(left: BorderSide(color: borderColor, width: 4))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w900)),
                Text(sub, style: GoogleFonts.nunito(fontSize: 10, color: AppColors.textMuted)),
              ])),
              chipType == 'amber' ? AppChip.amber(date) : chipType == 'purple' ? AppChip.purple(date) : AppChip.green(date),
            ],
          ),
          const SizedBox(height: 9),
          Row(children: [
            _AdminBtn(label: 'Edit', isPrimary: false, onTap: () {}),
            const SizedBox(width: 6),
            _AdminBtn(label: 'Enter Marks', isPrimary: true, onTap: () {}),
          ]),
        ],
      ),
    );
  }
}

// ─── FORM HELPERS ──────────────────────────────────────────────────────────

class _FormSection extends StatelessWidget {
  final String title;
  const _FormSection(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 14, 0, 8),
      padding: const EdgeInsets.only(bottom: 5),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Text(title, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
    );
  }
}

class _AdminFormGrid extends StatelessWidget {
  final List<Widget> children;
  const _AdminFormGrid(this.children);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 3.0,
      children: children,
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final String hint;
  final bool multiline;

  const _FormField({required this.label, required this.hint, this.multiline = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
        const SizedBox(height: 4),
        Container(
          height: multiline ? 75 : 36,
          decoration: BoxDecoration(color: AppColors.background, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(9)),
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
          child: Text(hint, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textMuted)),
        ),
      ],
    );
  }
}

class _FormSelect extends StatelessWidget {
  final String label;
  final List<String> options;

  const _FormSelect({required this.label, required this.options});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
        const SizedBox(height: 4),
        Container(
          height: 36,
          decoration: BoxDecoration(color: AppColors.background, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(9)),
          padding: const EdgeInsets.symmetric(horizontal: 11),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(options.first, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.textMuted),
            ],
          ),
        ),
      ],
    );
  }
}
