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
  bool _isChipSelected = false;
  bool _isChip2Selected = false;
  bool _isChip3Selected = false;
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
                padding: EdgeInsets.all(8),
                child: Column(
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
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/images/cd-boyicon.jpg"))),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10)),
                      child: Wrap(
                        spacing: 8,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: FaIcon(
                              FontAwesomeIcons.filter,
                              color: Color(0xff606c38),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              //To do filtering
                              setState(() {
                                _isChipSelected = !_isChipSelected;
                              });
                            },
                            child: Chip(
                              label: Text("Criados por você"),
                              backgroundColor: _isChipSelected
                                  ? Color(0xffd9d9d9)
                                  : Colors.white,
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
                              label: Text("Outros eventos"),
                              backgroundColor: _isChip2Selected
                                  ? Color(0xffd9d9d9)
                                  : Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: _isSelected
                                          ? Color(0xffededee)
                                          : Color.fromARGB(255, 172, 188, 122),
                                      border: Border.all(
                                          color: Colors.grey, width: 1)),
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        _isSelected = !_isSelected;
                                      });
                                    },
                                    leading: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/becris-user.png"),
                                    ),
                                    title: Text("Título do card"),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                    child: Wrap(
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
                                              primary: Color(0xffc62525),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            ),
                                            child: Text(
                                              "Deletar selecionado",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
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
                                              primary: Color(0xffc62525),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            ),
                                            child: Text(
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
