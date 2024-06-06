import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/model_user.dart';

class UserService {
  final String apiUrl = "https://reqres.in/api/users";

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      return json.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
