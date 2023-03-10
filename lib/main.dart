import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:orca/screen/student_register.dart';
//import 'package:orca/service/api_service.dart';

void main() {
  //ApiService().getStudentCount();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.cyan,
        // ignore: prefer_const_constructors
        textTheme: TextTheme(
          labelLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          // ignore: prefer_const_constructors
          labelMedium: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: Colors.blueGrey,
          ),
          labelSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.blue.withOpacity(0.8),
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueGrey.shade900,
          elevation: 2,
          title: const Text(
            'James An College',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
          leading: Image.asset('images/logo.png'),
        ),
        body: const SingleChildScrollView(
          child: StudentRegister(),
        ),
      ),
    );
  }
}
