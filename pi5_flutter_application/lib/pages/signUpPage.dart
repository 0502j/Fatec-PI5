import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pi5_flutter_application/pages/introPage.dart';

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
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Center(
            child: Material(
                color: const Color(0xfffef7ff),
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                              child: TextField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^[a-zA-Z\s]+$')),
                                  LengthLimitingTextInputFormatter(
                                      50), //Aceitar apenas letras, máx 50 caracteres
                                ],
                                controller: _controllerName,
                                decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 6, 12, 6),
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
                            const SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 0, bottom: 0.0),
                              child: TextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(
                                      100), //Aceitar apenas letras, máx 50 caracteres
                                ],
                                controller: _controllerEmail,
                                decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 6, 12, 6),
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
                            const SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 0, bottom: 0.0),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                  LengthLimitingTextInputFormatter(3)
                                ], //Regex p/ autorizar somente números
                                controller: _controllerAge,
                                decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 6, 12, 6),
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
                            const SizedBox(height: 30),
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
                            const SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 0, bottom: 8.0),
                              child: TextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(50)
                                ],
                                controller: _controllerPwd,
                                decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 6, 12, 6),
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
                            const SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 0, bottom: 8.0),
                              child: TextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(50)
                                ],
                                controller: _controllerPwdConfirm,
                                decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 6, 12, 6),
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
                                            builder: (context) =>
                                                const introPage()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xff606c38),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
                        ),
                      )),
                )),
          ),
        ));
  }
}
