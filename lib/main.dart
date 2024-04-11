import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import "package:hive_flutter/hive_flutter.dart";
import 'package:todo_flutter/pages/home_page.dart';

void main() async {
  // initializing hive -> Loval Storage
  await Hive.initFlutter();

  // open a box
  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow.shade200),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
