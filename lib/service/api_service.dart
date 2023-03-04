import 'package:http/http.dart' as http;
class ApiService {
  final String baseUrl = 'http://localhost:8080/student';

  final String count = 'count';

  void getStudentCount() async {
    final url = Uri.parse('${baseUrl}s');
    final response = await http.get(url);
    print(response.statusCode);
    if(response.statusCode == 200){
      print(response.body);
    }else{
      throw Error();
    }
  }
}
