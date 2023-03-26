// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:orca/model/student_model.dart';
import 'package:orca/provider/student_provider.dart';
import 'package:orca/util/jae_utils.dart';
import 'package:orca/widget/jae_button.dart';
import 'package:orca/widget/jae_datepicker.dart';
import 'package:orca/widget/jae_fixed_textfield.dart';
import 'package:orca/widget/jae_textarea.dart';
import 'package:orca/widget/jae_textfield.dart';
import 'package:orca/widget/jae_dropdown.dart';

import 'package:orca/service/api_service.dart';
import 'package:provider/provider.dart';

class StudentRegister extends StatefulWidget {
  TabController tabController;
  StudentRegister({required this.tabController});

  @override
  State<StudentRegister> createState() => _StudentRegisterState();
}

class _StudentRegisterState extends State<StudentRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  StudentModel model = StudentModel();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _contact1Controller = TextEditingController();
  final TextEditingController _contact2Controller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();
  final DateTime _today = DateTime.now();

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

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StudentProvider>(context);
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
                      //print(updated);
                      _showSuccessDialogue(provider);
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

  _showSuccessDialogue(StudentProvider provider) {
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
      desc:
          '\nStudent Registeration is done\n\nDo you want to move to student profile ?',
      descTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      btnOkOnPress: () {
        provider.studentId = int.parse(_idController.text);
        widget.tabController.animateTo(1);
      },
      btnCancelOnPress: () {},
      btnOkText: 'Go',
      btnCancelText: 'Stay',
      btnCancelColor: Colors.lightGreen,
    ).show();
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
