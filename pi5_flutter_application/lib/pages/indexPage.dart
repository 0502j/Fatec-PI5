import 'package:flutter/material.dart';
import 'package:pi5_flutter_application/pages/dashboardPage.dart';
import 'package:pi5_flutter_application/pages/signUpPage.dart';
import 'package:pi5_flutter_application/pages/loginPage.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Material(
              color: Color(0xfffef7ff),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 100,
                      bottom: 274,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                              child: Image.asset(
                                  'assets/images/ct-worldwmap.jpg')),
                        ),
                        SizedBox(height: 32.50),
                        SizedBox(
                          width: 334,
                          child: Text(
                            "[Nome do projeto]",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
                        SizedBox(
                          width: 257,
                          child: Text(
                            "Descubra eventos, participe e faça diferença na causa ambiental.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 270,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Color(0xff606c38),
                            borderRadius: BorderRadius.circular(100),
                            border:
                                Border.all(color: Color(0xff79747e), width: 1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const dashboardPage()));
                                            },
                                            child: Text(
                                              "Já tenho uma conta",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontFamily: "Roboto",
                                                  fontWeight: FontWeight.w500),
                                            ))
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 270,
                          height: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border:
                                Border.all(color: Color(0xff79747e), width: 1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const signUpPage()));
                                            },
                                            child: Text(
                                              "Registrar-se",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color(0xff283618),
                                                  fontSize: 16,
                                                  fontFamily: "Roboto",
                                                  fontWeight: FontWeight.w500),
                                            ))
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }
}
