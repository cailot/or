import 'package:flutter/material.dart';

class JaeSmallButton extends StatelessWidget {
  final String label;
  final Function() tapped;

  const JaeSmallButton({
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
          fontSize: 12,
        ),
        minimumSize: const Size(50, 35),
        maximumSize: const Size(200, 50),
      ),
      onPressed: tapped,
      child: Text(label),
    );
  }
}
