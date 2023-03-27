import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:orca/model/student_model.dart';
import 'package:orca/provider/student_provider.dart';
import 'package:orca/util/jae_utils.dart';
import 'package:orca/widget/jae_button.dart';
import 'package:orca/widget/jae_datepicker.dart';
import 'package:orca/widget/jae_datepicker_small.dart';
import 'package:orca/widget/jae_dropdown_small.dart';
import 'package:orca/widget/jae_textarea.dart';
import 'package:orca/widget/jae_textarea_small.dart';
import 'package:orca/widget/jae_textfield.dart';
import 'package:orca/widget/jae_dropdown.dart';

import 'package:orca/service/api_service.dart';
import 'package:orca/widget/jae_textfield_small.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

import '../widget/jae_small_button.dart';

class StudentAdmin extends StatefulWidget {
  @override
  State<StudentAdmin> createState() => _StudentAdminState();
}

class _StudentAdminState extends State<StudentAdmin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _contact1Controller = TextEditingController();
  final TextEditingController _contact2Controller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  StudentModel model = StudentModel();

  late List<dynamic> students = [];

  var states = JaeState.values
      .map((e) => e.name.toString().replaceAll('_', ' '))
      .toList();

  var branches = JaeBranch.values
      .map((e) => e.name.toString().replaceAll('_', ' '))
      .toList();

  var grades = JaeGrade.values.map((e) => e.name).toList();

  var selectedDate;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StudentProvider>(context);
    int id = provider.studentId;
    if (id != 0) {
      provider.studentId = 0;
    }
    if (kDebugMode) {
      // print('@Detail - Id : $id , StudentModel - $model');
    }
    return (id == 0)
        ? layoutManager()
        : FutureBuilder<void>(
            future: _passedStudentInfo(id),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('Error occured : ${snapshot.error}');
                } else {
                  return layoutManager();
                  //return studentDetail();
                }
              } else {
                // still fetching Student data...
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
  }

  Widget layoutManager() {
    return StaggeredGrid.count(
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: studentDetail(),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 2,
          child: Container(color: Colors.red),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 3,
          child: Container(color: Colors.green),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 5,
          child: Container(color: Colors.yellow),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Container(color: Colors.blue),
        ),
      ],
    );
  }

  void _rebuildGradeInfo(String? val) {
    setState(
      () {
        model.grade = val;
      },
    );
  }

  void _rebuildBranchInfo(String? val) {
    setState(
      () {
        model.branch = val;
      },
    );
  }

  void _rebuildStateInfo(String? val) {
    setState(
      () {
        model.state = val;
      },
    );
  }

  Future<void> _searchStudent(String keyword) async {
    // retrieve the result set from the API call
    List result = await ApiService().searchStudent(keyword);
    // show no match dialog and exit
    if (result.isEmpty) {
      // ignore: use_build_context_synchronously
      _showSearchFailureDialogue(keyword);
      return;
    }
    students = result;
    // display the result set in a modal dialog
    _searchController.text = '';
    AwesomeDialog(
      context: _formKey.currentContext!,
      dialogType: DialogType.noHeader,
      animType: AnimType.bottomSlide,
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: _dataColumnList(),
          rows: _dataRowList(),
        ),
      ),
    ).show();
  }

  List<DataColumn> _dataColumnList() {
    return <DataColumn>[
      const DataColumn(
        label: Text(
          'Id',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xff2E86C1),
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'First Name',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xff2E86C1),
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'Last Name',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xff2E86C1),
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'Grade',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xff2E86C1),
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'State',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xff2E86C1),
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'Branch',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xff2E86C1),
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'Enrolment Date',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xff2E86C1),
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'Contact No 1',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xff2E86C1),
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'Contact No 2',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xff2E86C1),
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'Email',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xff2E86C1),
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'Address',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xff2E86C1),
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'Start Date',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xff2E86C1),
          ),
        ),
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
                onTap: () {
                  _fillSearchedStudent(StudentModel.fromJson(item));
                  Navigator.of(context).pop();
                },
              ),
              DataCell(
                Text(item['firstName']),
                onTap: () {
                  _fillSearchedStudent(StudentModel.fromJson(item));
                  Navigator.of(context).pop();
                },
              ),
              DataCell(
                Text(item['lastName']),
                onTap: () {
                  _fillSearchedStudent(StudentModel.fromJson(item));
                  Navigator.of(context).pop();
                },
              ),
              DataCell(
                Text(item['grade']),
                onTap: () {
                  _fillSearchedStudent(StudentModel.fromJson(item));
                  Navigator.of(context).pop();
                },
              ),
              DataCell(
                Text(item['state']),
                onTap: () {
                  _fillSearchedStudent(StudentModel.fromJson(item));
                  Navigator.of(context).pop();
                },
              ),
              DataCell(
                Text(item['branch']),
                onTap: () {
                  _fillSearchedStudent(StudentModel.fromJson(item));
                  Navigator.of(context).pop();
                },
              ),
              DataCell(
                Text(item['enrolmentDate']),
                onTap: () {
                  _fillSearchedStudent(StudentModel.fromJson(item));
                  Navigator.of(context).pop();
                },
              ),
              DataCell(
                Text(item['contactNo1']),
                onTap: () {
                  _fillSearchedStudent(StudentModel.fromJson(item));
                  Navigator.of(context).pop();
                },
              ),
              DataCell(
                Text(item['contactNo2']),
                onTap: () {
                  _fillSearchedStudent(StudentModel.fromJson(item));
                  Navigator.of(context).pop();
                },
              ),
              DataCell(
                Text(item['email']),
                onTap: () {
                  _fillSearchedStudent(StudentModel.fromJson(item));
                  Navigator.of(context).pop();
                },
              ),
              DataCell(
                Text(
                  item['address'],
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
                onTap: () {
                  _fillSearchedStudent(StudentModel.fromJson(item));
                  Navigator.of(context).pop();
                },
              ),
              DataCell(
                Text(item['registerDate']),
                onTap: () {
                  _fillSearchedStudent(StudentModel.fromJson(item));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        )
        .toList();
  }

  void _updateStudent() {
    model.id = int.parse(_idController.text);
    model.firstName =
        (_firstNameController.text == '') ? '' : _firstNameController.text;
    model.lastName =
        (_lastNameController.text == '') ? '' : _lastNameController.text;

    model.contactNo1 =
        (_contact1Controller.text == '') ? '' : _contact1Controller.text;
    model.contactNo2 =
        (_contact2Controller.text == '') ? '' : _contact2Controller.text;

    model.email = (_emailController.text == '') ? '' : _emailController.text;
    model.address =
        (_addressController.text == '') ? '' : _addressController.text;
    model.memo = (_memoController.text == '') ? '' : _memoController.text;
    Future<StudentModel> updated = ApiService().updateStudent(model);
  }

  void _dischargeStudent(int id) {
    ApiService().dischargeStudent(id);
  }

  _showIdWarningDialogue() {
    AwesomeDialog(
      context: _formKey.currentContext!,
      dialogType: DialogType.warning,
      animType: AnimType.topSlide,
      borderSide: const BorderSide(
        color: Colors.yellow,
        width: 2,
      ),
      width: 500,
      dismissOnTouchOutside: false,
      showCloseIcon: true,
      desc: '\nPlease fill in keyword and search again\n',
      descTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      btnOkOnPress: () {},
      btnOkText: 'Ok',
      btnOkColor: const Color(0xfff5b642),
    ).show();
  }

  _showSearchFailureDialogue(String text) {
    AwesomeDialog(
      context: _formKey.currentContext!,
      dialogType: DialogType.error,
      animType: AnimType.topSlide,
      borderSide: const BorderSide(
        color: Colors.red,
        width: 2,
      ),
      width: 500,
      dismissOnTouchOutside: false,
      showCloseIcon: true,
      desc: '\nNo Student record found with \'$text\'\n',
      descTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      btnOkOnPress: () {},
      btnOkText: 'Ok',
      btnOkColor: Colors.red,
    ).show();
  }

  _showUpdateConfirmationDialogue() {
    AwesomeDialog(
            context: _formKey.currentContext!,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            borderSide: const BorderSide(
              color: Colors.green,
              width: 2,
            ),
            width: 500,
            dismissOnTouchOutside: false,
            showCloseIcon: true,
            desc: '\nStudent Update is done\n',
            descTextStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            // btnOkIcon: Icons.info_outline_rounded,
            btnOkColor: Colors.lightGreen,
            btnOkOnPress: () {})
        .show();
  }

  _showDischargeDialogue(int id) {
    AwesomeDialog(
      context: _formKey.currentContext!,
      dialogType: DialogType.error,
      animType: AnimType.topSlide,
      borderSide: const BorderSide(
        color: Colors.red,
        width: 2,
      ),
      width: 500,
      dismissOnTouchOutside: false,
      showCloseIcon: true,
      desc:
          '\nStudent ID $id will be discharged in the system.\n\nDo you want to process ?',
      descTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      btnOkOnPress: () {
        _dischargeStudent(id);
        _clearAllForm();
      },
      btnCancelOnPress: () {},
      btnOkText: 'Go',
      btnCancelText: 'Cancel',
      btnOkColor: Colors.red,
      btnCancelColor: const Color(0xffF2927E),
    ).show();
  }

  _clearAllForm() {
    setState(() {
      _idController.text = '';
      _firstNameController.text = '';
      _lastNameController.text = '';
      _contact1Controller.text = '';
      _contact2Controller.text = '';
      _emailController.text = '';
      _addressController.text = '';
      _memoController.text = '';
      model.state = JaeState.values[0].name;
      model.branch = JaeBranch.values[0].name;
      model.grade = JaeGrade.values[0].name;
    });
  }

  _passedStudentInfo(int id) async {
    model = (await ApiService().getStudent(id))!;
    _idController.text = model.id.toString();
    _firstNameController.text = model.firstName.toString();
    _lastNameController.text = model.lastName.toString();
    _contact1Controller.text = model.contactNo1.toString();
    _contact2Controller.text = model.contactNo2.toString();
    _emailController.text = model.email.toString();
    _addressController.text = model.address.toString();
    _memoController.text = model.memo.toString();
    selectedDate =
        DateFormat('yyyy-MM-dd').parse(model.enrolmentDate.toString());
    //await Future.delayed(Duration(seconds: 12));
  }

  _fillSearchedStudent(StudentModel row) {
    model = row;
    _idController.text = model.id.toString();
    _firstNameController.text = model.firstName.toString();
    _lastNameController.text = model.lastName.toString();
    _contact1Controller.text = model.contactNo1.toString();
    _contact2Controller.text = model.contactNo2.toString();
    _emailController.text = model.email.toString();
    _addressController.text = model.address.toString();
    _memoController.text = model.memo.toString();
    selectedDate =
        DateFormat('yyyy-MM-dd').parse(model.enrolmentDate.toString());
    setState(() {});
  }

  Widget studentDetail() {
    return SingleChildScrollView(
      child: Container(
        // color: Colors.amber.shade300,
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Student Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              //height: 30,
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Colors.cyan.shade500,
                ),
              ),
              padding: const EdgeInsets.all(
                10,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 2,
                        right: 2,
                        bottom: 2,
                        top: 2,
                      ),
                      child: Row(
                        // First Row
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 30,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Color(0xffFCF3CF),
                                  //hintText: 'Your Keyword',
                                ),
                                controller: _searchController,
                              ),
                            ),
                          ),
                          SizedBox(
                            // width: 10,
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          // Search Button
                          JaeSmallButton(
                            label: 'Search',
                            tapped: () async {
                              // 1. check whether ID is filled or not
                              if (_searchController.text == '') {
                                _showIdWarningDialogue();
                                return;
                              }
                              // 2. search Students
                              await _searchStudent(_searchController.text);
                            },
                          ),
                          SizedBox(
                            // width: 10,
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          // Update Button
                          JaeSmallButton(
                            label: 'Update',
                            tapped: () async {
                              // 1. check whether ID is filled or not
                              if (_idController.text == '') return;
                              // 2. create new model based on the current value on the widgets
                              _updateStudent();
                              // show confirmation dialog
                              _showUpdateConfirmationDialogue();
                            },
                          ),
                          // clear button
                          SizedBox(
                            // width: 10,
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          // Delete Button
                          JaeSmallButton(
                            label: 'Delete',
                            tapped: () async {
                              if (_idController.text == '') {
                                _showIdWarningDialogue();
                                return;
                              }
                              _showDischargeDialogue(
                                  int.parse(_idController.text));
                            },
                          ),
                          SizedBox(
                            // width: 10,
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          // Clear Button
                          JaeSmallButton(
                            label: 'Clear',
                            tapped: () {
                              _formKey.currentState?.reset();
                              model.enrolmentDate = null;

                              _clearAllForm();
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 2,
                        right: 2,
                        bottom: 2,
                        top: 2,
                      ),
                      child: Row(
                        // Second Row
                        children: [
                          // State
                          JaeSmallDropdownList(
                            value: (model.state == null)
                                ? JaeState.values[0].name
                                : model.state.toString(),
                            menus: states,
                            changed: (String? val) {
                              _rebuildStateInfo(val);
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          // Branch
                          JaeSmallDropdownList(
                            value: (model.branch == null)
                                ? JaeBranch.values[0].name
                                : model.branch.toString(),
                            menus: branches,
                            changed: (String? val) {
                              _rebuildBranchInfo(val);
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          // Grade
                          JaeSmallDropdownList(
                            //label: 'Grade',
                            value: (model.grade == null)
                                ? JaeGrade.values[0].name
                                : model.grade.toString(),
                            menus: grades,
                            changed: (String? val) {
                              _rebuildGradeInfo(val);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 2,
                        right: 2,
                        bottom: 2,
                        top: 2,
                      ),
                      child: Row(
                        // Third Row
                        children: [
                          // ID
                          Expanded(
                            child: SizedBox(
                              height: 35,
                              child: TextFormField(
                                readOnly: true,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: const InputDecoration(
                                  hintText: 'ID',
                                  hintStyle: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                onSaved: (val) {
                                  model.id = int.parse(val!);
                                },
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Enter ID';
                                  }
                                  return null;
                                },
                                controller: _idController,
                              ),
                            ),
                          ),

                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          // First Name
                          JaeSmallTextField(
                            controller: _firstNameController,
                            label: 'First Name',
                            onSaved: (val) {
                              model.firstName = val;
                            },
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter First Name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          // Last Name
                          JaeSmallTextField(
                            controller: _lastNameController,
                            label: 'Last Name',
                            onSaved: (val) {
                              model.lastName = val;
                            },
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter Last Name';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    /*
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 2,
                        right: 2,
                        bottom: 2,
                        top: 2,
                      ),
                      child: Row(
                        // Forth Row
                        children: [
                          // Grade
                          JaeSmallDropdownList(
                            //label: 'Grade',
                            value: (model.grade == null)
                                ? JaeGrade.values[0].name
                                : model.grade.toString(),
                            menus: grades,
                            changed: (String? val) {
                              _rebuildGradeInfo(val);
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          // Enrolment Date
                          JaeSmallDatepicker(
                            label: 'Enrolment Date',
                            onSaved: (val) {
                              model.enrolmentDate = JaeUtil.dateFormat(val);
                            },
                            validator: (val) => null,
                            selected: selectedDate =
                                (model.enrolmentDate == null)
                                    ? DateFormat('yyyy-MM-dd')
                                        .parse(DateTime.now().toString())
                                    : DateFormat('yyyy-MM-dd')
                                        .parse(model.enrolmentDate.toString()),
                          ),
                        ],
                      ),
                    ),
                    */
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 2,
                        right: 2,
                        bottom: 2,
                        top: 2,
                      ),
                      child: Row(
                        // Forth Row
                        children: [
                          // Email
                          JaeSmallTextField(
                            controller: _emailController,
                            label: 'Email',
                            onSaved: (val) {
                              model.email = val;
                            },
                            validator: (val) {
                              // if(val==null || val.isEmpty){
                              //   return 'Enter First Name';
                              // }
                              return null;
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          // Address
                          JaeSmallTextField(
                            controller: _addressController,
                            label: 'Address',
                            onSaved: (val) {
                              model.address = val;
                            },
                            validator: (val) {
                              // if(val==null || val.isEmpty){
                              //   return 'Enter First Name';
                              // }
                              return null;
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 2,
                        right: 2,
                        bottom: 2,
                        top: 2,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        // Fifth Row
                        children: [
                          // Enrolment Date
                          JaeSmallDatepicker(
                            label: 'Enrolement Date',
                            onSaved: (val) {
                              model.enrolmentDate = JaeUtil.dateFormat(val);
                            },
                            validator: (val) => null,
                            selected: selectedDate =
                                (model.enrolmentDate == null)
                                    ? DateFormat('yyyy-MM-dd')
                                        .parse(DateTime.now().toString())
                                    : DateFormat('yyyy-MM-dd')
                                        .parse(model.enrolmentDate.toString()),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          // Contact No 1
                          JaeSmallTextField(
                            controller: _contact1Controller,
                            label: 'Contact No 1',
                            onSaved: (val) {
                              model.contactNo1 = val;
                            },
                            validator: (val) {
                              return null;
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          // Contact No 2
                          JaeSmallTextField(
                            controller: _contact2Controller,
                            label: 'Contact No 2',
                            onSaved: (val) {
                              model.contactNo2 = val;
                            },
                            validator: (val) {
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 2,
                        right: 2,
                        bottom: 2,
                        top: 2,
                      ),
                      child: Row(
                        // Sixth Row
                        children: [
                          // Memo
                          JaeSmallTextArea(
                            controller: _memoController,
                            label: 'Memo',
                            onSaved: (val) {
                              model.memo = val;
                            },
                            validator: (val) {
                              // if(val==null || val.isEmpty){
                              //   return 'Enter First Name';
                              // }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
