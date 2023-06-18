// ignore_for_file: camel_case_types
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pi5_flutter_application/pages/eventDetailPage.dart';
import 'package:pi5_flutter_application/pages/eventManagementPage.dart';
import 'package:pi5_flutter_application/pages/resourcesPage.dart';
import 'package:pi5_flutter_application/pages/userEventsPage.dart';
import 'package:pi5_flutter_application/services/api_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Event {
  int id;
  String nome;
  String data;
  String hora;
  String descricao;
  String tipo;
  String? image;
  String local;

  Event(
      {required this.id,
      required this.nome,
      required this.data,
      required this.hora,
      required this.descricao,
      required this.tipo,
      required this.local,
      this.image});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] ?? 0,
      nome: json['titulo'] ?? '',
      descricao: json['descricao'] ?? '',
      data: json['data'] ?? '',
      hora: json['hora'] ?? '',
      image: json['image'],
      tipo: json['tipo'] ?? '',
      local: json['local'] ?? '',
    );
  }
}

class dashboardPage extends StatefulWidget {
  const dashboardPage({super.key});

  @override
  State<dashboardPage> createState() => _dashboardPageState();
}

class _dashboardPageState extends State<dashboardPage> {
  //Lógica de seleção de chips
  List<bool> _isChipSelected = [false, false, false, false, false];

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

  bool isLoading = false;
  bool isContentLoading = false;

  final storage = FlutterSecureStorage();
  String? userToken;

  @override
  void initState() {
    super.initState();

    loadToken();

    print("Token atual: $userToken");
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
    print("Token atual: $token");
    getEventsFunction(userToken);
    setState(() {
      isLoading = false;
    });
  }

  List<Event> events = [];

  //Carregar eventos usando token do usuário
  void getEventsFunction(String? userToken) async {
    setState(() {
      isContentLoading = true;
    });
    try {
      if (userToken != null) {
        var response = await getEvents(userToken);
        if (response.statusCode == 200) {
          var data = json.decode(utf8.decode(response.bodyBytes));
          List<dynamic> eventList = data['content'];
          events = eventList
              .map<Event>((eventData) => Event.fromJson(eventData))
              .toList();
        }
        print(response);
        print(response.body);
        print(response.statusCode);
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
      body: ListView(
        children: [
          userToken == null
              ? Text("Usuário não autenticado, necessário login.")
              : isLoading
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
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Olá,",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 26),
                                  ),
                                  const Text("[Placeholder]",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 22))
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const userEventsPage()));
                              },
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            "assets/images/cd-boyicon.jpg"))),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const eventManagementPage(
                                              isUpdating: false,
                                            )));
                              },
                              child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      "assets/images/ct-papers.jpg",
                                      fit: BoxFit.cover,
                                      width: 100,
                                    ),
                                  ),
                                  title: const Text(
                                    "Criar evento",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: const Text(
                                      "Crie seu próprio evento",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal))),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const resourcesPage()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                        "assets/images/ct-mobphone.jpg",
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100),
                                  ),
                                  title: const Text(
                                    "Materiais",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: const Text(
                                      "Ver materiais sobre preservação",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Últimos eventos",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10)),
                            child: Wrap(
                              spacing: 8,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.filter,
                                  color: Color(0xff606c38),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //To do filtering
                                    selectChip(0);
                                  },
                                  onDoubleTap: () {
                                    setState(() {
                                      unselectChip(0);
                                    });
                                  },
                                  child: Chip(
                                    label: const Text("Filtro 1"),
                                    backgroundColor: _isChipSelected[0]
                                        ? const Color(0xffd9d9d9)
                                        : Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //To do filtering
                                    setState(() {
                                      selectChip(1);
                                    });
                                  },
                                  onDoubleTap: () {
                                    setState(() {
                                      unselectChip(1);
                                    });
                                  },
                                  child: Chip(
                                    label: const Text("Filtro 2"),
                                    backgroundColor: _isChipSelected[1]
                                        ? const Color(0xffd9d9d9)
                                        : Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //To do filtering
                                    selectChip(2);
                                  },
                                  onDoubleTap: () {
                                    setState(() {
                                      unselectChip(2);
                                    });
                                  },
                                  child: Chip(
                                    label: const Text("Filtro 3"),
                                    backgroundColor: _isChipSelected[2]
                                        ? const Color(0xffd9d9d9)
                                        : Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //To do filtering
                                    selectChip(3);
                                  },
                                  onDoubleTap: () {
                                    setState(() {
                                      unselectChip(3);
                                    });
                                  },
                                  child: Chip(
                                    label: const Text("Filtro 4"),
                                    backgroundColor: _isChipSelected[3]
                                        ? const Color(0xffd9d9d9)
                                        : Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        // Column(
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: GestureDetector(
                        //         onTap: () {
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) =>
                        //                       const eventDetailPage()));
                        //         },
                        //         child: Card(
                        //           shape: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(6.0),
                        //               side: BorderSide(
                        //                   color: Colors.grey, width: 1)),
                        //           child: Padding(
                        //             padding: const EdgeInsets.all(8),
                        //             child: Row(
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.center,
                        //               children: [
                        //                 isContentLoading
                        //                     ? const CircleAvatar(
                        //                         backgroundImage: AssetImage(
                        //                             "assets/images/becris-user.png"),
                        //                         radius: 20.0,
                        //                       )
                        //                     : const CircleAvatar(
                        //                         backgroundImage: AssetImage(
                        //                             "assets/images/becris-user.png"),
                        //                         radius: 20.0,
                        //                       ),
                        //                 const SizedBox(width: 16.0),
                        //                 Expanded(
                        //                   child: Row(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.spaceBetween,
                        //                     children: [
                        //                       Flexible(
                        //                         fit: FlexFit.loose,
                        //                         child: Column(
                        //                           mainAxisAlignment:
                        //                               MainAxisAlignment.start,
                        //                           crossAxisAlignment:
                        //                               CrossAxisAlignment.start,
                        //                           children: [
                        //                             isContentLoading
                        //                                 ? Text("")
                        //                                 : Text(
                        //                                     _truncatedTitleText,
                        //                                     style:
                        //                                         const TextStyle(
                        //                                       fontSize: 16,
                        //                                       fontWeight:
                        //                                           FontWeight
                        //                                               .w600,
                        //                                       color:
                        //                                           Colors.black,
                        //                                     ),
                        //                                   ),
                        //                             isContentLoading
                        //                                 ? Text("")
                        //                                 : Text(
                        //                                     _truncatedDescriptionText),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                       const SizedBox(width: 16.0),
                        //                       ClipRRect(
                        //                         borderRadius:
                        //                             BorderRadius.circular(8),
                        //                         child: isContentLoading
                        //                             ? SpinKitPulse(
                        //                                 color: const Color(
                        //                                     0xff606c38),
                        //                                 size: 50.0,
                        //                               )
                        //                             : ProgressiveImageWidget(
                        //                                 imgPath:
                        //                                     'assets/images/pawel-unsplash.jpg',
                        //                                 isOval: false,
                        //                                 heightValue: 80,
                        //                                 widthValue: 100,
                        //                               ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
          isContentLoading
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
              : events.isEmpty && userToken != null
                  ? Padding(
                      padding: EdgeInsets.all(8),
                      child: Text("Sem eventos ainda. Comece criando um!"),
                    )
                  : Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: events.map((event) {
                          final nome = event.nome;
                          final descricao = event.descricao;
                          final data = event.data;
                          final hora = event.hora;
                          final tipo = event.tipo;
                          final imagem = event.image;

                          var cvTipo = event.tipo.toString();
                          var tipoReplaced = cvTipo.replaceAll('_', ' ');
                          var tipoLower = tipoReplaced.toLowerCase();

                          print(tipoLower);

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          eventDetailPage(event: event)));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                side: BorderSide(color: Colors.grey, width: 1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            nome,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text("Categoria: $tipoLower"),
                                          Text("Data: $data"),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: isContentLoading
                                            ? SpinKitPulse(
                                                color: const Color(0xff606c38),
                                                size: 50.0,
                                              )
                                            : imagem == null
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
                                                            RegExp(r'\s+'),
                                                            '')),
                                                    fit: BoxFit.cover,
                                                    height: 80,
                                                    width: 100,
                                                  )),
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
    );
  }
}
