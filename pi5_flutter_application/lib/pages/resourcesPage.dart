import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class resourcesPage extends StatefulWidget {
  const resourcesPage({Key? key}) : super(key: key);

  @override
  State<resourcesPage> createState() => _resourcesPageState();
}

class _resourcesPageState extends State<resourcesPage> {
  List<String> imagePaths = [
    'assets/images/Matthieu-Paley-NationalGeographic.webp',
    'assets/images/Renan-Ozturk-NationalGeographic.webp',
    'assets/images/Cerrado-de-Pe-NationalGeographic.webp',
    'assets/images/Paul-Nicklen-NationalGeographic.webp',
    'assets/images/Tamara-Merino-NationalGeographic.webp',
  ];

  final List<Map<String, String>> links = [
    {
      'title': 'Como a poluição do ar está ligada ao câncer de pulmão',
      'url':
          'https://www.nationalgeographicbrasil.com/meio-ambiente/2022/11/como-a-poluicao-do-ar-esta-ligada-ao-cancer-de-pulmao'
    },
    {
      'title': 'Qual a importância dos fungos para o planeta Terra?',
      'url':
          'https://www.nationalgeographicbrasil.com/meio-ambiente/2023/04/qual-a-importancia-dos-fungos-para-o-planeta-terra'
    },
    {
      'title':
          'Quem são os coletores de sementes e grama que protegem o Cerrado brasileiro de desaparecer?',
      'url':
          'https://www.nationalgeographicbrasil.com/meio-ambiente/2023/04/dia-da-terra-quem-sao-os-coletores-de-sementes-e-grama-que-protegem-o-cerrado-brasileiro-de-desaparecer'
    },
    {
      'title': 'Vida marinha ameaçada: gelo ártico fica cada dia mais fino',
      'url':
          'https://www.nationalgeographicbrasil.com/meio-ambiente/2023/03/vida-marinha-ameacada-gelo-artico-fica-cada-dia-mais-fino'
    },
    {
      'title':
          'Atacama: como o majestoso deserto virou um local de descarte de roupas',
      'url':
          'https://www.nationalgeographicbrasil.com/meio-ambiente/2023/04/atacama-como-o-majestoso-deserto-virou-um-local-de-descarte-de-roupas'
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> listTiles = List.generate(
      links.length,
      (index) {
        final link = links[index];
        final imagePath = imagePaths[index % imagePaths.length];

        return Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  tileColor: Color.fromARGB(255, 243, 243, 243),
                  leading: AspectRatio(
                    aspectRatio: 1.2,
                    child: Image.asset(imagePath),
                  ),
                  title: Text(link['title']!),
                  onTap: () async {
                    if (await canLaunch(link['url']!)) {
                      await launch(link['url']!);
                    } else {
                      throw 'Could not launch ${link['url']}';
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );

    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: ListView(
          children: [
            Container(
              height: 150, // altura definida
              width: double.infinity,
              child: Image.asset(
                'assets/images/ct-papers.jpg',
                fit: BoxFit.cover,
              ),
            ),
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
                    children: listTiles,
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
