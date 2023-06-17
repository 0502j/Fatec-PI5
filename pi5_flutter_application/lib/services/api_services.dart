import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<http.Response> signUpUser(name, age, gender, email, pwd) {
  return http.post(
    Uri.parse(
        "http://ec2-18-118-151-165.us-east-2.compute.amazonaws.com:8080/usuario/cadastro"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'nome': name.toString(),
      'idade': age,
      'sexo': gender.toString(),
      'email': email.toString(),
      'senha': pwd.toString(),
    }),
  );
}

Future<http.Response> loginUser(email, pwd) {
  return http.post(
    Uri.parse(
        'http://ec2-18-118-151-165.us-east-2.compute.amazonaws.com:8080/usuario/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'senha': pwd,
    }),
  );
}

Future<http.Response> getEvents(String token) async {
  var url = Uri.parse(
      "http://ec2-18-118-151-165.us-east-2.compute.amazonaws.com:8080/eventos");

  var response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    },
  );

  return response;
}

Future<void> setToken(String token) async {
  await storage.write(key: "token", value: token);
}

Future<String?> getToken() async {
  var res = await storage.read(key: "token");
  return res;
}
