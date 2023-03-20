import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orca/model/student_model.dart';
import 'package:orca/util/jae_utils.dart';
import 'package:orca/widget/jae_button.dart';
import 'package:orca/widget/jae_datepicker.dart';
import 'package:orca/widget/jae_textarea.dart';
import 'package:orca/widget/jae_textfield.dart';
import 'package:orca/widget/jae_dropdown.dart';

import 'package:orca/service/api_service.dart';

class StudentDetails extends StatefulWidget {
  late final StudentModel model;

  // ignore: use_key_in_widget_constructors
  StudentDetails({required this.model});

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  var _formKey;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _contact1Controller = TextEditingController();
  final TextEditingController _contact2Controller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    //print(widget.model);
    _idController.text =
        (widget.model.id == null) ? '' : widget.model.id.toString();
    _firstNameController.text = (widget.model.firstName == null)
        ? ''
        : widget.model.firstName.toString();
    _lastNameController.text =
        (widget.model.lastName == null) ? '' : widget.model.lastName.toString();
    _contact1Controller.text = (widget.model.contactNo1 == null)
        ? ''
        : widget.model.contactNo1.toString();
    _contact2Controller.text = (widget.model.contactNo2 == null)
        ? ''
        : widget.model.contactNo2.toString();
    _emailController.text =
        (widget.model.email == null) ? '' : widget.model.email.toString();
    _addressController.text =
        (widget.model.address == null) ? '' : widget.model.address.toString();
    _memoController.text =
        (widget.model.memo == null) ? '' : widget.model.memo.toString();
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.model);
    //print(MediaQuery.of(context).size.height * 0.001);
    //print(MediaQuery.of(context).size.width * 0.001);

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
                  'Student Information',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
            SizedBox(
              //height: 30,
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 15,
                        top: 15,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // state
                          JaeDropdownList(
                            label: '',
                            value: (widget.model.state == null)
                                ? JaeState.values[0].name
                                : widget.model.state.toString(),
                            menus: states,
                            changed: (String? val) {
                              _rebuildStateInfo(val);
                            },
                          ),
                          SizedBox(
                            //width: 50,
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          // branch
                          JaeDropdownList(
                            label: '',
                            value: (widget.model.branch == null)
                                ? JaeBranch.values[0].name
                                : widget.model.branch.toString(),
                            menus: branches,
                            changed: (String? val) {
                              _rebuildBranchInfo(val);
                            },
                          ),
                          SizedBox(
                            // width: 50,
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          JaeTextField(
                            controller: _idController,
                            label: 'ID',
                            onSaved: (val) {
                              widget.model.id = val;
                            },
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter ID';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            // width: 50,
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  JaeButton(
                                    label: 'Update',
                                    tapped: () async {
                                      // 1. check whether ID is filled or not
                                      if (_idController.text == '') return;
                                      // 2. create new model based on the current value on the widgets
                                      _updateStudent();
                                      // show confirmation dialog
                                      _showUpdateConfirmationDialogue(context);
                                    },
                                  ),
                                  // clear button
                                  SizedBox(
                                    // width: 10,
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  JaeButton(
                                    label: 'Delete',
                                    tapped: () async {
                                      if (_idController.text == '') {
                                        _showIdWarningDialogue(context);
                                        return;
                                      }

                                      //await _searchStudentInfo(context);
                                    },
                                  ),
                                  SizedBox(
                                    // width: 10,
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  JaeButton(
                                    label: 'Clear',
                                    tapped: () {
                                      //print('before - ${widget.model}');
                                      _formKey.currentState?.reset();
                                      widget.model.enrolmentDate = null;

                                      _clearAllForm();
                                    },
                                  ),
                                  SizedBox(
                                    // width: 10,
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                ],
                              ),
                              SizedBox(
                                //height: 10,
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blue,
                                  padding: const EdgeInsets.all(
                                    5,
                                  ),
                                  elevation: 0.8,
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                  ),
                                  minimumSize: const Size(240, 50),
                                  maximumSize: const Size(240, 50),
                                ),
                                onPressed: () async {
                                  // 1. check whether ID is filled or not
                                  if (_idController.text == '') {
                                    _showIdWarningDialogue(context);
                                    return;
                                  }

                                  // datepicker update not null
                                  //widget.model.enrolmentDate = '1900-01-01';
                                  //_formKey.currentState!.save();
                                  // 2. call get API
                                  await _searchStudentInfo(context);
                                },
                                child: Text(
                                  'Search',
                                ),
                              ),
                            ],
                          ),
                          // register button
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 15,
                        top: 15,
                      ),
                      child: Row(
                        children: [
                          JaeTextField(
                            controller: _firstNameController,
                            label: 'First Name',
                            onSaved: (val) {
                              widget.model.firstName = val;
                            },
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter First Name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            // width: 30,
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          JaeTextField(
                            controller: _lastNameController,
                            label: 'Last Name',
                            onSaved: (val) {
                              widget.model.lastName = val;
                            },
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter Last Name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            // width: 30,
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          JaeDropdownList(
                            label: 'Grade',
                            value: (widget.model.grade == null)
                                ? JaeGrade.values[0].name
                                : widget.model.grade.toString(),
                            menus: grades,
                            changed: (String? val) {
                              _rebuildGradeInfo(val);
                            },
                          ),
                          SizedBox(
                            // width: 30,
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          JaeDatepicker(
                            label: 'Enrolment Date',
                            onSaved: (val) {
                              widget.model.enrolmentDate =
                                  JaeUtil.dateFormat(val);
                            },
                            validator: (val) => null,
                            selected: selectedDate =
                                (widget.model.enrolmentDate == null)
                                    ? DateFormat('yyyy-MM-dd')
                                        .parse(DateTime.now().toString())
                                    : DateFormat('yyyy-MM-dd').parse(
                                        widget.model.enrolmentDate.toString()),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 15,
                        top: 15,
                      ),
                      child: Row(
                        children: [
                          JaeTextField(
                            controller: _contact1Controller,
                            label: 'Contact No 1',
                            onSaved: (val) {
                              widget.model.contactNo1 = val;
                            },
                            validator: (val) {
                              // if(val==null || val.isEmpty){
                              //   return 'Enter First Name';
                              // }
                              return null;
                            },
                          ),
                          SizedBox(
                            // width: 30,
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          JaeTextField(
                            controller: _contact2Controller,
                            label: 'Contact No 2',
                            onSaved: (val) {
                              widget.model.contactNo2 = val;
                            },
                            validator: (val) {
                              // if(val==null || val.isEmpty){
                              //   return 'Enter First Name';
                              // }
                              return null;
                            },
                          ),
                          SizedBox(
                            // width: 30,
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          JaeTextField(
                            controller: _emailController,
                            label: 'Email',
                            onSaved: (val) {
                              widget.model.email = val;
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
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 15,
                        top: 15,
                      ),
                      child: Row(
                        children: [
                          JaeTextField(
                            controller: _addressController,
                            label: 'Address',
                            onSaved: (val) {
                              widget.model.address = val;
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
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 15,
                        top: 15,
                      ),
                      child: Row(
                        children: [
                          JaeTextArea(
                            controller: _memoController,
                            label: 'Memo',
                            onSaved: (val) {
                              widget.model.memo = val;
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

  void _rebuildGradeInfo(String? val) {
    setState(
      () {
        widget.model.grade = val;
      },
    );
  }

  Future<void> _searchStudentInfo(BuildContext context) async {
    var student = await ApiService().getStudent(int.parse(_idController.text));

    if (student == null) {
      _showSearchFailureDialogue(context, _idController.text);
      // reset StudentModel
      _clearAllForm();
      return;
    }

    _idController.text = student!.id.toString();
    _firstNameController.text = student.firstName.toString();
    _lastNameController.text = student.lastName.toString();
    _contact1Controller.text = student.contactNo1.toString();
    _contact2Controller.text = student.contactNo2.toString();
    _emailController.text = student.email.toString();
    _addressController.text = student.address.toString();
    _memoController.text = student.memo.toString();
    selectedDate =
        DateFormat('yyyy-MM-dd').parse(student.enrolmentDate.toString());

    //print('$selectedDate - ${widget.model.enrolmentDate}');

    widget.model.enrolmentDate = student.enrolmentDate;
    setState(() {
      widget.model.state = student.state;
      widget.model.branch = student.branch;
      widget.model.grade = student.grade;
    });
  }

  void _rebuildBranchInfo(String? val) {
    setState(
      () {
        widget.model.branch = val;
      },
    );
  }

  void _rebuildStateInfo(String? val) {
    setState(
      () {
        widget.model.state = val;
      },
    );
  }

  void _updateStudent() {
    widget.model.id = int.parse(_idController.text);

    widget.model.firstName =
        (_firstNameController.text == '') ? '' : _firstNameController.text;
    widget.model.lastName =
        (_lastNameController.text == '') ? '' : _lastNameController.text;

    widget.model.contactNo1 =
        (_contact1Controller.text == '') ? '' : _contact1Controller.text;
    widget.model.contactNo2 =
        (_contact2Controller.text == '') ? '' : _contact2Controller.text;

    widget.model.email =
        (_emailController.text == '') ? '' : _emailController.text;
    widget.model.address =
        (_addressController.text == '') ? '' : _addressController.text;
    widget.model.memo =
        (_memoController.text == '') ? '' : _memoController.text;
    //print('B4 - ${widget.model}');
    // call update method.
    Future<StudentModel> updated = ApiService().updateStudent(widget.model);
    //print(updated.toString());
  }

  var states = JaeState.values
      .map((e) => e.name.toString().replaceAll('_', ' '))
      .toList();

  var branches = JaeBranch.values
      .map((e) => e.name.toString().replaceAll('_', ' '))
      .toList();

  var grades = JaeGrade.values.map((e) => e.name).toList();

  var selectedDate;

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
      desc: '\nPlease fill in \'ID\' and search again\n',
      descTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      btnOkOnPress: () {},
      btnOkText: 'Ok',
      btnOkColor: Color(0xfff5b642),
    ).show();
  }

  _showSearchFailureDialogue(BuildContext context, String text) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.topSlide,
      borderSide: const BorderSide(
        color: Colors.red,
        width: 2,
      ),
      width: 500,
      dismissOnTouchOutside: false,
      showCloseIcon: true,
      desc: '\nNo record found with Student ID : $text\n',
      descTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      btnOkOnPress: () {},
      btnOkText: 'Ok',
      btnOkColor: Colors.red,
    ).show();
  }

  _showUpdateConfirmationDialogue(BuildContext context) {
    AwesomeDialog(
            context: context,
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
      widget.model.state = JaeState.values[0].name;
      widget.model.branch = JaeBranch.values[0].name;
      widget.model.grade = JaeGrade.values[0].name;
    });
  }
}
