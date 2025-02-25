import 'package:flutter/material.dart';

class RoadmapsPage extends StatefulWidget {
  const RoadmapsPage({super.key});

  @override
  State<RoadmapsPage> createState() => _RoadmapsPageState();
}

class _RoadmapsPageState extends State<RoadmapsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RoadMaps"),
      ),
    );
  }
}
