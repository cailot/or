import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:orca/provider/student_provider.dart';
import 'package:orca/screen/student_admin.dart';
import 'package:orca/screen/student_list.dart';
import 'package:orca/screen/student_register.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentProvider(),
      child: MaterialApp(
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
        home: DefaultTabController(
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
              bottom: TabBar(
                controller: tabController,
                labelColor: Colors.lightBlue,
                unselectedLabelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
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
              controller: tabController,
              children: [
                StudentRegister(
                  tabController: tabController,
                ),
                StudentAdmin(),
                StudentList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
