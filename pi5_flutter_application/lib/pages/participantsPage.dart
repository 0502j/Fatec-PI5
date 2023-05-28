import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pi5_flutter_application/pages/confirmPage.dart';

class participantsPage extends StatefulWidget {
  const participantsPage({super.key});

  @override
  State<participantsPage> createState() => _participantsPageState();
}

class _participantsPageState extends State<participantsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        SizedBox(
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.all(8),
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
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/gabriel-jimenez-unsplash.jpg"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                )),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 0, bottom: 0, right: 16, left: 16),
                                child: Text(
                                  "Criador do evento",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: ListTile(
                                  leading: const CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/images/becris-user.png"),
                                  ),
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: const Text(
                                          "Nome do criador",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  "Participantes",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    child: ListTile(
                                      leading: const CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/becris-user.png"),
                                      ),
                                      title: Row(
                                        children: [
                                          Expanded(
                                            child: const Text(
                                              "Nome do participante",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const confirmPage()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: const Color(0xff606c38),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                      child: const Text(
                                        "Inscrever-se",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
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
