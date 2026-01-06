import 'package:sqflite/sqflite.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../models/user/user_model.dart';
import '../datasources/local/database/app_database.dart';
import '../../core/constants/app_constants.dart';

class UserRepository {
  Future<Database> get _db async => await AppDatabase.database;

  // Hash password
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Create new user
  Future<UserModel?> createUser({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final db = await _db;

      // Check if email already exists
      final existing = await db.query(
        AppConstants.usersTable,
        where: 'email = ?',
        whereArgs: [email],
      );

      if (existing.isNotEmpty) {
        return null; // Email already exists
      }

      final user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        name: name,
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
      );

      await db.insert(
        AppConstants.usersTable,
        {
          ...user.toMap(),
          'password_hash': _hashPassword(password),
        },
      );

      return user;
    } catch (e) {
      print('Error creating user: $e');
      return null;
    }
  }

  // Login user
  Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final db = await _db;

      final results = await db.query(
        AppConstants.usersTable,
        where: 'email = ? AND password_hash = ?',
        whereArgs: [email, _hashPassword(password)],
      );

      if (results.isEmpty) {
        return null;
      }

      final user = UserModel.fromMap(results.first);

      // Update last login
      await db.update(
        AppConstants.usersTable,
        {'last_login_at': DateTime.now().millisecondsSinceEpoch},
        where: 'id = ?',
        whereArgs: [user.id],
      );

      return user.copyWith(lastLoginAt: DateTime.now());
    } catch (e) {
      print('Error logging in: $e');
      return null;
    }
  }

  // Get user by ID
  Future<UserModel?> getUserById(String id) async {
    try {
      final db = await _db;

      final results = await db.query(
        AppConstants.usersTable,
        where: 'id = ?',
        whereArgs: [id],
      );

      if (results.isEmpty) {
        return null;
      }

      return UserModel.fromMap(results.first);
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  // Update user
  Future<bool> updateUser(UserModel user) async {
    try {
      final db = await _db;

      await db.update(
        AppConstants.usersTable,
        user.toMap(),
        where: 'id = ?',
        whereArgs: [user.id],
      );

      return true;
    } catch (e) {
      print('Error updating user: $e');
      return false;
    }
  }

  // Update password
  Future<bool> updatePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final db = await _db;

      // Verify old password
      final results = await db.query(
        AppConstants.usersTable,
        where: 'id = ? AND password_hash = ?',
        whereArgs: [userId, _hashPassword(oldPassword)],
      );

      if (results.isEmpty) {
        return false; // Old password doesn't match
      }

      // Update password
      await db.update(
        AppConstants.usersTable,
        {'password_hash': _hashPassword(newPassword)},
        where: 'id = ?',
        whereArgs: [userId],
      );

      return true;
    } catch (e) {
      print('Error updating password: $e');
      return false;
    }
  }

  // Delete user
  Future<bool> deleteUser(String userId) async {
    try {
      final db = await _db;

      await db.delete(
        AppConstants.usersTable,
        where: 'id = ?',
        whereArgs: [userId],
      );

      return true;
    } catch (e) {
      print('Error deleting user: $e');
      return false;
    }
  }
}
