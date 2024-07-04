import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screen/accountpage.dart';
import 'package:frontend/chatpage/chatpage.dart';
import 'package:frontend/favoritepage/favoritepage.dart';
import 'package:frontend/homepage/HomePage.dart';
import 'package:frontend/ipaddress.dart';
import 'package:frontend/registerID.dart';
import 'package:frontend/settingpage/theme/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class mainpage extends StatefulWidget {
  mainpage({Key? key, required this.page}) : super(key: key);
  int page;
  @override
  _mainpageState createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _page = widget.page;

    initializeData();
  }

  Future<void> initializeData() async {
    final userData = Provider.of<UserData>(context, listen: false);
    final registerID = userData.registerID;
    // registerid = registerID;
    if (widget.page == 1) {
      print("go to fav page");
      try {
        favorites = await getFavorites(registerID.toString());
        // Process the results as needed
        print('Favorites: $favorites');
      } catch (e) {
        print('Error: $e');
      }

      setState(() {
        pages[1] = FavouriteTime();
      });
    }
  }

  List<Map<String, dynamic>> favorites = [];

  Future<List<Map<String, dynamic>>> getFavorites(String registerID) async {
    final ipAddress = await getLocalIPv4Address();
    final String apiUrl = "http://$ipAddress:3000/getfavorites/$registerID";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse the response body
        List<dynamic> data = json.decode(response.body);

        // Convert the list of dynamic to List<Map<String, dynamic>>
        List<Map<String, dynamic>> favorites =
            List<Map<String, dynamic>>.from(data);

        return favorites;
      } else {
        throw Exception('Failed to load favorites');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load favorites');
    }
  }

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final pages = [
    homepage(),
    //FavoritePage(favorites: [],),
    FavouriteTime(),
    chatpage(),
    AccountPage(),
  ];
  String registerid = '';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userData = Provider.of<UserData>(context);
    final registerID = userData.registerID;
    registerid = registerID;
    return Scaffold(
      backgroundColor:
          themeProvider.isDarkMode ? Colors.black87 : const Color(0xFFffffff),
      body: pages[_page],
      bottomNavigationBar: CurvedNavigationBar(
        //index: 1,
        color: const Color.fromARGB(255, 27, 17, 122),
        key: _bottomNavigationKey,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 300),
        index: _page,
        onTap: (index) async {
          if (index == 1) {
            print("go to fav page");
            try {
              favorites = await getFavorites(registerid);
              // Process the results as needed
              print('Favorites: $favorites');
            } catch (e) {
              print('Error: $e');
            }
          }
          setState(() {
            _page = index;
            widget.page = index;
            pages[1] = FavouriteTime();
          });
        },
        items: [
          Icon(Icons.home,
              size: 30,
              color: themeProvider.isDarkMode
                  ? Colors.black54
                  : const Color(0xFFffffff)),
          Icon(Icons.favorite,
              size: 30,
              color: themeProvider.isDarkMode
                  ? Colors.black54
                  : const Color(0xFFffffff)),
          Icon(Icons.chat_bubble,
              size: 30,
              color: themeProvider.isDarkMode
                  ? Colors.black54
                  : const Color(0xFFffffff)),
          Icon(Icons.account_circle_rounded,
              size: 30,
              color: themeProvider.isDarkMode
                  ? Colors.black54
                  : const Color(0xFFffffff)),
        ],
      ),
    );
  }
}
