import 'dart:convert';
import '../model/user_model.dart';
import 'package:http/http.dart';

class UserRepository {
  String endPoint = "https://reqres.in/api/users?page=2";
  Future<List<UserModel>> getUsers() async {
    Response response = await get(Uri.parse(endPoint));
    final List result = jsonDecode(response.body)['data'];
    return result.map(((e) => UserModel.fromJson(e))).toList();
  }
}
