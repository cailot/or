import 'package:flutter/foundation.dart';

class StudentProvider extends ChangeNotifier {
  int studentId = 0;

  String _state = '';

  String get state => _state;

  set state(String newVal) {
    _state = newVal;
    notifyListeners();
  }
}
