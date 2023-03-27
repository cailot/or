import 'package:flutter/material.dart';

class JaeSmallTextArea extends StatelessWidget {
  final String label;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;
  //String? initial;
  TextEditingController? controller;

  JaeSmallTextArea({
    required this.label,
    required this.onSaved,
    required this.validator,
    //this.initial,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
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
        maxLines: 2,
        //initialValue: initial,
        controller: controller,
      ),
    );
  }
}
