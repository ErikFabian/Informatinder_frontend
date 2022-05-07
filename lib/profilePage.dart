import 'package:flutter/material.dart';

class profilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text("InformaTinder")),
        body: SingleChildScrollView(
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
                      padding:
                          const EdgeInsets.only(top: 32, left: 32, right: 32),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: const Text(
                                    '*Name*',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: TextFormField(
                        enabled: false,
                        maxLines: null,
                        style: const TextStyle(fontSize: 14),
                        initialValue: "profileText",
                      ),
                    )
                  ],
                ))));
  }
}
