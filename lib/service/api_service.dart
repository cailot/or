import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:orca/model/list_condition_model.dart';
import 'package:orca/model/student_model.dart';

class ApiService {
  final String baseUrl = 'http://localhost:8080';

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
    final url = Uri.parse('$baseUrl/student');
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      //print('API response: $responseData');
      return StudentModel.fromJson(responseData);
    } else {
      final errorMsg = jsonDecode(response.body)['message'];
      throw Exception('Failed to register Student');
    }
  }

  Future<StudentModel> updateStudent(StudentModel model) async {
    final url = Uri.parse('$baseUrl/student/${model.id.toString()}');
    final response = await http.put(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      //print('Update API response: $responseData');
      return StudentModel.fromJson(responseData);
    } else {
      final errorMsg = jsonDecode(response.body)['message'];
      throw Exception('Failed to update Student');
    }
  }

  Future<StudentModel?> getStudent(int id) async {
    final url = Uri.parse('$baseUrl/student/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      if ((response.body == null) || (response.body.isEmpty)) {
        return null;
      }
      final responseData = jsonDecode(response.body);
      //print('Get API response: $responseData');
      return StudentModel.fromJson(responseData);
    } else {
      final errorMsg = jsonDecode(response.body)['message'];
      print(errorMsg);
      return null; // return empty StudentModel
      //throw Exception('Failed to get Student');
    }
  }

  Future<List<dynamic>> getStudents(ListConditionModel model) async {
    final url = Uri.parse(
        '$baseUrl/students?state=${model.state}&branch=${model.branch}&grade=${model.grade}&year=${model.year}&active=${model.activeStudent}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      if ((response.body == null) || (response.body.isEmpty)) {
        return [];
      }
      List<dynamic> data = json.decode(response.body);
      //print('Get API response: $responseData');
      return data;
    } else {
      final errorMsg = jsonDecode(response.body)['message'];
      print(errorMsg);
      return []; // return empty StudentModel
      //throw Exception('Failed to get Student');
    }
  }
}
