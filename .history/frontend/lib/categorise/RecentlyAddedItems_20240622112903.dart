import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/additems/clicktoAdditem.dart';
import 'package:frontend/categorise/Otherspage/eventDetails.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/ipaddress.dart';
import 'package:frontend/registerID.dart';
import 'package:frontend/settingpage/theme/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'dart:convert';

import 'package:provider/provider.dart';

class RecentlyaddedItems extends StatefulWidget {
  const RecentlyaddedItems({
    Key? key,
    required this.array,
    required this.indexx,
  }) : super(key: key);

  final List<Map> array;
  final int indexx;

  @override
  State<RecentlyaddedItems> createState() => _RecentlyaddedItemsState();
}

class _RecentlyaddedItemsState extends State<RecentlyaddedItems> {
  List<Map> eventss = [];
  bool isFavoritee = false;
  bool isReservedd = false;
  final Map<String, Widget Function(String, List<Map>, bool, bool)>
      categoryDetailPages = {
    "Wedding": (itemId, eventss, isFavorite, isReserved) => EventsDetails(
        itemId: itemId,
        eventss: eventss,
        isFavorite: isFavorite,
        isReserved: isReserved,
        showNavBar: true,
        gotoFav: false),
    "Birth": (itemId, eventss, isFavorite, isReserved) => EventsDetails(
        itemId: itemId,
        eventss: eventss,
        isFavorite: isFavorite,
        isReserved: isReserved,
        showNavBar: true,
        gotoFav: false),
    "Graduation": (itemId, eventss, isFavorite, isReserved) =>
        EventsDetails(
            itemId: itemId,
            eventss: eventss,
            isFavorite: isFavorite,
            isReserved: isReserved,
            showNavBar: true,
            gotoFav: false),
    "Others": (itemId, eventss, isFavorite, isReserved) =>
        EventsDetails(
            itemId: itemId,
            eventss: eventss,
            isFavorite: isFavorite,
            isReserved: isReserved,
            showNavBar: true,
            gotoFav: false
            ),
    // Add other categories and their corresponding detail pages here
  };

  List<Map> categories = [
    {
      "name": "Wedding",
      "icon": Icons.book,
    },
    {
      "name": "Birth",
      "icon": Icons.book,
    },
    {
      "name": "Graduation",
      "icon": Icons.phone,
    },
    {
      "name": "Others",
      "icon": Icons.chair,
    },
  ];

  @override
  void initState() {
    fetchDataFromAPI(); // Call the method to fetch data
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchDataFromAPI() async {
    // Replace with your API endpoint
    final ipAddress = await getLocalIPv4Address();
    print(ipAddress);
    final response =
        await http.get(Uri.parse('http://$ipAddress:3000/postdetails'));
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        eventss = data.map((event) {
          return {
             "id": event["_id"],
             "image": event["image"],
            // "title": furniture["title"],
            // "category": furniture["CategoryName"],
            // "status": furniture["status"],
            // "Date": furniture["date"],
            // "phoneNumber": furniture["phoneNumber"],
            // "price": furniture["price"],
             "description": event["description"],
             "Fname": event["Fname"],
             "Lname": event["Lname"],
             "registerID": event["registerID"],
          };
        }).toList();
        //print("Furniture Data: $Furnitures");
      });
    } else {
      // Handle API error
      print('Failed to load furniture details');
    }
  }

  Future<bool> checkFavorite(String itemId, int registerId) async {
    final ipAddress = await getLocalIPv4Address();
    print(ipAddress);
    final apiUrl = 'http://$ipAddress:3000/checkFavorite/$itemId/$registerId';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['isFavorite'];
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      // Handle exceptions
      print('Exception: $error');
      return false;
    }
  }

  Future<bool> checkReserved(String itemId, int registerId) async {
    final ipAddress = await getLocalIPv4Address();
    print(ipAddress);
    final apiUrl = 'http://$ipAddress:3000/checkReserved/$itemId/$registerId';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['isReserved'];
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      // Handle exceptions
      print('Exception: $error');
      return false;
    }
  }

 @override
Widget build(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  final userData = Provider.of<UserData>(context);
  final registerID = int.parse(userData.registerID);
  double containerWidth = MediaQuery.of(context).size.width * 0.75;
  double containerWidth1 = MediaQuery.of(context).size.width * 0.9;
  double containerHeight = MediaQuery.of(context).size.height * 0.5;
  double containerHeight1 = MediaQuery.of(context).size.height * 0.12; //0.16
  double containerHeight2 = MediaQuery.of(context).size.height * 0.15; //0.22
  double imageHeight = MediaQuery.of(context).size.height * 0.5; // Match arrow height

  return Column(
    children: [
      clicktoAddItem(
        containerHeight1: containerHeight1,
        containerWidth1: containerWidth1,
        containerHeight2: containerHeight2,
        slidepage: false,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).New_new,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: themeProvider.isDarkMode
                    ? const Color(0xFFffffff)
                    : const Color(0xFF000000),
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              S.of(context).view_all,
              style: TextStyle(
                fontSize: 18.0,
                color: themeProvider.isDarkMode
                    ? const Color(0xFFffffff)
                    : const Color(0xFF000000).withOpacity(0.7),
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Expanded(
        child: widget.array.isEmpty
            ? Center(
                // Display a message when the array is empty
                child: Text(
                  S.of(context).Message_No_post,
                  style: const TextStyle(fontSize: 20),
                ),
              )
            : ListView.builder(
                itemCount: widget.array.length,
                itemBuilder: (context, index) {
                  final result = widget.array[index];
                  final category = categories[widget.indexx];
                  // Adjust as needed

                  return Row(
                    children: [
                      Intl.getCurrentLocale() == 'ar'
                          ? Container(
                              margin: const EdgeInsets.only(
                                bottom: 30,
                                right: 8,
                              ),
                              decoration: const BoxDecoration(
                                color: Color(0xFFffffff),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
                              height: containerHeight,
                              width: containerWidth,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.file(
                                          File(
                                            result["image"],
                                          ),
                                          width: double.infinity,
                                          height: imageHeight,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        result["name"],
                                        style: const TextStyle(
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.only(
                                bottom: 30,
                                left: 8,
                              ),
                              decoration: const BoxDecoration(
                                color: Color(0xFFffffff),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                ),
                              ),
                              height: containerHeight,
                              width: containerWidth,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.file(
                                          File(
                                            result["image"],
                                          ),
                                          width: double.infinity,
                                          height: imageHeight,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        result["registerId"],
                                        style: const TextStyle(
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      // Text(
                                      //   result["_id"],
                                      //   style: const TextStyle(fontSize: 16),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      GestureDetector(
                        onTap: () async {
                          final categoryName = category["name"];
                          print(categoryName);
                          await fetchDataFromAPI();
                          print("registerID for checkkk");
                          print(result["registerID"]);

                          final isFavorite = await checkFavorite(result["_id"], registerID);
                          isFavoritee = isFavorite;
                          print('Is Favorite: $isFavorite');

                          final isReserved = await checkReserved(result["_id"], registerID);
                          isReservedd = isReserved;
                          print('Is Reserved: $isReserved');

                          if (categoryDetailPages.containsKey(categoryName)) {
                            final detailPageBuilder = categoryDetailPages[categoryName];
                            if (detailPageBuilder != null) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => detailPageBuilder(result["_id"], eventss, isFavoritee, isReservedd),
                              ));
                            }
                          }
                        },
                        child: Intl.getCurrentLocale() == 'ar'
                            ? Container(
                                margin: const EdgeInsets.only(bottom: 30, left: 8),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF117a5d),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                  ),
                                ),
                                height: containerHeight,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: const Icon(
                                  Icons.keyboard_double_arrow_left,
                                  color: Colors.white,
                                  size: 70,
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.only(bottom: 30, right: 8),
                                decoration: const BoxDecoration(//Colors.white,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                height: containerHeight,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: const Icon(
                                  Icons.keyboard_double_arrow_right,
                                  color: Color.fromARGB(255, 27, 17, 122),
                                  size: 70,
                                ),
                              ),
                      ),
                    ],
                  );
                },
              ),
      )
    ],
  );
}


}
