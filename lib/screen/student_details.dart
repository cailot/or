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
    _idController.text = widget.model.id.toString();
    _firstNameController.text = widget.model.firstName.toString();
    _lastNameController.text = widget.model.lastName.toString();
    _contact1Controller.text = widget.model.contactNo1.toString();
    _contact2Controller.text = widget.model.contactNo2.toString();
    _emailController.text = widget.model.email.toString();
    _addressController.text = widget.model.address.toString();
    _memoController.text = widget.model.memo.toString();
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.model);
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.amber.shade300,
          margin: const EdgeInsets.all(50),
          child: Column(
            children: [
              Text(
                'Student Details',
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
                      intialValue: widget.model.state.toString(),
                      menus: states,
                      changed: (String? val) {
                        setState(
                          () {
                            widget.model.state = val;
                          },
                        );
                      },
                    ),

                    const SizedBox(
                      width: 80,
                    ),
                    // branch
                    JaeDropdownList(
                      label: '',
                      intialValue: widget.model.branch.toString(),
                      menus: branches,
                      changed: (String? val) {
                        setState(
                          () {
                            widget.model.branch = val;
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      width: 80,
                    ),

                    // register button
                    JaeButton(
                      label: 'Update',
                      tapped: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                        //print(model);
                        Future<StudentModel> updated =
                            ApiService().addStudent(widget.model);
                        //model = await updated;
                        _showSuccessDialogue(context);
                        //_idController.text = widget.model.id.toString();
                      },
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    // clear button
                    JaeButton(
                      label: 'Clear',
                      tapped: () {
                        //print('before - ${widget.model}');
                        _formKey.currentState?.reset();
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
                      },
                    ),
                  ],
                ),
              ),
              Container(
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
                            const SizedBox(
                              width: 30,
                            ),
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
                            const SizedBox(
                              width: 30,
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
                            const SizedBox(
                              width: 30,
                            ),
                            JaeDropdownList(
                              label: 'Grade',
                              intialValue: widget.model.grade.toString(),
                              menus: grades,
                              changed: (String? val) {
                                setState(
                                  () {
                                    widget.model.grade = val;
                                  },
                                );
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
                                widget.model.enrolmentDate =
                                    JaeUtil.dateFormat(val);
                              },
                              validator: (val) => null,
                              selected: (widget.model.enrolmentDate == null)
                                  ? DateFormat('yyyy-MM-dd')
                                      .parse(DateTime.now().toString())
                                  : DateFormat('yyyy-MM-dd').parse(
                                      widget.model.enrolmentDate.toString()),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
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
                            const SizedBox(
                              width: 30,
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
                                widget.model.email = val;
                              },
                              validator: (val) {
                                // if(val==null || val.isEmpty){
                                //   return 'Enter First Name';
                                // }
                                return null;
                              },
                            ),
                            const SizedBox(
                              width: 30,
                            ),
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
                          top: 15,
                          bottom: 30,
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
      ),
    );
  }

  var states = JaeState.values
      .map((e) => e.name.toString().replaceAll('_', ' '))
      .toList();

  var branches = JaeBranch.values
      .map((e) => e.name.toString().replaceAll('_', ' '))
      .toList();

  var grades = JaeGrade.values.map((e) => e.name).toList();

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
      btnOkOnPress: () {},
      btnCancelOnPress: () {},
      btnOkText: 'Go',
      btnCancelText: 'Stay',
      btnCancelColor: Colors.lightGreen,
    ).show();
  }
}
