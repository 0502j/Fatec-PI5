import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class userEventsPage extends StatefulWidget {
  const userEventsPage({super.key});

  @override
  State<userEventsPage> createState() => _userEventsPageState();
}

class _userEventsPageState extends State<userEventsPage> {
  //Lógica de seleção de chips
  List<bool> _isChipSelected = [false, false];

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

//Seleção de cards
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Seus eventos",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/images/cd-boyicon.jpg"))),
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
                          const Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: FaIcon(
                              FontAwesomeIcons.filter,
                              color: Color(0xff606c38),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              //To do filtering
                              selectChip(0);
                            },
                            child: Chip(
                              label: const Text("Criados por você"),
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
                            child: Chip(
                              label: const Text("Outros eventos"),
                              backgroundColor: _isChipSelected[1]
                                  ? const Color(0xffd9d9d9)
                                  : Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: _isSelected
                                          ? const Color.fromARGB(
                                              255, 172, 188, 122)
                                          : const Color(0xffededee),
                                      border: Border.all(
                                          color: Colors.grey, width: 1)),
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        _isSelected = !_isSelected;
                                      });
                                    },
                                    leading: const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/becris-user.png"),
                                    ),
                                    title: const Text("Título do card"),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Center(
                                    child: Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: [
                                        SizedBox(
                                          width: 300,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             const confirmPage()));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: const Color(0xffc62525),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            ),
                                            child: const Text(
                                              "Deletar selecionado",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 300,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             const confirmPage()));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: const Color(0xffc62525),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            ),
                                            child: const Text(
                                              "Deletar tudo",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
