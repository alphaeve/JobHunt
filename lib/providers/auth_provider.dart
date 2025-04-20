import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_trail/models/user.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;
  String? _error;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isLoading => _isLoading;
  String? get error => _error;
  UserRole? get userRole => _currentUser?.role;

  Future<void> loadUser() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user');
      
      if (userJson != null) {
        // In a real app, you would decode the JSON and create a User
        // For demo, we'll create a mock user
        _currentUser = User(
          id: '1',
          email: 'user@example.com',
          name: 'John Doe',
          role: prefs.getString('userRole') == 'jobSeeker' 
              ? UserRole.jobSeeker 
              : UserRole.jobProvider,
        );
      }
    } catch (e) {
      _error = 'Failed to load user data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // For demo, we'll simulate a successful login
      // In a real app, you would make an API call to authenticate
      await Future.delayed(const Duration(seconds: 1));
      
      if (email.isEmpty || password.isEmpty) {
        _error = 'Email and password are required';
        return false;
      }

      final prefs = await SharedPreferences.getInstance();
      
      // Get the user role from prefs, default to job seeker if not found
      final roleStr = prefs.getString('userRole') ?? 'jobSeeker';
      final role = roleStr == 'jobSeeker' ? UserRole.jobSeeker : UserRole.jobProvider;
      
      // Create a mock user
      _currentUser = User(
        id: '1',
        email: email,
        name: email.split('@')[0],
        role: role,
      );
      
      // Save the user to prefs
      await prefs.setString('user', 'logged_in'); // In a real app, save JSON
      
      return true;
    } catch (e) {
      _error = 'Login failed: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register(
    String name, 
    String email, 
    String password, 
    UserRole role
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // For demo, we'll simulate a successful registration
      // In a real app, you would make an API call to register
      await Future.delayed(const Duration(seconds: 1));
      
      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        _error = 'All fields are required';
        return false;
      }

      final prefs = await SharedPreferences.getInstance();
      
      // Create a mock user
      _currentUser = User(
        id: '1',
        email: email,
        name: name,
        role: role,
      );
      
      // Save the user to prefs
      await prefs.setString('user', 'logged_in'); // In a real app, save JSON
      await prefs.setString('userRole', role == UserRole.jobSeeker ? 'jobSeeker' : 'jobProvider');
      
      return true;
    } catch (e) {
      _error = 'Registration failed: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Clear user data
      _currentUser = null;
      
      // Clear prefs
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user');
      // Don't remove userRole to remember the last role for next login
    } catch (e) {
      _error = 'Logout failed: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> setUserRole(UserRole role) async {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(role: role);
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userRole', role == UserRole.jobSeeker ? 'jobSeeker' : 'jobProvider');
      
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}