import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:orca/model/student_model.dart';
import 'package:orca/screen/student_details.dart';
import 'package:orca/util/jae_utils.dart';
import 'package:orca/widget/jae_button.dart';
import 'package:orca/widget/jae_datepicker.dart';
import 'package:orca/widget/jae_fixed_textfield.dart';
import 'package:orca/widget/jae_textarea.dart';
import 'package:orca/widget/jae_textfield.dart';
import 'package:orca/widget/jae_dropdown.dart';

import 'package:orca/service/api_service.dart';

class StudentRegister extends StatefulWidget {
  const StudentRegister({super.key});

  @override
  State<StudentRegister> createState() => _StudentRegisterState();
}

class _StudentRegisterState extends State<StudentRegister> {
  var _formKey;
  var model;
  var _idController,
      _firstNameController,
      _lastNameController,
      _contact1Controller,
      _contact2Controller,
      _emailController,
      _addressController,
      _memoController;
  var _today; // = DateTime.now();

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    model = StudentModel();
    _idController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _contact1Controller = TextEditingController();
    _contact2Controller = TextEditingController();
    _emailController = TextEditingController();
    _addressController = TextEditingController();
    _memoController = TextEditingController();
    _today = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // color: Colors.amber.shade300,
        margin: const EdgeInsets.all(50),
        child: Column(
          children: [
            Text(
              'Student Enrolment',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
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
                    width: MediaQuery.of(context).size.width * 0.08,
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
                    width: MediaQuery.of(context).size.width * 0.08,
                  ),
                  // register button
                  JaeButton(
                    label: 'New',
                    tapped: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                      var updated = await ApiService().addStudent(model);
                      print(updated);
                      _showSuccessDialogue(context);
                      _idController.text = updated.id.toString();
                    },
                  ),
                  SizedBox(
                    // width: 80,
                    width: MediaQuery.of(context).size.width * 0.08,
                  ),
                  // clear button
                  JaeButton(
                    label: 'Clear',
                    tapped: () {
                      _formKey.currentState?.reset();
                      _resetToDefault();
                    },
                  ),
                ],
              ),
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
                        top: 30,
                        bottom: 15,
                      ),
                      child: Row(
                        children: [
                          JaeFixedTextField(
                            controller: _idController,
                            label: 'ID',
                            //initial: '',
                            onSaved: (val) {
                              val ?? model.id;
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
                            // width: 30,
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          JaeTextField(
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
                          SizedBox(
                            // width: 30,
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          JaeDropdownList(
                            label: 'Grade',
                            value: gradeDropdownValue,
                            menus: grades,
                            changed: (String? val) {
                              setState(() {
                                gradeDropdownValue = val!;
                                model.grade = gradeDropdownValue;
                              });
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
                          JaeDatepicker(
                            label: 'Enrolment Date',
                            onSaved: (val) {
                              model.enrolmentDate = JaeUtil.dateFormat(val);
                            },
                            validator: (val) => null,
                            selected: _today,
                          ),
                          SizedBox(
                            // width: 30,
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          JaeTextField(
                            controller: _contact1Controller,
                            label: 'Contact No 1',
                            onSaved: (val) {
                              model.contactNo1 = val;
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
                              model.contactNo2 = val;
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
                            // width: 30,
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          JaeTextField(
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
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 15,
                        bottom: 30,
                      ),
                      child: Row(
                        children: [
                          JaeTextArea(
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

  var states = JaeState.values
      .map((e) => e.name.toString().replaceAll('_', ' '))
      .toList();
  String stateDropdownValue = JaeState.values[0].name.toString(); //'Victoria';

  var branches = JaeBranch.values
      .map((e) => e.name.toString().replaceAll('_', ' '))
      .toList();
  String branchDropdownValue =
      JaeBranch.values[0].name.toString(); //'Braybrook';

  var grades = JaeGrade.values.map((e) => e.name).toList();
  String gradeDropdownValue = JaeGrade.values[0].name.toString(); //'P2';

  _showSuccessDialogue(BuildContext context) {
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
      desc:
          '\nStudent Registeration is done\n\nDo you want to move to student profile ?',
      descTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      btnOkOnPress: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              model.id = int.parse(_idController.text);
              return StudentDetails(
                model: model,
              );
              // return StudentDetails(
              //   model: StudentModel(),
              // );
            },
          ),
        );
      },
      btnCancelOnPress: () {},
      btnOkText: 'Go',
      btnCancelText: 'Stay',
      btnCancelColor: Colors.lightGreen,
    ).show();
  }

  _showErrorDialogue(BuildContext context) {
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
            desc: '\nStudent Registeration is failed\n',
            descTextStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red,
            btnOkOnPress: () {})
        .show();
  }

  void _resetToDefault() {
    setState(() {
      _idController.text = '';
      _firstNameController.text = '';
      _lastNameController.text = '';
      _contact1Controller.text = '';
      _contact2Controller.text = '';
      _emailController.text = '';
      _addressController.text = '';
      _memoController.text = '';
      stateDropdownValue = JaeState.values[0].name.toString();
      branchDropdownValue = JaeBranch.values[0].name.toString();
      gradeDropdownValue = JaeGrade.values[0].name.toString();
    });
  }
}
