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
          'Quem são os coletores que protegem o Cerrado brasileiro de desaparecer?',
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
        final url = Uri.parse(link['url']!);
        final imagePath = imagePaths[index % imagePaths.length];

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  if (await canLaunchUrl(Uri.parse(link['url']!))) {
                    await launchUrl(Uri.parse(link['url']!));
                  } else {
                    throw 'Could not launch $link';
                  }
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      side: BorderSide(color: Colors.grey, width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      link['title']!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  imagePath,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Image.asset(
            'assets/images/ct-papers.jpg',
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: const Text(
                  "Materiais",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 26),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: const Text(
                  "Fique atualizado sobre notícias do meio ambiente semanalmente",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
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
        ],
      ),
    );
  }
}
