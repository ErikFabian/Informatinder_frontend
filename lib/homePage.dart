import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);
  homePageState createState() => homePageState();
}

class homePageState extends State<homePage> {
  static const String routeName = "/matchesPage";

  final TextEditingController _profileTextController =
      TextEditingController(text: "Test");
  //TODO: Hier Text aus der DB holen und in profileText abspeichern

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
                          if (editable) {
                            //TODO: Hier Text absenden der in der _profileTextController.text steht
                          }
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
                    controller: _profileTextController,
                    enabled: editable,
                    maxLines: null,
                    style: const TextStyle(fontSize: 14),
                  ),
                )
              ],
            )));
  }
}
