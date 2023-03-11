import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JaeDatepicker extends StatefulWidget {
  final String label;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;

  const JaeDatepicker({
    required this.label,
    required this.onSaved,
    required this.validator,
  });

  @override
  State<JaeDatepicker> createState() => _JaeDatepickerState();
}

class _JaeDatepickerState extends State<JaeDatepicker> {
  late TextEditingController controller;
  DateTime? _selected;

  @override
  void initState() {
    super.initState();
    final today = DateFormat('dd/MM/yyyy').format(DateTime.now());
    controller = TextEditingController(text: today);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.label,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          TextFormField(
            controller: controller,
            //initialValue: today,
            decoration: const InputDecoration(
              hintText: 'Select Date',
              border: OutlineInputBorder(),
            ),
            readOnly: true,
            onSaved: widget.onSaved,
            validator: widget.validator,
            onTap: () async {
              /*
              final picked = await showDatePicker(
                context: context,
                initialDate: _selected ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                setState(() {
                  _selected = picked;
                  controller.text =
                      '${_selected?.day}/${_selected?.month}/${_selected?.year}';
                });
              }*/
              var results = await showCalendarDatePicker2Dialog(
                context: context,
                config: CalendarDatePicker2WithActionButtonsConfig(),
                dialogSize: const Size(325, 400),
                borderRadius: BorderRadius.circular(5),
                initialValue: [_selected ?? DateTime.now()],
              );
              if (results != null) {
                setState(() {
                  _selected = results.first;
                  controller.text =
                      '${_selected?.day}/${_selected?.month}/${_selected?.year}';
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
