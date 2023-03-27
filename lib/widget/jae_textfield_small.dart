import 'package:flutter/material.dart';

class JaeSmallTextField extends StatelessWidget {
  final String label;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;
  TextEditingController? controller;

  // ignore: use_key_in_widget_constructors
  JaeSmallTextField({
    required this.label,
    required this.onSaved,
    required this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          // ignore: sized_box_for_whitespace
          SizedBox(
            height: 35,
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              onSaved: onSaved,
              validator: validator,
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
