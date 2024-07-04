import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/categorise/RecentlyAddedItems.dart';
import 'package:frontend/categorise/appbar_page.dart';
import 'package:frontend/ipaddress.dart';
import 'package:frontend/settingpage/theme/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Otherspage extends StatefulWidget {
  final int index;
  final int registerid;
  const Otherspage(
      {super.key, required this.index, required this.registerid});

  @override
  State<Otherspage> createState() => _Otherspage();
}

class _Otherspage extends State<Otherspage> {
  List<Map> Others = [];
  late final PageController pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    fetchDataFromAPI(widget.registerid); // Call the method to fetch data
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }



  Future<void> fetchDataFromAPI(int registerId) async {
    final ipAddress = await getLocalIPv4Address();
    final response = await http
        .get(Uri.parse('http://$ipAddress:3000/otherposts'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        Others = data.map((item) {
          return {
            "_id": item["_id"],
            "image": item["image"],
            "registerID": item["registerID"],
          };
        }).toList();
      });
    } else {
      throw Exception('Failed to load others  items');
    }
  }
//   Future<void> fetchDataFromAPI(int registerId) async {
//     final ipAddress = await getLocalIPv4Address();
//     final response = await http
//         .get(Uri.parse('http://$ipAddress:3000/otherposts'));
//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body);
//       setState(() {
//        Others = (jsonDecode(response.body) as List<dynamic>).cast<Map<dynamic, dynamic>>();
// print(Others);
//       });
//     } else {
//       throw Exception('Failed to load Others ');
//     }
//   }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: appBarPage(slidepage: false),
      ),
      backgroundColor: themeProvider.isDarkMode
          ? const Color.fromARGB(255, 25, 25, 25)
          : const Color(0xFFffffff).withOpacity(0.93),
      body: RecentlyaddedItems(array: Others, indexx: widget.index),
    );
  }
}
