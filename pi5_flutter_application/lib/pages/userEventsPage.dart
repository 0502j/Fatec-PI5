import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pi5_flutter_application/pages/eventDetailPage.dart';
import 'package:pi5_flutter_application/pages/eventManagementPage.dart';
import 'package:pi5_flutter_application/pages/settingsPage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pi5_flutter_application/services/api_services.dart';
import 'package:pi5_flutter_application/model/model.dart';

class userEventsPage extends StatefulWidget {
  const userEventsPage({super.key});

  @override
  State<userEventsPage> createState() => _userEventsPageState();
}

class _userEventsPageState extends State<userEventsPage> {
  bool isLoading = false;
  bool isContentLoading = false;
  final storage = const FlutterSecureStorage();
  String? userToken;

  //Lógica de seleção de chips e edição de eventos
  List<bool> _isChipSelected = [false, false];
  bool _isEventByCurUser = true;

  void selectChip(int index) {
    setState(() {
      _isChipSelected[index] = true;

      for (int i = 0; i < _isChipSelected.length; i++) {
        if (i != index) {
          _isChipSelected[i] = false;
        }
      }
    });
  }

  void unselectChip(int index) {
    setState(() {
      _isChipSelected[index] = true;

      for (int i = 0; i < _isChipSelected.length; i++) {
        _isChipSelected[i] = false;
      }
    });
  }

//Seleção de cards
  bool _isSelected = false;

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
    getUserEventsFunction(userToken);
    print(events);
    setState(() {
      isLoading = false;
    });
  }

  List<Event> events = [];
  //Carregar eventos usando token do usuário
  void getUserEventsFunction(String? userToken) async {
    setState(() {
      isContentLoading = true;
    });
    try {
      if (userToken != null) {
        var response = await getUserEvents(userToken);
        if (response.statusCode == 200) {
          var data = json.decode(utf8.decode(response.bodyBytes));
          List<dynamic> eventList = data['Eventos'];
          List<Event> eventObjects = eventList
              .map<Event>((eventData) => Event.fromJson(eventData))
              .toList();

          setState(() {
            events = eventObjects;
          });
        }
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isContentLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userToken == null && !isLoading
          ? Text("Usuário não autenticado, necessário login.")
          : isLoading
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: SpinKitPulse(
                      color: Color(0xff606c38),
                      size: 50.0,
                    ),
                  ),
                )
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100, // altura definida
                            width: double.infinity,
                            child: Image.asset(
                              'assets/images/eventsHeader.png',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ]),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  width: 250,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Seus eventos",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Eventos que você criou ou que está participando no momento.",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const settingsPage()));
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "assets/images/freepik-settings.png"))),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10)),
                            child: Wrap(
                              spacing: 8,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                isContentLoading
                                    ? Container(
                                        child: Center(
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            child: Center(
                                              child: SpinKitPulse(
                                                color: const Color(0xff606c38),
                                                size: 50.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : events.isEmpty &&
                                            userToken != null &&
                                            isContentLoading == false
                                        ? Padding(
                                            padding: EdgeInsets.all(16),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    "Nenhum evento ainda. Que tal criar ou participar de um agora mesmo?",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          179, 25, 93, 27),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(height: 10),
                                                  Container(
                                                    height: 80,
                                                    width: 80,
                                                    child: Image.asset(
                                                        'assets/images/freepik-wind.png'),
                                                  )
                                                ],
                                              ),
                                            ))
                                        : Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Column(
                                              children: events.map((event) {
                                                final nome = event.nome;
                                                final descricao =
                                                    event.descricao;
                                                final data = event.data;
                                                final hora = event.hora;
                                                final tipo = event.tipo;
                                                final imagem = event.image;

                                                var cvTipo =
                                                    event.tipo.toString();
                                                var tipoReplaced =
                                                    cvTipo.replaceAll('_', ' ');
                                                var tipoLower =
                                                    tipoReplaced.toLowerCase();

                                                return GestureDetector(
                                                  onTap: () async {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                eventDetailPage(
                                                                  event: event,
                                                                  hideSignUpButton:
                                                                      true,
                                                                  hideParticipantsList:
                                                                      true,
                                                                )));
                                                  },
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.0),
                                                      side: BorderSide(
                                                          color: Colors.grey,
                                                          width: 1),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  nome,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                Text(
                                                                    "Categoria: $tipoLower"),
                                                                Text(
                                                                    "Data: $data"),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 10.0),
                                                          isLoading
                                                              ? Container(
                                                                  width: 50,
                                                                  height: 50,
                                                                  child: Center(
                                                                    child:
                                                                        SpinKitPulse(
                                                                      color: const Color(
                                                                          0xff606c38),
                                                                      size:
                                                                          50.0,
                                                                    ),
                                                                  ),
                                                                )
                                                              : Column(
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8),
                                                                        child: imagem ==
                                                                                null
                                                                            ? ClipRRect(
                                                                                child: Image.asset(
                                                                                  'assets/images/rawpixel-eventPlaceholder.jpg',
                                                                                  fit: BoxFit.cover,
                                                                                  height: 80,
                                                                                  width: 100,
                                                                                ),
                                                                              )
                                                                            : Image.memory(
                                                                                base64Decode(event.image!.replaceAll(RegExp(r'\s+'), '')),
                                                                                fit: BoxFit.cover,
                                                                                height: 80,
                                                                                width: 100,
                                                                              )),
                                                                    SizedBox(
                                                                        height:
                                                                            15),
                                                                    Row(
                                                                      children: [
                                                                        GestureDetector(
                                                                          // onTap:
                                                                          //     () async {},
                                                                          child:
                                                                              FaIcon(
                                                                            FontAwesomeIcons.edit,
                                                                            size:
                                                                                20,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                25,
                                                                                107,
                                                                                30),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              15,
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () async {
                                                                            try {
                                                                              var response = await deleteEvent(userToken!, event.id);
                                                                              if (response.statusCode == 200) {
                                                                                //abrir modal
                                                                                showDialog(
                                                                                    context: context,
                                                                                    builder: (BuildContext context) {
                                                                                      return AlertDialog(
                                                                                        title: Text("Evento deletado"),
                                                                                        content: Text("O evento ' $nome ' foi deletado com sucesso. "),
                                                                                        actions: <Widget>[
                                                                                          TextButton(
                                                                                            child: Text('Fechar'),
                                                                                            onPressed: () {
                                                                                              Navigator.of(context).pop();
                                                                                            },
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                    });

                                                                                getUserEventsFunction(userToken);
                                                                              } else {
                                                                                showDialog(
                                                                                    context: context,
                                                                                    builder: (BuildContext context) {
                                                                                      return AlertDialog(
                                                                                        title: Text("Não foi possível deletar."),
                                                                                        content: Text("Certifique-se que você é o proprietário do evento e tente novamente mais tarde."),
                                                                                        actions: <Widget>[
                                                                                          TextButton(
                                                                                            child: Text('Fechar'),
                                                                                            onPressed: () {
                                                                                              Navigator.of(context).pop();
                                                                                            },
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                    });
                                                                              }
                                                                            } catch (e) {}
                                                                          },
                                                                          child:
                                                                              FaIcon(
                                                                            FontAwesomeIcons.trash,
                                                                            size:
                                                                                20,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                162,
                                                                                35,
                                                                                16),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              15,
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () async {
                                                                            try {
                                                                              var response = await cancelEventSubscription(userToken!, event.id);
                                                                              if (response.statusCode == 200) {
                                                                                //abrir modal
                                                                                showDialog(
                                                                                    context: context,
                                                                                    builder: (BuildContext context) {
                                                                                      return AlertDialog(
                                                                                        title: Text("Inscrição cancelada"),
                                                                                        content: Text("Sua inscrição foi cancelada no evento ' $nome ' com sucesso. "),
                                                                                        actions: <Widget>[
                                                                                          TextButton(
                                                                                            child: Text('Fechar'),
                                                                                            onPressed: () {
                                                                                              Navigator.of(context).pop();
                                                                                            },
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                    });

                                                                                getUserEventsFunction(userToken);
                                                                              } else {
                                                                                showDialog(
                                                                                    context: context,
                                                                                    builder: (BuildContext context) {
                                                                                      return AlertDialog(
                                                                                        title: Text("Não foi possível cancelar sua inscrição."),
                                                                                        content: Text("Tente novamente mais tarde!"),
                                                                                        actions: <Widget>[
                                                                                          TextButton(
                                                                                            child: Text('Fechar'),
                                                                                            onPressed: () {
                                                                                              Navigator.of(context).pop();
                                                                                            },
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                    });
                                                                              }
                                                                            } catch (e) {}
                                                                          },
                                                                          child:
                                                                              FaIcon(
                                                                            FontAwesomeIcons.ban,
                                                                            size:
                                                                                20,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                31,
                                                                                5,
                                                                                1),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
    );
  }
}
