import 'package:flutter/material.dart';

class matchingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int sensitivity = 8;

    Widget titleSection = Container(
      padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    '*Name*',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Text(
                  'Betrieb/Bewerber',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Widget textSection = Padding(
      padding: const EdgeInsets.all(32),
      child: TextFormField(
        enabled: false,
        maxLines: null,
        style: const TextStyle(fontSize: 14),
        initialValue: "profileText",
      ),
    );

    return GestureDetector(
        child: Column(children: [
          Image.asset(
            'images/teacher_male.png',
            width: 600,
            height: 300,
            fit: BoxFit.cover,
          ),
          titleSection,
          textSection,
        ]),
        behavior: HitTestBehavior.translucent,
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > sensitivity) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Right Swipe"),
            ));
          } else if (details.delta.dx < -sensitivity) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Left Swipe"),
            ));
          }
        });
  }
}
