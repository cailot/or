import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JaeDatepicker extends StatefulWidget {
  final String label;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;
  DateTime? selected;

  JaeDatepicker({
    required this.label,
    required this.onSaved,
    required this.validator,
    this.selected,
  });

  @override
  State<JaeDatepicker> createState() => _JaeDatepickerState();
}

class _JaeDatepickerState extends State<JaeDatepicker> {
  late TextEditingController controller;
  //DateTime? _selected;

  @override
  void initState() {
    super.initState();
    final display = DateFormat('dd/MM/yyyy').format(widget.selected!);
    controller = TextEditingController(text: display);
  }

  @override
  Widget build(BuildContext context) {
    final display = DateFormat('dd/MM/yyyy').format(widget.selected!);
    controller.text = display;
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
          SingleChildScrollView(
            //scrollDirection: Axis.horizontal,
            child: TextFormField(
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
                var results = await showCalendarDatePicker2Dialog(
                  context: context,
                  config: CalendarDatePicker2WithActionButtonsConfig(),
                  dialogSize: const Size(325, 400),
                  borderRadius: BorderRadius.circular(5),
                  //initialValue: [widget.selected ?? DateTime.now()],
                );
                if (results != null) {
                  widget.selected = results.first;
                  controller.text =
                      '${widget.selected?.day}/${widget.selected?.month}/${widget.selected?.year}';
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
