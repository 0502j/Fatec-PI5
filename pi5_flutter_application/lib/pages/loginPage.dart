import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pi5_flutter_application/pages/dashboardPage.dart';
import 'package:pi5_flutter_application/services/api_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  //Controllers de text field e-mail e senha

  String _email = "";
  String _password = "";
  String hasError = "";
  final _formKey = GlobalKey<FormState>();

  //loading req
  bool isLoading = false;

  //Estado inicial
  @override
  void initState() {
    super.initState();
  }

  //Liberar recursos alocados
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Container(
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: SpinKitPulse(
                        color: const Color(0xff606c38),
                        size: 50.0,
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/ct-worldwmap.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(
                        width: 334,
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0,
                                    right: 16.0,
                                    top: 16.0,
                                    bottom: 0.0),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      _email = value;
                                    });
                                  },
                                  initialValue: _email,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(
                                        100), //Máx 100 caracteres
                                  ],
                                  decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(12, 6, 12, 6),
                                      labelText: "E-mail",
                                      hintText: "seuemail@email.com",
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 2.0))),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Informe seu e-mail";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _email = value!;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 40),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0,
                                    right: 16.0,
                                    top: 0,
                                    bottom: 8.0),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      _password = value;
                                    });
                                  },
                                  initialValue: _password,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(50)
                                  ],
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(12, 6, 12, 6),
                                      labelText: "Senha",
                                      hintText: "*******",
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 2.0))),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Informe sua senha";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _email = value!;
                                    });
                                  },
                                ),
                              ),
                              hasError == ""
                                  ? SizedBox(
                                      height: 1,
                                    )
                                  : Text(
                                      hasError,
                                      style: TextStyle(color: Colors.red),
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: SizedBox(
                                  width: 300,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        try {
                                          var response = await loginUser(
                                              _email, _password);
                                          if (response.statusCode == 200 ||
                                              response.statusCode == 201 ||
                                              response.statusCode == 202) {
                                            var responseBody =
                                                jsonDecode(response.body);
                                            var token =
                                                responseBody['token'] as String;

                                            await setToken(token);

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    dashboardPage(),
                                              ),
                                            );
                                          } else {
                                            hasError =
                                                "Não foi possível entrar. Verifique suas informações e tente novamente.";
                                          }
                                        } catch (error) {
                                          setState(() {
                                            hasError =
                                                "Não foi possível cadastrar: $error";
                                          });
                                        }

                                        // signUpUser(_name, _email, _age,
                                        //     _gender.substring(0, 1), _password);
                                        setState(() {
                                          isLoading = false;
                                        });
                                      } else {
                                        setState(() {
                                          hasError =
                                              "Verifique suas informações e tente novamente";
                                        });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color(0xff606c38),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    child: const Text(
                                      "Entrar",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        //To do
                                      },
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const FaIcon(
                                            FontAwesomeIcons.google,
                                            color: Colors.black87),
                                        iconSize: 40,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        //To do
                                      },
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const FaIcon(
                                            FontAwesomeIcons.facebook,
                                            color: Colors.black87),
                                        iconSize: 40,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        //To do
                                      },
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const FaIcon(
                                            FontAwesomeIcons.twitter,
                                            color: Colors.black87),
                                        iconSize: 40,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                )));
  }
}
