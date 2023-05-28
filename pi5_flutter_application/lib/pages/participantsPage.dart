import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class participantsPage extends StatefulWidget {
  const participantsPage({super.key});

  @override
  State<participantsPage> createState() => _participantsPageState();
}

class _participantsPageState extends State<participantsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Lista de participantes"),
    );
  }
}
