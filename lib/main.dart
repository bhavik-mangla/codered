import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'home.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(
    join(await getDatabasesPath(), 'attendance.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE attendance(id INTEGER PRIMARY KEY AUTOINCREMENT, subject TEXT, attendanceCount INTEGER)',
      );
    },
    version: 1,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CODE RED',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(title: 'CODE RED'),
    );
  }
}
