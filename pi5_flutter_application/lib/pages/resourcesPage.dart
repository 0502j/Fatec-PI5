import 'package:flutter/material.dart';

class resourcesPage extends StatefulWidget {
  const resourcesPage({super.key});

  @override
  State<resourcesPage> createState() => _resourcesPageState();
}

class _resourcesPageState extends State<resourcesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Materiais",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 26),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffededee),
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: ListTile(
                          onTap: () {
                            //To do
                          },
                          leading: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                  "assets/images/jas-min-unsplash.jpg"),
                            ),
                          ),
                          title: const Text("Título do card"),
                          subtitle: const Text("Subtítulo do card"),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
