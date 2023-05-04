import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pi5_flutter_application/pages/dashboardPage.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  //Controllers de text field e-mail e senha
  var _controller;
  var _controllerPwd;

  //Estado inicial
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controllerPwd = TextEditingController();
  }

  //Liberar recursos alocados
  @override
  void dispose() {
    _controller.dispose();
    _controllerPwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 150, // altura definida
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
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0, bottom: 0.0),
                    child: TextField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                            100), //Máx 100 caracteres
                      ],
                      controller: _controller,
                      decoration: const InputDecoration(
                          labelText: "Digite seu e-mail",
                          hintText: "seunome@email.com",
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0))),
                      onChanged: (value) {
                        //To do
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 0, bottom: 8.0),
                    child: TextField(
                      inputFormatters: [LengthLimitingTextInputFormatter(50)],
                      controller: _controllerPwd,
                      decoration: const InputDecoration(
                          labelText: "Digite sua senha",
                          hintText: "*******",
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0))),
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
                                  builder: (context) => const dashboardPage()));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xff606c38),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
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
            )));
  }
}
