import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:orca/model/student_model.dart';

class ApiService {
  final String baseUrl = 'http://localhost:8080/student';

  final String count = 'count';

  void getStudentCount() async {
    final url = Uri.parse('$baseUrl/$count');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Error();
    }
  }

  Future<StudentModel> addStudent(StudentModel model) async {
    final url = Uri.parse(baseUrl);
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(model.toJson()),
    );

    print('Response Code : ${response.statusCode} '
        //with     ${jsonDecode(response.body)}'
        );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('API response: $responseData');
      return StudentModel.fromJson(responseData);
    } else {
      final errorMsg = jsonDecode(response.body)['message'];
      throw Exception('Failed to register Student');
    }
  }
}
