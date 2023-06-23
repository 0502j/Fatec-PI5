import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pi5_flutter_application/pages/confirmPage.dart';
import 'package:pi5_flutter_application/services/api_services.dart';
import 'package:pi5_flutter_application/model/model.dart';

class participantsPage extends StatefulWidget {
  final Event event;

  const participantsPage({super.key, required this.event});

  @override
  State<participantsPage> createState() => _participantsPageState();
}

class _participantsPageState extends State<participantsPage> {
  bool isLoading = false;
  bool isContentLoading = false;
  String hasError = "";
  late Event event;
  List<Participant> participants = [];

  final storage = FlutterSecureStorage();
  String? userToken;

  @override
  void initState() {
    super.initState();

    event = widget.event;

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
      getParticipantsFunction(userToken);
    }
    setState(() {
      isLoading = false;
    });
  }

  //Carregar eventos usando token do usuário
  void getParticipantsFunction(String? userToken) async {
    setState(() {
      isContentLoading = true;
    });
    try {
      if (userToken != null) {
        var response = await getEventParticipants(userToken, event.id);
        if (response.statusCode == 200) {
          var data = json.decode(utf8.decode(response.bodyBytes));
          List<dynamic> participantList = data['participantes'];

          // Atualize a lista de participantes com os dados recebidos
          participants = participantList
              .map<Participant>(
                  (participantData) => Participant.fromJson(participantData))
              .toList();
        }
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isContentLoading = false;
    });
  }

  //Censurar e-mails
  String obscureEmail(String email) {
    if (email.length > 5) {
      String maskedEmail = email.substring(0, 1) +
          "*****" +
          email.substring(email.indexOf("@") - 1);
      return maskedEmail;
    }
    return email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        userToken == null && !isLoading
            ? Text("Usuário não autenticado. Necessário login.")
            : isLoading
                ? Text("Loading...")
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: double.maxFinite,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Lista de participantes",
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
                                          height: 15,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(16),
                                          child: Text(
                                            "Participantes atuais",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 16),
                                          ),
                                        ),
                                        participants.isEmpty &&
                                                !isLoading &&
                                                !isContentLoading
                                            ? Padding(
                                                padding: EdgeInsets.all(16),
                                                child: Center(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "Nenhum participante ainda. Que tal fazer parte dessa iniciativa?",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    179,
                                                                    25,
                                                                    93,
                                                                    27),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Container(
                                                        height: 200,
                                                        width: 200,
                                                        child: Image.asset(
                                                            'assets/images/ct-panda.png'),
                                                      )
                                                    ],
                                                  ),
                                                ))
                                            : Column(
                                                children: participants
                                                    .map((participant) {
                                                  return Container(
                                                    child: ListTile(
                                                      leading: CircleAvatar(
                                                        backgroundImage: AssetImage(
                                                            "assets/images/becris-user.png"),
                                                      ),
                                                      title: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              participant.nome,
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      subtitle: Text(
                                                          obscureEmail(
                                                              participant
                                                                  .email)),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                        SizedBox(
                                          height: 15,
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
                  ),
      ],
    ));
  }
}
