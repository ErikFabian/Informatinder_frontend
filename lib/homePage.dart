import 'package:flutter/material.dart';

class homePage extends StatelessWidget {
  static const String routeName = "/matchesPage";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'images/example.png',
          width: 600,
          height: 240,
          fit: BoxFit.cover,
        ),
        Container(
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
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
              /*3*/
              const Icon(
                Icons.edit_outlined,
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(32),
          child: Text(
            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna ut labore et dolore magna  At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut',
            softWrap: true,
          ),
        )
      ],
    );
  }
}
