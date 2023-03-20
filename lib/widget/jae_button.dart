import 'package:flutter/material.dart';

class JaeButton extends StatelessWidget {
  final String label;
  final Function() tapped;

  const JaeButton({
    required this.label,
    required this.tapped,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.all(
          5,
        ),
        elevation: 0.8,
        textStyle: const TextStyle(
          fontSize: 18,
        ),
        minimumSize: const Size(80, 50),
        maximumSize: const Size(100, 50),
      ),
      onPressed: tapped,
      child: Text(label),
    );
  }
}
