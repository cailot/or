import 'package:flutter/material.dart';

class JaeTextArea extends StatelessWidget {
  final String label;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;
  //String? initial;
  TextEditingController? controller;

  JaeTextArea({
    required this.label,
    required this.onSaved,
    required this.validator,
    //this.initial,
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
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          // ignore: sized_box_for_whitespace
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            onSaved: onSaved,
            validator: validator,
            maxLines: 3,
            //initialValue: initial,
            controller: controller,
          ),
        ],
      ),
    );
  }
}
