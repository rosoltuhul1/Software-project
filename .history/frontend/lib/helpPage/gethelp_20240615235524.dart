import 'package:flutter/material.dart';
//import 'package:kommunicate_flutter/kommunicate_flutter.dart';

class gethelp extends StatefulWidget {
  const gethelp({super.key});

  @override
  State<gethelp> createState() => _gethelpState();
}

class _gethelpState extends State<gethelp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //initializeData();
  }

  // Future<void> initializeData() async {
  //   try {
  //     dynamic conversationObject = {
  //       'appId': '3751698d9f319acb7be63314811021de4'
  //     };
  //     dynamic result =
  //         await KommunicateFlutterPlugin.buildConversation(conversationObject);
  //     print("Conversation builder success : " + result.toString());
  //   } on Exception catch (e) {
  //     print("Conversation builder error occurred : " + e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Column(
        children: [
          IconButton(
              onPressed: () async {
                try {
                  dynamic conversationObject = {
                    'appId': '3751698d9f319acb7be63314811021de4'
                  };
                  dynamic result =
                     // await KommunicateFlutterPlugin.buildConversation(
                          conversationObject);
                  print("Conversation builder success : $result");
                } on Exception catch (e) {
                  print(
                      "Conversation builder error occurred : $e");
                }
              },
              icon: const Icon(Icons.add))
        ],
      ),
    );
  }
}
