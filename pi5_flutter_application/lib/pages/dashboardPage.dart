import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class dashboardPage extends StatefulWidget {
  const dashboardPage({super.key});

  @override
  State<dashboardPage> createState() => _dashboardPageState();
}

class _dashboardPageState extends State<dashboardPage> {
  //Controle de chips de filtro
  bool _isChipSelected = false;
  bool _isChip2Selected = false;
  bool _isChip3Selected = false;
  bool _isChip4Selected = false;
  bool _isChip5Selected = false;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Olá,",
                        style: TextStyle(color: Colors.black, fontSize: 28),
                      ),
                      Text("[Placeholder]",
                          style: TextStyle(color: Colors.black, fontSize: 28))
                    ],
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/cd-boyicon.jpg"))),
                )
              ],
            ),
            SizedBox(
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
                  child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset("assets/images/ct-papers.jpg",
                            fit: BoxFit.cover, width: 100, height: 100),
                      ),
                      title: Text(
                        "Inscrições",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Ver suas inscrições em eventos",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal))),
                ),
              ),
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
                  child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset("assets/images/ct-mobphone.jpg",
                            fit: BoxFit.cover, width: 100, height: 100),
                      ),
                      title: Text(
                        "Materiais",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Ver materiais sobre preservação",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal))),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Últimos eventos",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10)),
                child: Wrap(
                  spacing: 8,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.filter,
                      color: Color(0xff606c38),
                    ),
                    GestureDetector(
                      onTap: () {
                        //To do filtering
                        setState(() {
                          _isChipSelected = !_isChipSelected;
                        });
                      },
                      child: Chip(
                        label: Text("Filtro 1"),
                        backgroundColor:
                            _isChipSelected ? Color(0xffd9d9d9) : Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //To do filtering
                        setState(() {
                          _isChip2Selected = !_isChip2Selected;
                        });
                      },
                      child: Chip(
                        label: Text("Filtro 2"),
                        backgroundColor:
                            _isChip2Selected ? Color(0xffd9d9d9) : Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //To do filtering
                        setState(() {
                          _isChip3Selected = !_isChip3Selected;
                        });
                      },
                      child: Chip(
                        label: Text("Filtro 3"),
                        backgroundColor:
                            _isChip3Selected ? Color(0xffd9d9d9) : Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //To do filtering
                        setState(() {
                          _isChip4Selected = !_isChip3Selected;
                        });
                      },
                      child: Chip(
                        label: Text("Filtro 4"),
                        backgroundColor:
                            _isChip4Selected ? Color(0xffd9d9d9) : Colors.white,
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
                      //To do push
                    },
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/becris-user.png"),
                              radius: 20.0,
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _truncatedTitleText,
                                      style: TextStyle(
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
            )
          ],
        ),
      ),
    );
  }
}
