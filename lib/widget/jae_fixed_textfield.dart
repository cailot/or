import 'package:flutter/material.dart';

class JaeFixedTextField extends StatelessWidget {
  final String label;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;
  TextEditingController? controller;

  JaeFixedTextField({
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
            style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color.fromRGBO(0, 0, 153, 1.0)),
            readOnly: true,
            onSaved: onSaved,
            validator: validator,
            controller: controller,
          ),
        ],
      ),
    );
  }
}
