import 'package:flutter/material.dart';

class DatePickerTextField extends StatefulWidget {
  const DatePickerTextField({Key? key}) : super(key: key);

  @override
  _DatePickerTextFieldState createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  late TextEditingController _textEditingController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      decoration: InputDecoration(
        labelText: 'Enrolment Date',
        border: OutlineInputBorder(),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());
        final initialDate = _selectedDate ?? DateTime.now();
        final newDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (newDate != null) {
          setState(() {
            _selectedDate = newDate;
            _textEditingController.text = '${newDate.day}/${newDate.month}/${newDate.year}';
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
