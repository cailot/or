import 'package:flutter/material.dart';

class JaeFixedTextField extends StatelessWidget {
  final String label;
  final String initial;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;

  const JaeFixedTextField({
    required this.label,
    required this.onSaved,
    required this.validator,
    required this.initial,
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
            initialValue: initial,
            readOnly: true,
            onSaved: onSaved,
            validator: validator,
          ),
        ],
      ),
    );
  }
}
