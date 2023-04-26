import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class eventDetailPage extends StatefulWidget {
  const eventDetailPage({super.key});

  @override
  State<eventDetailPage> createState() => _eventDetailPageState();
}

class _eventDetailPageState extends State<eventDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
      ),
    );
  }
}
