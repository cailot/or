import 'package:flutter/material.dart';
import 'package:orca/util/jae_utils.dart';
import 'package:orca/widget/jae_datepicker.dart';

class StudentRegister extends StatefulWidget {
  const StudentRegister({super.key});

  @override
  State<StudentRegister> createState() => _StudentRegisterState();
}

class _StudentRegisterState extends State<StudentRegister> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber.shade300,
      margin: EdgeInsets.all(50),
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
                renderDropdownList(
                    label: '',
                    intialValue: stateDropdownValue,
                    menus: states,
                    changed: (String? val) {
                      setState(() {
                        stateDropdownValue = val!;
                      });
                    }),
                const SizedBox(
                  width: 80,
                ),
                // branch
                renderDropdownList(
                    label: '',
                    intialValue: branchDropdownValue,
                    menus: branches,
                    changed: (String? val) {
                      setState(() {
                        branchDropdownValue = val!;
                      });
                    }),
                const SizedBox(
                  width: 80,
                ),

                // register button
                renderButton(label: 'New', tapped: () {}),
                const SizedBox(
                  width: 80,
                ),

                // save button
                renderButton(label: 'Save', tapped: () {}),
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
              key: formKey,
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
                        renderTextFormField(
                          label: 'Branch',
                          onSaved: (val) {},
                          validator: (val) {
                            return null;
                          },
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        renderTextFormField(
                          label: 'ID',
                          onSaved: (val) {},
                          validator: (val) {
                            return null;
                          },
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        renderTextFormField(
                          label: 'First Name',
                          onSaved: (val) {},
                          validator: (val) {
                            return null;
                          },
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        renderTextFormField(
                          label: 'Last Name',
                          onSaved: (val) {},
                          validator: (val) {
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
                        const Expanded(child: DatePickerTextField()),
                        const SizedBox(
                          width: 30,
                        ),
                        renderDropdownList(
                            label: 'Grade',
                            intialValue: gradeDropdownValue,
                            menus: grades,
                            changed: (String? val) {
                              setState(() {
                                gradeDropdownValue = val!;
                              });
                            }),
                        const SizedBox(
                          width: 30,
                        ),
                        renderTextFormField(
                          label: 'Contact No 1',
                          onSaved: (val) {},
                          validator: (val) {
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
                        renderTextFormField(
                          label: 'Contact No 2',
                          onSaved: (val) {},
                          validator: (val) {
                            return null;
                          },
                        ),
                        const SizedBox(width: 30,),
                        renderTextFormField(
                          label: 'Email',
                          onSaved: (val) {},
                          validator: (val) {
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
                      top: 15
                    ),
                    child: Row(
                      children: [
                        renderTextFormField(
                          label: 'Address',
                          onSaved: (val) {},
                          validator: (val) {
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
                        renderTextFormArea(
                          label: 'Memo',
                          onSaved: (val) {},
                          validator: (val) {
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

  renderTextFormField({
    required String label,
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,
  }) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          // ignore: sized_box_for_whitespace
          TextFormField(
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            onSaved: onSaved,
            validator: validator,
          ),
        ],
      ),
    );
  }

  renderTextFormArea({
    required String label,
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,
  }) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          // ignore: sized_box_for_whitespace
          TextFormField(
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            maxLines: 3,
            onSaved: onSaved,
            validator: validator,
          ),
        ],
      ),
    );
  }

  renderDropdownList({
    String? label,
    required String intialValue,
    required List<String> menus,
    required Function(String? val) changed,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label!,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          InputDecorator(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: intialValue,
                onChanged: changed,
                items: menus.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  renderButton({
    required String label,
    required Function() tapped,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.all(
            25,
          ),
          elevation: 0.8,
          textStyle: const TextStyle(
            fontSize: 22,
          )),
      onPressed: tapped,
      child: Text(label),
    );
  }

  String stateDropdownValue = 'Victoria';
  var states = JaeState.values.map((e) => e.name).toList();

  String branchDropdownValue = 'Braybrook';
  var branches = JaeBranch.values.map((e) => e.name).toList();

  String gradeDropdownValue = 'P1';
  var grades = JaeGrade.values.map((e) => e.name).toList();
}
