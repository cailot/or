import 'package:flutter/material.dart';
import 'package:orca/util/jae_utils.dart';

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
      color: Colors.amber.shade300,
      child: Column(
        children: [
          const Text(
            'Student Enrolment',
          ),
          Row(
            children: [
              DropdownButton(
                items: const [
                  DropdownMenuItem(
                    value: 'VIC',
                    child: Text(
                      'Victoria',
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'NSW',
                    child: Text(
                      'New South Wales',
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'QLD',
                    child: Text(
                      'Queensland',
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'WA',
                    child: Text(
                      'West Australia',
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'SA',
                    child: Text(
                      'South Australia',
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'ACT',
                    child: Text(
                      'ACT',
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'NT',
                    child: Text(
                      'Northern Territory',
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'TAS',
                    child: Text(
                      'Tasmania',
                    ),
                  ),
                ],
                onChanged: (String? value) {},
              ),
              DropdownButton(
                items: const [
                  DropdownMenuItem(
                    value: 'braybrook',
                    child: Text(
                      'Braybrook',
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'boxhill',
                    child: Text(
                      'Box Hill',
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'balwyn',
                    child: Text(
                      'Balwyn',
                    ),
                  ),
                ],
                onChanged: (String? value) {},
              ),
              OutlinedButton(
                child: const Text(
                  'New',
                ),
                onPressed: () {},
              ),
              OutlinedButton(
                child: const Text(
                  'Save',
                ),
                onPressed: () {},
              ),
            ],
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
                  Row(
                    children: [
                      renderTextFormField(
                        label: 'Branch',
                        onSaved: (val) {},
                        validator: (val) {
                          return null;
                        },
                      ),
                      renderTextFormField(
                        label: 'ID',
                        onSaved: (val) {},
                        validator: (val) {
                          return null;
                        },
                      ),
                      renderTextFormField(
                        label: 'First Name',
                        onSaved: (val) {},
                        validator: (val) {
                          return null;
                        },
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
                  Row(
                    children: [
                      renderTextFormField(
                        label: 'Enrolment Date',
                        onSaved: (val) {},
                        validator: (val) {
                          return null;
                        },
                      ),
                      renderDropdownButton(
                        label: 'Grade',
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
                  Row(
                    children: [
                      renderTextFormField(
                        label: 'Contact No 2',
                        onSaved: (val) {},
                        validator: (val) {
                          return null;
                        },
                      ),
                      renderTextFormField(
                        label: 'Email',
                        onSaved: (val) {},
                        validator: (val) {
                          return null;
                        },
                      ),
                    ],
                  ),
                  Row(
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
                  Row(
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
            maxLines: 3,
            onSaved: onSaved,
            validator: validator,
          ),
        ],
      ),
    );
  }

  renderDropdownButton({
    required String label,
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
          DropdownButton(
            value: gradeDropdownValue,
            onChanged: (String? val) {
              setState(
                () {
                  gradeDropdownValue = val!;
                },
              );
            },
            items: grades.map((String item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String gradeDropdownValue = 'P1';
  var grades = Grade.values.map((e) => e.name).toList();
}
