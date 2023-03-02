import 'package:flutter/material.dart';

class JaeTextArea extends StatelessWidget {
  final String label;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;

  const JaeTextArea({
    required this.label,
    required this.onSaved,
    required this.validator,
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
          ),
        ],
      ),
    );
  }
}
