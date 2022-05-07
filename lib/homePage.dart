import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);
  homePageState createState() => homePageState();
}

class homePageState extends State<homePage> {
  static const String routeName = "/matchesPage";
  bool editable = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                Image.asset(
                  'images/teacher_female.png',
                  width: 600,
                  height: 300,
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
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: () {
                          setState(() {
                            editable = !editable;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: TextFormField(
                    enabled: editable,
                    maxLines: null,
                    style: const TextStyle(fontSize: 14),
                    initialValue:
                        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna ut labore et dolore magna  At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut',
                  ),
                )
              ],
            )));
  }
}
