// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pi5_flutter_application/pages/eventDetailPage.dart';
import 'package:pi5_flutter_application/pages/eventManagementPage.dart';
import 'package:pi5_flutter_application/pages/resourcesPage.dart';
import 'package:pi5_flutter_application/pages/userEventsPage.dart';

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

  //Cortar o texto com base no comprimento cadastrado
  late String _truncatedDescriptionText;
  late String _descriptionText;
  late String _truncatedTitleText;
  late String _titleText;

  @override
  void initState() {
    _titleText = "Este é um título modelo que será substituído";

    _descriptionText =
        "Este é um texto modelo que será substituído conforme cadastro de eventos";

    if (_descriptionText.length > 25) {
      _truncatedDescriptionText = "${_descriptionText.substring(0, 25)}...";
    } else {
      _truncatedDescriptionText = _descriptionText;
    }

    if (_titleText.length > 25) {
      _truncatedTitleText = "${_descriptionText.substring(0, 25)}...";
    } else {
      _truncatedTitleText = _titleText;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: ListView(
            children: [
              Column(
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 26),
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
                  InkWell(
                    onTap: () {
                      //To do push
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(8)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const eventManagementPage()));
                          },
                          child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                    "assets/images/ct-papers.jpg",
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100),
                              ),
                              title: const Text(
                                "Criar evento",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: const Text("Crie seu próprio evento",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal))),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const resourcesPage()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const eventDetailPage()));
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/images/becris-user.png"),
                                    radius: 20.0,
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _truncatedTitleText,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          Text(_truncatedDescriptionText),
                                        ],
                                      ),
                                      Expanded(
                                          child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          "assets/images/pawel-unsplash.jpg",
                                          height: 80,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ))
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const eventDetailPage()));
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/images/becris-user.png"),
                                    radius: 20.0,
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _truncatedTitleText,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          Text(_truncatedDescriptionText),
                                        ],
                                      ),
                                      Expanded(
                                          child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          "assets/images/evan-brockett-unsplash.jpg",
                                          height: 80,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ))
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const eventDetailPage()));
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/images/becris-user.png"),
                                    radius: 20.0,
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _truncatedTitleText,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          Text(_truncatedDescriptionText),
                                        ],
                                      ),
                                      Expanded(
                                          child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          "assets/images/matthew-smith-unsplash.jpg",
                                          height: 80,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ))
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          )),
    );
  }
}
