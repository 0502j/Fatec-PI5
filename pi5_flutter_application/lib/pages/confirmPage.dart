import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pi5_flutter_application/pages/userEventsPage.dart';

class confirmPage extends StatefulWidget {
  const confirmPage({super.key});

  @override
  State<confirmPage> createState() => _confirmPageState();
}

class _confirmPageState extends State<confirmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              FaIcon(
                FontAwesomeIcons.checkCircle,
                color: Color(0xff606c38),
                size: 40,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Inscrição feita com sucesso!",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const userEventsPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff606c38),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: Text(
                      "Ver seus eventos",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
