import 'package:flutter/material.dart';

class JaeSmallTextField extends StatelessWidget {
  String label;
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
      child: SizedBox(
        height: 35,
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(),
          ),
          onSaved: onSaved,
          validator: validator,
          controller: controller,
        ),
      ),
    );
  }
}
