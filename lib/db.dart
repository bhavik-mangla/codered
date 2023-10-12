import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'codered_classes.dart';
import 'dart:async';

class DatabaseHelper {
  static final _databaseName = "attendance.db";
  static final _databaseVersion = 1;

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE attendance(id INTEGER PRIMARY KEY AUTOINCREMENT, subject TEXT, attendanceCount INTEGER)',
        );
      },
      version: _databaseVersion,
    );
  }

  Future<void> insertSubject(Attendance attendance) async {
    final Database db = await database;
    await db.insert(
      'attendance',
      attendance.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Attendance>> getAttendance() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('attendance');
    return List.generate(maps.length, (i) {
      return Attendance(
        id: maps[i]['id'],
        subject: maps[i]['subject'],
        attendanceCount: maps[i]['attendanceCount'],
      );
    });
  }

  Future<void> updateAttendance(List<Attendance> attendanceRecords) async {
    final Database db = await database;
    for (Attendance attendance in attendanceRecords) {
      await db.update(
        'attendance',
        attendance.toMap(),
        where: 'id = ?',
        whereArgs: [attendance.id],
      );
    }
  }

  Future<void> deleteAttendance(int id) async {
    final db = await database;
    await db.delete(
      'attendance',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
