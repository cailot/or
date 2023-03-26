import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:orca/model/student_model.dart';
import 'package:orca/screen/student_details.dart';
import 'package:orca/screen/student_list.dart';
import 'package:orca/screen/student_register.dart';

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
      home: //const StudentRegister(),
          //StudentDetails(model: StudentModel()),
          DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blueGrey.shade900,
            elevation: 20,
            automaticallyImplyLeading: false,
            titleSpacing: 5,
            title: const Text(
              'James An College',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            leading: Row(children: [
              const SizedBox(
                width: 10,
              ),
              IconButton(
                icon: Image.asset('images/logo.png'),
                onPressed: () {
                  //print('Top icon');
                },
              ),
            ]),
            bottom: const TabBar(
              labelColor: Colors.lightBlue,
              unselectedLabelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  text: 'Enrolment',
                  icon: Icon(Icons.app_registration_outlined),
                ),
                Tab(
                  text: 'Details',
                  icon: Icon(Icons.school_outlined),
                ),
                Tab(
                  text: 'List',
                  icon: Icon(Icons.list_outlined),
                ),
              ],
            ),
          ),
          //JaeTop(),
          body: TabBarView(
            children: [
              Navigator(
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) => StudentRegister(),
                  );
                },
              ),
              Navigator(
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) => StudentDetails(
                      model: StudentModel(),
                    ),
                  );
                },
              ),
              Navigator(
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) => StudentList(),
                  );
                },
              ),
              //StudentDetails(model: StudentModel()),
              //StudentDummy(),
              //StudentList(),
            ],
          ),
        ),
      ),
    );
  }
}
