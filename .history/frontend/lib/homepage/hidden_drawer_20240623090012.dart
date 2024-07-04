import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/Notificationpage/notificationMain.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/getStarted.dart';
import 'package:frontend/helpPage/help.dart';
import 'package:frontend/homepage/mainpage.dart';
import 'package:frontend/ipaddress.dart';
import 'package:frontend/registerID.dart';
import 'package:frontend/settingpage/settingspage.dart';
import 'package:frontend/settingpage/theme/theme_provider.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key, required this.page});
  final int page;

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];
  bool notification_flag = false;
  String itemOwner = '';
  List<Map<String, dynamic>> reservedArray = [];
  List<Map<String, dynamic>> resultReservedArray = [];
  late ThemeProvider themeProvider;
  @override
  void initState() {
    super.initState();
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name:
              Intl.getCurrentLocale() == 'ar' ? "الصفحة الرئيسية" : "HomePage",
          baseStyle: TextStyle(
              color:
                  themeProvider.isDarkMode ? Colors.black : const Color(0xFFffffff),
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
          selectedStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
          colorLineSelected: Colors.black,
        ),
        mainpage(page: widget.page),
      ),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: Intl.getCurrentLocale() == 'ar' ? "مساعدة" : "Help",
            baseStyle: TextStyle(
                color:
                    themeProvider.isDarkMode ? Colors.black : const Color(0xFFffffff),
                fontWeight: FontWeight.bold,
                fontSize: 18.0),
            selectedStyle: const TextStyle(
              color: Colors.black,
            ),
            colorLineSelected: Colors.black,
          ),
           helpPage()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: Intl.getCurrentLocale() == 'ar' ? "الإعدادات" : "Settings",
            baseStyle: TextStyle(
                color:
                    themeProvider.isDarkMode ? Colors.black : const Color(0xFFffffff),
                fontWeight: FontWeight.bold,
                fontSize: 18.0),
            selectedStyle: const TextStyle(
              color: Colors.black,
            ),
            colorLineSelected: Colors.black,
          ),
          const settingPage()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: Intl.getCurrentLocale() == 'ar' ? "تسجيل الخروج" : "Logout",
            baseStyle: TextStyle(
                color:
                    themeProvider.isDarkMode ? Colors.black : const Color(0xFFffffff),
                fontWeight: FontWeight.bold,
                fontSize: 18.0),
            selectedStyle: const TextStyle(
              color: Colors.black,
            ),
            colorLineSelected: Colors.black,
            onTap: () {
              logout();
            },
          ),
          Container()),
    ];
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      final userData = Provider.of<UserData>(context, listen: false);
      final registerID = userData.registerID;
      itemOwner = registerID;
      reservedArray = await getReserved(itemOwner.toString());
      resultReservedArray = await getReservedResult(itemOwner.toString());
      print('reservedArray: $reservedArray');
      print('resultReservedArray: $resultReservedArray');

      if (reservedArray.isNotEmpty || resultReservedArray.isNotEmpty) {
        setState(() {
          reservedArray = reservedArray;
          resultReservedArray = resultReservedArray;
          notification_flag = true;
        });
      }
    } catch (error) {
      // Provide more meaningful error handling or logging
      print('Error initializing data: $error');
    }
  }
Future<List<Map<String, dynamic>>> getReserved(String itemOwner) async {
  final ipAddress = await getLocalIPv4Address();
  final String apiUrl = "http://$ipAddress:3000/getReserved/$itemOwner";

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Parse the response body
      List<dynamic> data = json.decode(response.body);

      // Convert the list of dynamic to List<Map<String, dynamic>>
      List<Map<String, dynamic>> reservedArray = List<Map<String, dynamic>>.from(data);
      return reservedArray;
    } else {
      // Log the error and return an empty list
      print('Failed to load reserved items. Status code: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    // Log the error and return an empty list
    print('Error fetching reserved items: $e');
    return [];
  }
}

Future<List<Map<String, dynamic>>> getReservedResult(String itemRequester) async {
  final ipAddress = await getLocalIPv4Address();
  final String apiUrl = "http://$ipAddress:3000/getReservedResult/$itemRequester";

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Parse the response body
      List<dynamic> data = json.decode(response.body);

      // Convert the list of dynamic to List<Map<String, dynamic>>
      List<Map<String, dynamic>> resultReservedArray = List<Map<String, dynamic>>.from(data);
      return resultReservedArray;
    } else {
      // Log the error and return an empty list
      print('Failed to load reserved items. Status code: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    // Log the error and return an empty list
    print('Error fetching reserved items: $e');
    return [];
  }
}

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return HiddenDrawerMenu(
      backgroundColorMenu: const Color.fromARGB(255, 27, 17, 122).withOpacity(0.7),
      backgroundColorAppBar: const Color.fromARGB(255, 27, 17, 122), 
      screens: _pages, 
      slidePercent: 60.0, 
      actionsAppBar: <Widget>[
        IconButton(
          onPressed: () {
            // Handle notification icon press
            print("notification page");
            initializeData();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NotificationMain(
                        reservedArray: reservedArray,
                        resultReservedArray: resultReservedArray,
                        title: S.of(context).Notifications,
                        fromUserprofiel: false,
                      )),
            );
          },
          icon: Icon(
              notification_flag
                  ? Icons.notifications_active
                  : Icons.notifications_active_outlined,
              size: 25,
              color:
                  themeProvider.isDarkMode ? Colors.black : const Color(0xFFffffff)),
        ),
      ], 
      tittleAppBar: Center(
        child: Text(
          "LENSSCOUT",
          style: TextStyle(
              color:
                  themeProvider.isDarkMode ? Colors.black : const Color(0xFFffffff),
              fontWeight: FontWeight.bold,
              fontSize: 25.0),
        ),
      ), 
    );
  }

  void logout() { 
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const getStarted()));
  }
}
