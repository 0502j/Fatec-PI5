import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pi5_flutter_application/pages/introPage.dart';
import 'package:pi5_flutter_application/services/api_services.dart';

class signUpPage extends StatefulWidget {
  const signUpPage({super.key});

  @override
  State<signUpPage> createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {
  //Controllers de text field

  String _name = "";
  String _age = "";
  String _email = "";
  String _password = "";
  String _confirmPassword = "";
  String hasError = "";
  final _formKey = GlobalKey<FormState>();

  //Controle de radio buttons
  var _gender;

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
        body: SingleChildScrollView(
      child: isLoading
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
              child: Material(
                  color: const Color(0xfffef7ff),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 150, // altura definida
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/ct-bike.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          width: 334,
                          child: Text(
                            "Cadastre-se",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 0, bottom: 0.0),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _name = value;
                              });
                            },
                            initialValue: _name,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^[a-zA-Z\s]+$')),
                              LengthLimitingTextInputFormatter(50),
                            ],
                            decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 6, 12, 6),
                                labelText: "Digite o seu nome",
                                hintText: "Seu nome e sobrenome",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Informe seu nome";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _name = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 0, bottom: 0.0),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _email = value;
                              });
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                  100), //Aceitar apenas letras, máx 50 caracteres
                            ],
                            decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 6, 12, 6),
                                labelText: "Digite seu e-mail",
                                hintText: "seunome@email.com",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0))),
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
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 0, bottom: 0.0),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _age = value;
                              });
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              LengthLimitingTextInputFormatter(3)
                            ], //Regex p/ autorizar somente números
                            decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 6, 12, 6),
                                labelText: "Digite sua idade",
                                hintText: "Idade",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Informe sua idade";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _age = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                child: RadioListTile(
                              title: Wrap(
                                direction: Axis.vertical,
                                children: const [
                                  Text(
                                    "Masculino",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              value: "Masculino",
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            )),
                            Expanded(
                                child: RadioListTile(
                              title: Wrap(
                                direction: Axis.vertical,
                                children: const [
                                  Text(
                                    "Feminino",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              value: "Feminino",
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            )),
                            Expanded(
                                child: RadioListTile(
                              title: Wrap(
                                direction: Axis.vertical,
                                children: const [
                                  Text(
                                    "Outro",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              value: "Outro",
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            )),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 0, bottom: 8.0),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _password = value;
                              });
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50)
                            ],
                            decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 6, 12, 6),
                                labelText: "Digite sua senha",
                                hintText: "*******",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0))),
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Informe sua senha";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _password = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 0, bottom: 8.0),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _confirmPassword = value;
                              });
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50)
                            ],
                            decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 6, 12, 6),
                                labelText: "Confirme sua senha",
                                hintText: "*******",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0))),
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Informe sua senha";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _confirmPassword = value!;
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
                                if (_formKey.currentState!.validate() &&
                                    _password == _confirmPassword &&
                                    _gender != null &&
                                    _gender != "") {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    var response = await signUpUser(
                                        _name,
                                        int.parse(_age),
                                        _gender.substring(0, 1),
                                        _email,
                                        _password);
                                    if (response.statusCode == 200 ||
                                        response.statusCode == 201) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const introPage()));
                                    } else {
                                      hasError =
                                          "Não foi possível cadastrar: $response.statusCode";
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
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              child: const Text(
                                "Cadastrar",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  //To do
                                },
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const FaIcon(FontAwesomeIcons.google,
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
                                  icon: const FaIcon(FontAwesomeIcons.facebook,
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
                                  icon: const FaIcon(FontAwesomeIcons.twitter,
                                      color: Colors.black87),
                                  iconSize: 40,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ),
    ));
  }
}
