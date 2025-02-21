import 'package:flutter/material.dart';

class VerticalCardView extends StatefulWidget {
  const VerticalCardView({super.key});

  @override
  State<VerticalCardView> createState() => _VerticalCardViewState();
}

class _VerticalCardViewState extends State<VerticalCardView> {
  List<Map<String, String>> items = [
    {"title": "Card 1", "subtitle": "This is card 1"},
    {"title": "Card 2", "subtitle": "This is card 2"},
    {"title": "Card 3", "subtitle": "This is card 3"},
    {"title": "Card 4", "subtitle": "This is card 4"},
    {"title": "Card 5", "subtitle": "This is card 5"},
  ];

  void addCard() {
    setState(() {
      items.add({
        "title": "Card ${items.length + 1}",
        "subtitle": "This is card ${items.length + 1}"
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 2,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: ListTile(
                title: Text(items[index]["title"]!),
                subtitle: Text(items[index]["subtitle"]!),
              ),
            ),
          );
        },
      ),
    );
  }
}
