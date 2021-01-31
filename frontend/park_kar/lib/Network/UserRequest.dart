import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:park_kar/models/UserModel.dart';
import '../constants.dart';

String userAuthUrl = 'https://parkkar-server.herokuapp.com/api/user/';

class UserAuth {
  Future loginRequest(String cred, String password) async {
    Map<String, String> headers = {"Content-type": "application/json"};
    final body = jsonEncode({"cred": cred, "password": password});

    http.Response response =
        await http.post('$userAuthUrl/login', body: body, headers: headers);

    if (response.statusCode == 200) {
      String data = response.body;
      final parsed = json.decode(data);

      user = UserModel.fromJson(parsed['data']['user']);
      token = parsed['data']['token'];
      return user;
    } else {
      print(response.statusCode);
    }
  }

  Future registerRequest(
      String name, String phone, String email, String password) async {
    Map<String, String> headers = {"Content-type": "application/json"};

    final body = jsonEncode(
        {"name": name, "phone": phone, "email": email, "password": password});

    http.Response response =
        await http.post('$userAuthUrl/signup', body: body, headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.statusCode);
    }
  }

  void forgotRequest(String email) async {
    Map<String, String> headers = {"Content-type": "application/json"};

    final body = jsonEncode({"email": email});

    http.Response response =
        await http.post('$userAuthUrl/recover', body: body, headers: headers);

    if (response.statusCode == 200) {
      return;
    } else {
      print(response.statusCode);
    }
  }

  Future googleRequest(String name, String email, String googleId) async {
    Map<String, String> headers = {"Content-type": "application/json"};

    final body =
        jsonEncode({"name": name, "email": email, "googleId": googleId});

    http.Response response =
        await http.post('$userAuthUrl/google', body: body, headers: headers);

    if (response.statusCode == 200) {
      String data = response.body;

      final parsed = json.decode(data);

      user = UserModel.fromJson(parsed['data']['user']);
      token = parsed['data']['token'];
      // print(user.id);
      // print(token);
      return user;
    } else {
      print(response.statusCode);
    }
  }
}
