import 'package:flutter/material.dart';
import 'package:pi5_flutter_application/pages/dashboardPage.dart';

class introPage extends StatefulWidget {
  const introPage({super.key});

  @override
  State<introPage> createState() => _introPageState();
}

class _introPageState extends State<introPage> {
  //Mudar imagem e descrição conforme clique do usuário
  //Na última etapa do tutorial, levar para a página do app

  String _title = "Descubra eventos parceiros";
  String _description =
      "Encontre eventos que estão acontecendo agora no app e participe dos que mais gostar.";
  String _imageAsset = "assets/images/ct-mapwphone.jpg";
  int _clickCounter = 0;
  bool _showFinalButton = false;

  void changeCardAssets() {
    setState(() {
      _clickCounter++;

      switch (_clickCounter) {
        case 1:
          _title = "Conecte-se";
          _description =
              "Ao participar dos eventos, você poderá conhecer pessoas que compartilham do mesmo interesse pela causa ambiental.";
          _imageAsset = "assets/images/ct-hearts.jpg";
          break;
        case 2:
          _title = "Crie seus próprios eventos";
          _description =
              "No app, você pode crair seus eventos e levantar causas que julga importante e fazer a diferença.";
          _imageAsset = "assets/images/ct-project.jpg";
          break;
        case 3:
          _title = "Encontre materiais didáticos";
          _description =
              "Você pode acessar materiais e recursos valiosos sobre a causa ambiental, promovendo a conscientização!";
          _imageAsset = "assets/images/ct-papers.jpg";
          _showFinalButton = true;
          break;
        case 4:
          pushNewPage();
      }
    });
  }

  void pushNewPage() {
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (BuildContext context) {
    //   const loginPage();
    // }));

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const dashboardPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 600),
          child: Column(
            key: ValueKey<int>(_clickCounter),
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 8, left: 8, top: 8, bottom: 0),
                      child: Text(
                        "Olá!",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w600,
                            fontSize: 32),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, bottom: 4, top: 0),
                      child: Text("Conheça os benefícios do app",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w600,
                              fontSize: 24)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                              color: Color(0xff283618),
                              width: 0.5,
                            )),
                        child: Column(
                          children: [
                            Image.asset(
                              _imageAsset,
                              fit: BoxFit.fitWidth,
                            ),
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _title,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    _description,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if (!_showFinalButton)
                                        ElevatedButton(
                                          onPressed: () {
                                            changeCardAssets();
                                          },
                                          child: Text(
                                            "Próximo",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xff606c38)),
                                        ),
                                      if (_showFinalButton)
                                        ElevatedButton(
                                          onPressed: changeCardAssets,
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xff283618),
                                          ),
                                          child: Text(
                                            'Começar!',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                        ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
