import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:orca/model/student_model.dart';
import 'package:orca/screen/student_details.dart';
import 'package:orca/util/jae_utils.dart';
import 'package:orca/widget/jae_button.dart';
import 'package:orca/widget/jae_datepicker.dart';
import 'package:orca/widget/jae_fixed_textfield.dart';
import 'package:orca/widget/jae_textarea.dart';
import 'package:orca/model/list_condition_model.dart';
import 'package:orca/widget/jae_dropdown.dart';

import 'package:orca/service/api_service.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  static const String ALL = 'All';
  late List<dynamic> students = [];
  late ListConditionModel model;

  List<String> states = [];
  List<String> branches = [];
  List<String> grades = [];
  List<String> actives = [];
  List<String> years = [];

  String stateDropdownValue = '';
  String branchDropdownValue = '';
  String gradeDropdownValue = '';
  String activeDropdownValue = '';
  String yearDropdownValue = '';

  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  // Function to handle sorting
  void _sort<T>(Comparable<T> getField(Map<String, dynamic> d), int columnIndex,
      bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      students.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return ascending
            ? Comparable.compare(aValue, bValue)
            : Comparable.compare(bValue, aValue);
      });
    });
  }

  @override
  initState() {
    super.initState();

    states = JaeState.values
        .map((e) => e.name.toString().replaceAll('_', ' '))
        .toList();
    states.insert(0, ALL);
    branches = JaeBranch.values
        .map((e) => e.name.toString().replaceAll('_', ' '))
        .toList();
    branches.insert(0, ALL);
    grades = JaeGrade.values.map((e) => e.name).toList();
    grades.insert(0, ALL);
    actives = JaeActive.values.map((e) => e.name).toList();
    actives.insert(0, ALL);

    List<int> intYears = [];
    int currentYear = DateTime.now().year;
    for (int i = currentYear; i >= (currentYear - 9); i--) {
      intYears.add(i);
    }
    years = intYears.map((e) => e.toString()).toList();

    stateDropdownValue = states[0];
    branchDropdownValue = branches[0];
    gradeDropdownValue = grades[0];
    activeDropdownValue = actives[0];
    yearDropdownValue = years[0];

    model = ListConditionModel();
    model.state = stateDropdownValue;
    model.branch = branchDropdownValue;
    model.grade = gradeDropdownValue;
    model.year = yearDropdownValue;
    model.activeStudent = activeDropdownValue;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // color: Colors.amber.shade300,
        margin: const EdgeInsets.all(50),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Student List',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Form(
              key: null,
              child: Row(
                children: [
                  // state
                  JaeDropdownList(
                    label: '',
                    value: stateDropdownValue,
                    menus: states,
                    changed: (String? val) {
                      setState(() {
                        stateDropdownValue = val!;
                        model.state = stateDropdownValue;
                      });
                    },
                  ),
                  SizedBox(
                    // width: 80,
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  // branch
                  JaeDropdownList(
                    label: '',
                    value: branchDropdownValue,
                    menus: branches,
                    changed: (String? val) {
                      setState(() {
                        branchDropdownValue = val!;
                        model.branch = branchDropdownValue;
                      });
                    },
                  ),
                  SizedBox(
                    // width: 80,
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  // grade
                  JaeDropdownList(
                    label: '',
                    value: gradeDropdownValue,
                    menus: grades,
                    changed: (String? val) {
                      setState(() {
                        gradeDropdownValue = val!;
                        model.grade = gradeDropdownValue;
                      });
                    },
                  ),
                  SizedBox(
                    // width: 80,
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),

                  JaeDropdownList(
                    label: '',
                    value: yearDropdownValue,
                    menus: years,
                    changed: (String? val) {
                      setState(() {
                        yearDropdownValue = val!;
                        model.year = yearDropdownValue;
                      });
                    },
                  ),
                  SizedBox(
                    // width: 80,
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  JaeDropdownList(
                    label: '',
                    value: activeDropdownValue,
                    menus: actives,
                    changed: (String? val) {
                      setState(() {
                        activeDropdownValue = val!;
                        model.activeStudent = activeDropdownValue;
                      });
                    },
                  ),
                  SizedBox(
                    // width: 80,
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  JaeButton(
                    label: 'Search',
                    tapped: () {
                      _searchStudentList(context);
                    },
                  ),
                  SizedBox(
                    // width: 10,
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  JaeButton(
                    label: 'Download',
                    tapped: () {},
                  ),
                  SizedBox(
                    // width: 10,
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  JaeButton(
                    label: 'Print',
                    tapped: () {},
                  ),
                  SizedBox(
                    // width: 10,
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 5,
                  color: Colors.cyan.shade500,
                ),
              ),
              padding: const EdgeInsets.all(
                10,
              ),
              child: students.isEmpty
                  ? const Center(
                      //child: CircularProgressIndicator(),
                      child: Text('\nPlease Search Student List\n'),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: _dataColumnList(),
                        rows: _dataRowList(),
                        sortColumnIndex: _sortColumnIndex,
                        sortAscending: _sortAscending,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  List<DataColumn> _dataColumnList() {
    return <DataColumn>[
      const DataColumn(
        label: Text('Id'),
        tooltip: 'Student Id',
      ),
      DataColumn(
        label: const Text('First Name'),
        onSort: (columnIndex, ascending) {
          _sort<String>((d) => d['firstName'], columnIndex, ascending);
        },
        tooltip: 'First Name',
      ),
      DataColumn(
        label: const Text('Last Name'),
        onSort: (columnIndex, ascending) {
          _sort<String>((d) => d['lastName'], columnIndex, ascending);
        },
        tooltip: 'Last Name',
      ),
      DataColumn(
        label: const Text('Grade'),
        onSort: (columnIndex, ascending) {
          _sort<String>((d) => d['grade'], columnIndex, ascending);
        },
        tooltip: 'Grade',
      ),
      const DataColumn(
        label: Text('State'),
      ),
      const DataColumn(
        label: Text('Branch'),
      ),
      const DataColumn(
        label: Text('Enrolment Date'),
      ),
      const DataColumn(
        label: Text('Contact No 1'),
      ),
      const DataColumn(
        label: Text('Contact No 2'),
      ),
      const DataColumn(
        label: Text('Email'),
      ),
      const DataColumn(
        label: Text('Address'),
      ),
      const DataColumn(
        label: Text('Start Date'),
      )
    ];
  }

  List<DataRow> _dataRowList() {
    return students
        .map(
          (item) => DataRow(
            cells: <DataCell>[
              DataCell(
                Text(item['id'].toString()),
              ),
              DataCell(
                Text(item['firstName']),
              ),
              DataCell(
                Text(item['lastName']),
              ),
              DataCell(
                Text(item['grade']),
              ),
              DataCell(
                Text(item['state']),
              ),
              DataCell(
                Text(item['branch']),
              ),
              DataCell(
                Text(item['enrolmentDate']),
              ),
              DataCell(
                Text(item['contactNo1']),
              ),
              DataCell(
                Text(item['contactNo2']),
              ),
              DataCell(
                Text(item['email']),
              ),
              DataCell(
                Flexible(
                  child: Text(
                    item['address'],
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
              ),
              DataCell(
                Text(item['registerDate']),
              ),
            ],
          ),
        )
        .toList();
  }

  Future<void> _searchStudentList(BuildContext context) async {
    print(model);
    // ApiService().getStudents(model).then((value) {
    //   setState(() {
    //     students = value;
    //   });
    // });

    List sts = await ApiService().getStudents(model);
    setState(() {
      students = sts;
    });
    if (sts.isEmpty) {
      _showIdWarningDialogue(context);
    }
  }

  _showIdWarningDialogue(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.topSlide,
      borderSide: const BorderSide(
        color: Colors.yellow,
        width: 2,
      ),
      width: 500,
      dismissOnTouchOutside: false,
      showCloseIcon: true,
      desc: '\nNo data found in the system\n',
      descTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      btnOkOnPress: () {},
      btnOkText: 'Ok',
      btnOkColor: const Color(0xfff5b642),
    ).show();
  }
}
