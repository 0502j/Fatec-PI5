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

  void unselectAllChips() {
    setState(() {
      for (int i = 0; i < _isChipSelected.length; i++) {
        _isChipSelected[i] = false;
      }
    });
  }

  bool isLoading = false;
  bool isContentLoading = false;

  final storage = FlutterSecureStorage();
  String? userToken;
  String? userImage;
  String? username;

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
    getEventsFunction(userToken);
    loadUserInfo();
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
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isContentLoading = false;
    });
  }

  void getEventsByTypeFunction(String? userToken, String type) async {
    setState(() {
      isContentLoading = true;
    });

    try {
      if (userToken != null) {
        var response = await getEventByType(userToken, type);

        if (response.statusCode == 200) {
          var data = json.decode(utf8.decode(response.bodyBytes));
          List<dynamic> eventDataList = data as List<dynamic>;
          events = eventDataList
              .map<Event>((eventData) => Event.fromJson(eventData))
              .toList();
        }
      }
    } catch (e) {
      print("Erro do catch: $e");
    }

    setState(() {
      isContentLoading = false;
    });
  }

  //Carregar informações do usuário
  Future<void> loadUserInfo() async {
    setState(() {
      isLoading = true;
    });
    String? name = await storage.read(key: "name");
    String? image = await storage.read(key: "image");
    if (name != null) {
      setState(() {
        username = name;
      });
    } else {
      setState(() {
        username = "";
      });
    }
    if (image != null) {
      setState(() {
        userImage = image;
      });
    } else {
      setState(() {
        userImage = "";
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          userToken == null && !isLoading
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
                      children: [
                        Container(
                          height: 90, // altura definida
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/Header.png',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, left: 16, bottom: 0, right: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Olá,",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 24),
                                  ),
                                  username != null
                                      ? Text(username!,
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 18, 47, 30),
                                              fontSize: 20))
                                      : Text(""),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 16, left: 16, bottom: 0, right: 16),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const userEventsPage()));
                                  },
                                  child: userImage == null || userImage == ""
                                      ? Container(
                                          width: 50,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      "assets/images/becris-user.png"))),
                                        )
                                      : Image.memory(
                                          base64Decode(userImage!
                                              .replaceAll(RegExp(r'\s+'), '')),
                                          fit: BoxFit.cover,
                                          height: 80,
                                          width: 100,
                                        )),
                            ),
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
                          padding: EdgeInsets.only(
                              top: 16.0, bottom: 8, left: 16, right: 16),
                          child: Text(
                            "Últimos eventos",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, left: 16, right: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.filter,
                                    color: Color(0xff606c38),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      var type = "RECICLAGEM";
                                      selectChip(0);
                                      getEventsByTypeFunction(
                                          userToken, type.toString());
                                    },
                                    onDoubleTap: () {
                                      setState(() {
                                        unselectAllChips();
                                        getEventsFunction(userToken);
                                      });
                                    },
                                    child: Chip(
                                      label: const Text("Reciclagem"),
                                      backgroundColor: _isChipSelected[0]
                                          ? const Color(0xffd9d9d9)
                                          : Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectChip(1);
                                      });
                                      getEventsByTypeFunction(
                                          userToken, "LIMPEZA_DE_AMBIENTES");
                                    },
                                    onDoubleTap: () {
                                      setState(() {
                                        unselectAllChips();
                                        getEventsFunction(userToken);
                                      });
                                    },
                                    child: Chip(
                                      label: const Text("Limpeza de ambientes"),
                                      backgroundColor: _isChipSelected[1]
                                          ? const Color(0xffd9d9d9)
                                          : Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      selectChip(2);
                                      getEventsByTypeFunction(
                                          userToken, "REFLORESTAMENTO");
                                    },
                                    onDoubleTap: () {
                                      setState(() {
                                        unselectAllChips();
                                        getEventsFunction(userToken);
                                      });
                                    },
                                    child: Chip(
                                      label: const Text("Reflorestamento"),
                                      backgroundColor: _isChipSelected[2]
                                          ? const Color(0xffd9d9d9)
                                          : Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      selectChip(3);
                                      getEventsByTypeFunction(userToken,
                                          "CONSCIENTIZACAO_E_EDUCACAO");
                                    },
                                    onDoubleTap: () {
                                      setState(() {
                                        unselectAllChips();
                                        getEventsFunction(userToken);
                                      });
                                    },
                                    child: Chip(
                                      label: const Text("Conscientização"),
                                      backgroundColor: _isChipSelected[3]
                                          ? const Color(0xffd9d9d9)
                                          : Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      selectChip(4);
                                      getEventsByTypeFunction(
                                          userToken, "CONSERVACAO_DE_ESPECIES");
                                    },
                                    onDoubleTap: () {
                                      setState(() {
                                        unselectAllChips();
                                        getEventsFunction(userToken);
                                      });
                                    },
                                    child: Chip(
                                      label: const Text("Conservação"),
                                      backgroundColor: _isChipSelected[4]
                                          ? const Color(0xffd9d9d9)
                                          : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
              : events.isEmpty && userToken != null
                  ? Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Column(
                          children: [
                            const Text(
                              "Nenhum evento ainda. Que tal criar um agora mesmo?",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(179, 25, 93, 27),
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 80,
                              width: 80,
                              child:
                                  Image.asset('assets/images/freepik-wind.png'),
                            )
                          ],
                        ),
                      ))
                  : Padding(
                      padding: EdgeInsets.all(16),
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
                                    isContentLoading
                                        ? Container(
                                            width: 50,
                                            height: 50,
                                            child: Center(
                                              child: SpinKitPulse(
                                                color: const Color(0xff606c38),
                                                size: 50.0,
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: imagem == null
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
