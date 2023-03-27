import 'package:flutter/material.dart';

class JaeSmallDropdownList extends StatelessWidget {
  final String label;
  final String value;
  final List<String> menus;
  final Function(String? val) changed;

  const JaeSmallDropdownList({
    required this.label,
    required this.value,
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
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                vertical: -5,
                horizontal: 5,
              ),
            ),
            child: SizedBox(
              height: 30,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: value,
                  isExpanded: true,
                  onChanged: changed,
                  items: menus.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  //itemHeight: 50,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
