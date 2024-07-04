import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'CustomReserveNotfication.dart';
import 'CustomResultNotification.dart';
import 'appBarNotification.dart';

class NotificationMain extends StatefulWidget {
  const NotificationMain({
    Key? key,
    required this.reservedArray,
    required this.resultReservedArray,
    required this.title,
    required this.fromUserprofiel,
  }) : super(key: key);
  final List<Map<String, dynamic>> reservedArray;
  final List<Map<String, dynamic>> resultReservedArray;
  final String title;
  final bool fromUserprofiel;

  @override
  State<NotificationMain> createState() => _NotificationMainState();
}

class _NotificationMainState extends State<NotificationMain> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeProvider.isDarkMode ? Colors.black12 : const Color(0xFFffffff),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: appBarNotification(
            title: widget.title,
            fromUserprofiel: widget.fromUserprofiel,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Notification: User checking for appointment
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Icon(Icons.chat_bubble),
                    const SizedBox(width: 10),
                    Text("User is checking for an appointment"),
                  ],
                ),
              ),
              // Second Notification: Likes on picture
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Icon(Icons.favorite),
                    const SizedBox(width: 10),
                    Text("4 likes on your picture other1.jpg"),
                  ],
                ),
              ),
              // Third Notification: Weather forecast
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Icon(Icons.cloud),
                    const SizedBox(width: 10),
                    Text("Fantastic weather tomorrow in Nablus at 3:00 PM"),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: max(widget.reservedArray.length, widget.resultReservedArray.length),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        if (index < widget.reservedArray.length) ...[
                          CustomReserveNotfication(
                            useriamge: widget.reservedArray[index]['profileimage'],
                            fName: widget.reservedArray[index]['fname'],
                            lName: widget.reservedArray[index]['lname'],
                            itemTitle: widget.reservedArray[index]['title'],
                            itemId: widget.reservedArray[index]['iditem'].toString(),
                            itemRequester: widget.reservedArray[index]['itemRequester'].toString(),
                            onDecisionMade: (itemId, itemRequester) {
                              setState(() {
                                widget.reservedArray.removeWhere((item) =>
                                    item['iditem'].toString() == itemId &&
                                    item['itemRequester'].toString() == itemRequester);
                              });
                            },
                            themeProvider: themeProvider,
                          ),
                          const SizedBox(height: 5),
                          const Divider(),
                          const SizedBox(height: 10),
                        ],
                        if (index < widget.resultReservedArray.length) ...[
                          CustomResultNotification(
                            useriamge: widget.resultReservedArray[index]['profileimage'],
                            fName: widget.resultReservedArray[index]['fname'],
                            lName: widget.resultReservedArray[index]['lname'],
                            itemTitle: widget.resultReservedArray[index]['title'],
                            itemId: widget.resultReservedArray[index]['iditem'].toString(),
                            itemOwner: widget.resultReservedArray[index]['itemOwner'].toString(),
                            desicion: widget.resultReservedArray[index]['decision'].toString(),
                            themeProvider: themeProvider,
                            price: widget.resultReservedArray[index]['price'].toString(),
                          ),
                          const SizedBox(height: 5),
                          const Divider(),
                          const SizedBox(height: 10),
                        ],
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
