import 'package:flutter/material.dart';

class JaeDropdownList extends StatelessWidget {
  final String label;
  final String intialValue;
  final List<String> menus;
  final Function(String? val) changed;
  
  const JaeDropdownList({ 
    required this.label,
    required this.intialValue,
    required this.menus,
    required this.changed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          InputDecorator(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: intialValue,
                onChanged: changed,
                items: menus.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
