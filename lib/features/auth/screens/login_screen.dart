import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../models/app_models.dart';
import '../../../providers/auth_provider.dart';
import '../../student/screens/student_home.dart';
import '../../teacher/screens/teacher_home.dart';
import '../../parent/screens/parent_home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _selectedRole = 0; // 0=Student, 1=Parent, 2=Teacher
  final _credController = TextEditingController();
  final _passController = TextEditingController();

  final roles = [
    {'label': 'Student', 'role': UserRole.student},
    {'label': 'Parent', 'role': UserRole.parent},
    {'label': 'Teacher', 'role': UserRole.teacher},
  ];

  UserRole get _currentRole => roles[_selectedRole]['role'] as UserRole;

  List<Color> get _gradientColors {
    if (_selectedRole == 2) {
      return const [Color(0xFF667eea), Color(0xFF764ba2), Color(0xFFf093fb), Color(0xFFf5a623)];
    } else if (_selectedRole == 1) {
      return const [Color(0xFFf093fb), Color(0xFFf5a623), Color(0xFFf06292), Color(0xFFe91e8c)];
    }
    return const [Color(0xFF5BC8F5), Color(0xFF87D4F8), Color(0xFFB0E4FA), Color(0xFFC8EDD6), Color(0xFFF5E8B0)];
  }

  Color get _accentColor {
    if (_selectedRole == 2) return const Color(0xFF764ba2);
    if (_selectedRole == 1) return const Color(0xFFe91e63);
    return AppColors.primary;
  }

  List<Color> get _buttonColors {
    if (_selectedRole == 2) return const [Color(0xFF667eea), Color(0xFF764ba2)];
    if (_selectedRole == 1) return const [Color(0xFFf06292), Color(0xFFe91e63)];
    return const [Color(0xFF3b9ef5), Color(0xFF2b7de8)];
  }

  String get _headerTitle {
    if (_selectedRole == 2) return 'Welcome, Teacher!';
    if (_selectedRole == 1) return 'Hello, Parent!';
    return 'Welcome back, dreamer!';
  }

  String get _headerSub {
    if (_selectedRole == 2) return 'Empowering classrooms, inspiring futures.';
    if (_selectedRole == 1) return "Stay connected with your child's journey.";
    return 'Your learning journey starts here.';
  }

  String get _credHint {
    if (_selectedRole == 2) return 'Employee ID / Email';
    if (_selectedRole == 1) return 'Registered Mobile Number';
    return 'Email / Mobile Number';
  }

  String get _credIcon {
    if (_selectedRole == 1) return '📱';
    return '👤';
  }

  List<Map<String, dynamic>> get _floatingIcons {
    if (_selectedRole == 2) {
      return [
        {'icon': '📚', 'top': 40.0, 'left': 15.0},
        {'icon': '✏️', 'top': 35.0, 'right': 16.0},
        {'icon': '🎓', 'top': 35.0, 'right': 55.0},
        {'icon': '📒', 'top': 100.0, 'left': 10.0},
        {'icon': '🏫', 'top': 92.0, 'right': 10.0},
        {'icon': '📐', 'top': 175.0, 'left': 8.0},
        {'icon': '🔬', 'top': 165.0, 'right': 10.0},
      ];
    } else if (_selectedRole == 1) {
      return [
        {'icon': '🌸', 'top': 40.0, 'left': 15.0},
        {'icon': '💝', 'top': 35.0, 'right': 16.0},
        {'icon': '👨‍👩‍👧', 'top': 35.0, 'right': 60.0},
        {'icon': '📚', 'top': 100.0, 'left': 10.0},
        {'icon': '🎓', 'top': 92.0, 'right': 10.0},
        {'icon': '⭐', 'top': 175.0, 'left': 8.0},
        {'icon': '💖', 'top': 165.0, 'right': 10.0},
      ];
    }
    return [
      {'icon': '📚', 'top': 40.0, 'left': 15.0},
      {'icon': '💡', 'top': 35.0, 'right': 16.0},
      {'icon': '🎓', 'top': 35.0, 'right': 55.0},
      {'icon': '✏️', 'top': 100.0, 'left': 10.0},
      {'icon': '🔭', 'top': 92.0, 'right': 10.0},
      {'icon': '📒', 'top': 210.0, 'left': 8.0},
      {'icon': '🌍', 'top': 210.0, 'right': 10.0},
    ];
  }

  Future<void> _login() async {
    final auth = context.read<AuthProvider>();
    final success = await auth.login(
      _credController.text.isEmpty ? 'demo' : _credController.text,
      _passController.text.isEmpty ? 'demo' : _passController.text,
      _currentRole,
    );

    if (success && mounted) {
      Widget dest;
      switch (_currentRole) {
        case UserRole.teacher:
          dest = const TeacherHomeScreen();
          break;
        case UserRole.parent:
          dest = const ParentHomeScreen();
          break;
        default:
          dest = const StudentHomeScreen();
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => dest));
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: _gradientColors,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Floating icons
              ..._floatingIcons.map((item) => Positioned(
                top: item['top'] as double?,
                left: item['left'] as double?,
                right: item['right'] as double?,
                child: Opacity(
                  opacity: 0.65,
                  child: Text(item['icon'] as String, style: const TextStyle(fontSize: 18)),
                ),
              )),
              // Content - pinned to bottom
              Positioned(
                left: 0, right: 0, bottom: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.86),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(_headerTitle, textAlign: TextAlign.center, style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.textPrimary, height: 1.25)),
                      const SizedBox(height: 5),
                      Text(_headerSub, textAlign: TextAlign.center, style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF6677aa)), maxLines: 2),
                      const SizedBox(height: 16),
                      // Role Tabs
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCE6FA).withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Row(
                          children: List.generate(3, (i) {
                            final isActive = i == _selectedRole;
                            return Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _selectedRole = i),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(vertical: 7),
                                  decoration: BoxDecoration(
                                    color: isActive ? Colors.white : Colors.transparent,
                                    borderRadius: BorderRadius.circular(99),
                                    boxShadow: isActive ? [BoxShadow(color: _accentColor.withValues(alpha: 0.13), blurRadius: 8, offset: const Offset(0, 2))] : null,
                                  ),
                                  child: Text(
                                    roles[i]['label'] as String,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: isActive ? _accentColor : const Color(0xFF8899bb),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 14),
                      // Inputs
                      PillInputField(hint: _credHint, icon: _credIcon, controller: _credController),
                      PillInputField(hint: 'Password', icon: '🔒', isPassword: true, controller: _passController),
                      const SizedBox(height: 2),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text('Forgot Password?', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: _accentColor)),
                      ),
                      const SizedBox(height: 8),
                      // Login button
                      GradientButton(
                        label: 'LOGIN',
                        onTap: _login,
                        colors: _buttonColors,
                        isLoading: auth.isLoading,
                      ),
                      if (auth.error != null) ...[
                        const SizedBox(height: 8),
                        Text(auth.error!, textAlign: TextAlign.center, style: GoogleFonts.nunito(fontSize: 11, color: AppColors.error, fontWeight: FontWeight.w700)),
                      ],
                      const SizedBox(height: 10),
                      Text("Don't have an account? Register", textAlign: TextAlign.center, style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF5a5a7a))),
                      const SizedBox(height: 6),
                      Text('Login with OTP', textAlign: TextAlign.center, style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF5a5a7a))),
                      const SizedBox(height: 8),
                      Text.rich(
                        TextSpan(children: [
                          TextSpan(text: 'By continuing, you agree to ', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w600, color: const Color(0xFF9aabcc))),
                          TextSpan(text: 'Terms & Conditions', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w600, color: _accentColor)),
                        ]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _credController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
