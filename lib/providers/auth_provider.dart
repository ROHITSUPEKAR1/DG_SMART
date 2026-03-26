import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import '../services/dummy_data_service.dart';

class AuthProvider extends ChangeNotifier {
  AppUser? _currentUser;
  bool _isLoading = false;
  String? _error;

  AppUser? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _currentUser != null;
  UserRole get currentRole => _currentUser?.role ?? UserRole.student;

  Future<bool> login(String credential, String password, UserRole role) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    if (credential.isEmpty || password.isEmpty) {
      _error = 'Please enter your credentials';
      _isLoading = false;
      notifyListeners();
      return false;
    }

    final user = DummyDataService.authenticate(credential, password, role);
    if (user != null) {
      _currentUser = user;
      // Persist login
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', user.id);
      await prefs.setString('userRole', role.name);
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _error = 'Invalid credentials. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final roleStr = prefs.getString('userRole');
    if (userId != null && roleStr != null) {
      final role = UserRole.values.firstWhere(
        (r) => r.name == roleStr,
        orElse: () => UserRole.student,
      );
      _currentUser = DummyDataService.authenticate('', '', role);
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('userRole');
    notifyListeners();
  }
}
