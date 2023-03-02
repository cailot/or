import 'package:flutter/material.dart';
import 'package:orca/model/student_model.dart';
import 'package:orca/util/jae_utils.dart';
import 'package:orca/widget/jae_button.dart';
import 'package:orca/widget/jae_datepicker.dart';
import 'package:orca/widget/jae_textarea.dart';
import 'package:orca/widget/jae_textfield.dart';
import 'package:orca/widget/jae_dropdown.dart';

class StudentRegister extends StatefulWidget {
  const StudentRegister({super.key});

  @override
  State<StudentRegister> createState() => _StudentRegisterState();
}

class _StudentRegisterState extends State<StudentRegister> {
  final _formKey = GlobalKey<FormState>();
  var model = StudentModel();

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  intialValue: stateDropdownValue,
                  menus: states,
                  changed: (String? val) {
                    setState(() {
                      stateDropdownValue = val!;
                    });
                  },
                ),
                const SizedBox(
                  width: 80,
                ),
                // branch
                JaeDropdownList(
                  label: '',
                  intialValue: branchDropdownValue,
                  menus: branches,
                  changed: (String? val) {
                    setState(() {
                      branchDropdownValue = val!;
                    });
                  },
                ),
                const SizedBox(
                  width: 80,
                ),
                // register button
                JaeButton(
                  label: 'New',
                  tapped: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                    }
                    print(model);
                  },
                ),
                const SizedBox(
                  width: 80,
                ),
                // clear button
                JaeButton(
                  label: 'Clear',
                  tapped: () {
                    //print(model);
                    _formKey.currentState?.reset();
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
                        JaeTextField(
                          label: 'Branch',
                          onSaved: (val) {
                            model.branch = val;
                          },
                          validator: (val) {
                            //   if(val==null || val.isEmpty){
                            //     return 'Enter Branch';
                            //   }
                            return null;
                          },
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        JaeTextField(
                          label: 'ID',
                          onSaved: (val) {
                            //model.id = val;
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
                        const SizedBox(
                          width: 30,
                        ),
                        JaeTextField(
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
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 15,
                      top: 15,
                    ),
                    child: Row(
                      children: [
                        //renderDatepicker(),
                        const Expanded(
                          child: JaeDatePicker(),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        JaeDropdownList(
                          label: 'Grade',
                          intialValue: gradeDropdownValue,
                          menus: grades,
                          changed: (String? val) {
                            setState(() {
                              gradeDropdownValue = val!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 30,
                        ),

                        JaeTextField(
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
                          label: 'Contact No 2',
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
                        const SizedBox(
                          width: 30,
                        ),
                        JaeTextField(
                          label: 'Email',
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 15, top: 15),
                    child: Row(
                      children: [
                        JaeTextField(
                          label: 'Address',
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
    );
  }

  String stateDropdownValue = 'Victoria';
  var states = JaeState.values.map((e) => e.name).toList();

  String branchDropdownValue = 'Braybrook';
  var branches = JaeBranch.values.map((e) => e.name).toList();

  String gradeDropdownValue = 'P1';
  var grades = JaeGrade.values.map((e) => e.name).toList();
}
