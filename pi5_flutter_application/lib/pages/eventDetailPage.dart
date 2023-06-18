// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pi5_flutter_application/pages/confirmPage.dart';
import 'package:pi5_flutter_application/pages/dashboardPage.dart';
import 'package:pi5_flutter_application/pages/participantsPage.dart';
import 'package:pi5_flutter_application/services/api_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class eventDetailPage extends StatefulWidget {
  final Event event;

  const eventDetailPage({super.key, required this.event});

  @override
  State<eventDetailPage> createState() => _eventDetailPageState();
}

class _eventDetailPageState extends State<eventDetailPage> {
  bool isLoading = false;
  String hasError = "";

  final storage = FlutterSecureStorage();
  String? userToken;

  @override
  void initState() {
    super.initState();

    loadToken();
  }

  //Carregar token do usuário
  Future<void> loadToken() async {
    setState(() {
      isLoading = true;
    });
    String? token = await storage.read(key: "token");
    if (token != null) {
      setState(() {
        userToken = token;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;

    return Scaffold(
        body: ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        isLoading
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: SpinKitPulse(
                    color: const Color(0xff606c38),
                    size: 50.0,
                  ),
                ),
              )
            : userToken == null && isLoading == false
                ? Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                        "Você não pode ver os detalhes desse evento. Por favor, faça seu login."),
                  )
                : SizedBox(
                    width: double.maxFinite,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Detalhes do evento",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22)),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                      color: Color(0xff606c38),
                                      width: 1,
                                    )),
                                child: Column(
                                  children: [
                                    //Uso de mediaquery para adequar o tamanho da imagem do evento
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          child: event.image == null
                                              ? ClipRRect(
                                                  child: Image.asset(
                                                    'assets/images/rawpixel-eventPlaceholder.jpg',
                                                    fit: BoxFit.cover,
                                                    height: 80,
                                                    width: 100,
                                                  ),
                                                )
                                              : Image.memory(
                                                  base64Decode(event.image!
                                                      .replaceAll(
                                                          RegExp(r'\s+'), '')),
                                                  fit: BoxFit.cover,
                                                  height: 80,
                                                  width: 100,
                                                )),
                                    ),

                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 0,
                                              bottom: 0,
                                              right: 16,
                                              left: 16),
                                          child: Text(
                                            "${event.nome}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 20),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        GestureDetector(
                                          onTap: () => {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        participantsPage(
                                                            event: event)))
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.only(
                                                top: 0,
                                                bottom: 0,
                                                right: 16,
                                                left: 16),
                                            child: Text(
                                              "Ver lista de participantes",
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xff606c38),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Wrap(
                                            children: [
                                              Text(
                                                "Sobre o evento:",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                "${event.descricao}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Wrap(
                                            children: [
                                              Text(
                                                "Local do evento:",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                "${event.local}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Wrap(
                                            children: [
                                              Text(
                                                "Data / Horário:",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                "${event.data}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 16),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "${event.hora}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                        hasError == ""
                                            ? SizedBox(
                                                height: 1,
                                              )
                                            : Text(
                                                hasError,
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: SizedBox(
                                              width: 300,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  try {
                                                    if (userToken != null) {
                                                      var response =
                                                          await sendEventSubscription(
                                                              userToken!,
                                                              event.id);
                                                      if (response.statusCode ==
                                                              200 ||
                                                          response.statusCode ==
                                                              201) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const confirmPage()));
                                                      } else {
                                                        hasError =
                                                            "Não foi possível se inscrever. $response.body";
                                                      }
                                                    }
                                                  } catch (e) {
                                                    print(e);
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary:
                                                      const Color(0xff606c38),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                ),
                                                child: const Text(
                                                  "Inscrever-se",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                  )
      ],
    ));
  }
}
