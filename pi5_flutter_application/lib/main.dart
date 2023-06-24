import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:pi5_flutter_application/pages/indexPage.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PI5',
        theme: ThemeData(
            scaffoldBackgroundColor: Color(0xfffef7ff),
            fontFamily: "Roboto",
            brightness: Brightness.light,
            useMaterial3: true,
            colorSchemeSeed: Colors.green),
        home: IndexPage());
  }
}
