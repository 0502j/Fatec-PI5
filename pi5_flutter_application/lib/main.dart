import 'package:flutter/services.dart';
import 'package:pi5_flutter_application/pages/confirmPage.dart';
import 'package:pi5_flutter_application/pages/dashboardPage.dart';
import 'package:pi5_flutter_application/pages/eventDetailPage.dart';
import 'package:pi5_flutter_application/pages/indexPage.dart';
import 'package:flutter/material.dart';
import 'package:pi5_flutter_application/pages/introPage.dart';
import 'package:pi5_flutter_application/pages/resourcesPage.dart';
import 'package:pi5_flutter_application/pages/signUpPage.dart';
import 'package:pi5_flutter_application/pages/userEventsPage.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PI5',
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xfffef7ff),
          fontFamily: "Roboto",
          brightness: Brightness.light,
          useMaterial3: true,
          colorSchemeSeed: Colors.green),
      home: const dashboardPage(),
    );
  }
}
