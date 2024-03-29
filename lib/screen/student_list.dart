// ignore_for_file: constant_identifier_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:orca/util/jae_utils.dart';
import 'package:orca/widget/jae_button.dart';
import 'package:orca/model/list_condition_model.dart';
import 'package:orca/widget/jae_dropdown.dart';

import 'package:orca/service/api_service.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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
  // ignore: use_function_type_syntax_for_parameters
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
                    tapped: () {
                      _downloadStudentList(context);
                    },
                  ),
                  SizedBox(
                    // width: 10,
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  JaeButton(
                    label: 'Print',
                    tapped: () {
                      _printPdf();
                    },
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
            _studentList()
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
                Text(
                  item['address'],
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
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

  Future<void> _searchStudentList(BuildContext context) async {
    List sts = await ApiService().getStudents(model);
    setState(() {
      students = sts;
    });
    if (sts.isEmpty) {
      // ignore: use_build_context_synchronously
      _showIdWarningDialogue(context);
    }
  }

  Future<void> _downloadStudentList(BuildContext context) async {
    final excel = Excel.createExcel();
    final sheet = excel[excel.getDefaultSheet() as String];

    sheet.setColAutoFit(7);
    sheet.setColAutoFit(8);
    sheet.setColAutoFit(9);
    sheet.setColAutoFit(10);

    var cellStyle = CellStyle(
      bold: true,
      fontColorHex: '#abdbe3',
      backgroundColorHex: '#154c79',
      horizontalAlign: HorizontalAlign.Center,
    );
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
        "ID";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value =
        "First Name";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value =
        "Last Name";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0)).value =
        "Grade";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0)).value =
        "State";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0)).value =
        "Branch";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0)).value =
        "Enrolment Date";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0)).value =
        "Contact No1";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0)).value =
        "Contact No2";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 0)).value =
        "Email";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 0)).value =
        "Address";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: 0)).value =
        "Start Date";

    for (int i = 0; i < 12; i++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
          .cellStyle = cellStyle;
    }

    for (int i = 0; i < students.length; i++) {
      var std = students[i];
      var id = std['id'];
      var firstName = std['firstName'];
      var lastName = std['lastName'];
      var grade = std['grade'];
      var state = std['state'];
      var branch = std['branch'];
      var enrolment = std['enrolmentDate'];
      var con1 = std['contactNo1'];
      var con2 = std['contactNo2'];
      var email = std['email'];
      var address = std['address'];
      var start = std['registerDate'];
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: (i + 1)))
          .value = id;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: (i + 1)))
          .value = firstName;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: (i + 1)))
          .value = lastName;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: (i + 1)))
          .value = grade;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: (i + 1)))
          .value = state;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: (i + 1)))
          .value = branch;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: (i + 1)))
          .value = enrolment;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: (i + 1)))
          .value = con1;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: (i + 1)))
          .value = con2;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: (i + 1)))
          .value = email;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: (i + 1)))
          .value = address;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: (i + 1)))
          .value = start;
    }

    excel.save(fileName: 'Student_List.xlsx');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Excel file downloaded successfully.'),
      ),
    );
  }

  Container _studentList() {
    return Container(
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
              child: Text(
                '\nPlease Search Student List\n',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              ),
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
    );
  }

  Future<void> _printPdf() async {
    final pdf = await _generatePdf();
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf);
  }

  Future<Uint8List> _generatePdf() async {
    //Future<void> _generatePdf() async {
    final font = await rootBundle.load("fonts/Roboto-Regular.ttf");
    final ttf = pw.Font.ttf(font);

    final pdf = pw.Document(
      version: PdfVersion.pdf_1_5,
      compress: true,
    );

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(pageFormat: PdfPageFormat.a4.landscape),
        build: (context) => [
          pw.SizedBox(
            width: double.infinity,
            child: pw.Center(
              child: pw.Text(
                'Student List',
                style: pw.TextStyle(font: ttf, fontSize: 25),
              ),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(
                width: 5,
                color: PdfColors.cyan,
              ),
            ),
            padding: const pw.EdgeInsets.all(
              10,
            ),
            child: pw.Table.fromTextArray(
              context: context,
              columnWidths: {
                0: const pw.FractionColumnWidth(0.05),
                1: const pw.FractionColumnWidth(0.1),
                2: const pw.FractionColumnWidth(0.1),
                3: const pw.FractionColumnWidth(0.05),
                4: const pw.FractionColumnWidth(0.1),
                5: const pw.FractionColumnWidth(0.1),
                6: const pw.FractionColumnWidth(0.1),
                7: const pw.FractionColumnWidth(0.1),
                8: const pw.FractionColumnWidth(0.1),
                9: const pw.FractionColumnWidth(0.1),
                10: const pw.FractionColumnWidth(0.1),
                11: const pw.FractionColumnWidth(0.1)
              },
              cellStyle: pw.TextStyle(fontSize: 8, font: ttf),
              headerStyle: pw.TextStyle(
                  fontSize: 9, font: ttf, fontWeight: pw.FontWeight.bold),
              headerDecoration: const pw.BoxDecoration(
                color: PdfColors.grey300,
              ),
              headers: [
                'Id',
                'First Name',
                'Last Name',
                'G',
                'State',
                'Branch',
                'Enrolment',
                'Contact 1',
                'Contact 2',
                'Email',
                'Address',
                'Start Date'
              ],
              data: [
                for (int i = 0; i < students.length; i++)
                  [
                    students[i]['id'],
                    students[i]['firstName'],
                    students[i]['lastName'],
                    students[i]['grade'],
                    students[i]['state'],
                    students[i]['branch'],
                    students[i]['enrolmentDate'],
                    students[i]['contactNo1'],
                    students[i]['contactNo2'],
                    students[i]['email'],
                    students[i]['address'],
                    students[i]['registerDate']
                  ]
              ],
            ),
          ),
        ],
      ),
    );

    return pdf.save();
  }
}
