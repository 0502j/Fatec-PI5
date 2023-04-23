import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pi5_flutter_application/pages/introPage.dart';
import 'package:pi5_flutter_application/pages/loginPage.dart';

class signUpPage extends StatefulWidget {
  const signUpPage({super.key});

  @override
  State<signUpPage> createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {
  //Controllers de text field
  var _controllerName;
  var _controllerEmail;
  var _controllerAge;
  var _controllerPwd;
  var _controllerPwdConfirm;

  //Controle de radio buttons
  var _gender;

  //Estado inicial
  @override
  void initState() {
    super.initState();
    _controllerName = TextEditingController();
    _controllerEmail = TextEditingController();
    _controllerAge = TextEditingController();
    _controllerPwd = TextEditingController();
    _controllerPwdConfirm = TextEditingController();
  }

  //Liberar recursos alocados
  @override
  void dispose() {
    _controllerName.dispose();
    _controllerEmail.dispose();
    _controllerAge.dispose();
    _controllerPwdConfirm.dispose();
    _controllerPwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Center(
            child: Material(
              color: Color(0xfffef7ff),
              child: Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 334,
                      child: Text(
                        "Cadastre-se",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 0, bottom: 0.0),
                      child: TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[a-zA-Z\s]+$')),
                          LengthLimitingTextInputFormatter(
                              50), //Aceitar apenas letras, máx 50 caracteres
                        ],
                        controller: _controllerName,
                        decoration: InputDecoration(
                            labelText: "Digite o seu nome",
                            hintText: "Seu nome e sobrenome",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0))),
                        onChanged: (value) {
                          //To do
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 0, bottom: 0.0),
                      child: TextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(
                              100), //Aceitar apenas letras, máx 50 caracteres
                        ],
                        controller: _controllerEmail,
                        decoration: InputDecoration(
                            labelText: "Digite seu e-mail",
                            hintText: "seunome@email.com",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0))),
                        onChanged: (value) {
                          //To do
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 0, bottom: 0.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          LengthLimitingTextInputFormatter(3)
                        ], //Regex p/ autorizar somente números
                        controller: _controllerAge,
                        decoration: InputDecoration(
                            labelText: "Digite sua idade",
                            hintText: "Idade",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0))),
                        onChanged: (value) {
                          //To do
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: RadioListTile(
                          title: Wrap(
                            direction: Axis.horizontal,
                            children: [
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
                            direction: Axis.horizontal,
                            children: [
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
                            direction: Axis.horizontal,
                            children: [
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
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 0, bottom: 8.0),
                      child: TextField(
                        inputFormatters: [LengthLimitingTextInputFormatter(50)],
                        controller: _controllerPwd,
                        decoration: InputDecoration(
                            labelText: "Digite sua senha",
                            hintText: "*******",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0))),
                        obscureText: true,
                        onChanged: (value) {
                          //To do
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 0, bottom: 8.0),
                      child: TextField(
                        inputFormatters: [LengthLimitingTextInputFormatter(50)],
                        controller: _controllerPwdConfirm,
                        decoration: InputDecoration(
                            labelText: "Confirme sua senha",
                            hintText: "*******",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0))),
                        obscureText: true,
                        onChanged: (value) {
                          //To do
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: SizedBox(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const introPage()));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff606c38),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          child: Text(
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
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              //To do
                            },
                            child: IconButton(
                              onPressed: () {},
                              icon: FaIcon(FontAwesomeIcons.google,
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
                              icon: FaIcon(FontAwesomeIcons.facebook,
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
                              icon: FaIcon(FontAwesomeIcons.twitter,
                                  color: Colors.black87),
                              iconSize: 40,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
