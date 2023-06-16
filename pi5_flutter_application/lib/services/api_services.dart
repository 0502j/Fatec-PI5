import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

//http://ec2-18-118-151-165.us-east-2.compute.amazonaws.com:8080/usuario/login

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
