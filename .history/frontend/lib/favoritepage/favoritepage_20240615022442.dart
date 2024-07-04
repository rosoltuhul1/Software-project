import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/categorise/Otherspage/eventDetails.dart';
import 'package:frontend/ipaddress.dart';
import 'package:frontend/registerID.dart';
import 'package:frontend/settingpage/theme/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key, required this.favorites});
  final List<Map<String, dynamic>> favorites;

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final int _currentIndex = 0;
  List<bool> showContainerList = List.generate(100, (index) => false);

  List<Map<String, dynamic>> items = [];

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

  Future<bool> checkReserved(int itemId, int registerId) async {
    print("inside reserved Checkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
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

  //************for item details: ********************//
  List<Map<String, dynamic>> _allitems = [];

  Future<void> searchItemsResults() async {
    // Replace with your API endpoint
    final ipAddress = await getLocalIPv4Address();
    print("*********************************************");
    print(ipAddress);
    final response =
        await http.get(Uri.parse('http://$ipAddress:3000/searchItems'));
    if (response.statusCode == 200) {
      print(response.statusCode);
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _allitems = data.map((item) {
          return {
            // "id": item["iditem"],
            // "title": item["title"],
            // "price": item["price"],
            "image": item["image"],
            // "category": item["CategoryName"],
            // "Date": item["date"],
            // "phoneNumber": item["phoneNumber"],
            // "status": item["status"],
            // "description": item["description"],
           // "Fname": item["Fname"],
           // "Lname": item["Lname"],
          };
        }).toList();
        print("Items details: $_allitems");
      });
    } else {
      // Handle API error
      print('Failed to load furniture details');
    }
  }

  String errorMessage = '';
  bool _isFavorite = false;

  Future<void> deletefavorite({
    required String iditem,
    required BuildContext context,
    required int index,
    required String registerid,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/deletefavorite');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'iditem': iditem, 'registerID': registerid},
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        setState(() {
          _isFavorite = false; // Update the local state
          setState(() {
            items.removeAt(index); // Remove the item from the list
          });
        });
        print('Deleted successful');
      } else {
        // Handle errors or server response based on status code
        setState(() {
          errorMessage = 'error';
        });
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    print('inside Favorites:');
    print(widget.favorites);
    items = widget.favorites;

    // Check if the items list is empty
    if (items.isEmpty) {
      return Center(
        child: Text(
          'No favorite items',
          style: TextStyle(
            fontSize: 20,
            color:
                themeProvider.isDarkMode ? const Color(0xFFffffff) : Colors.black87,
          ),
        ),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < items.length; i += 2)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildItem(items[i], i),
                        const SizedBox(
                          width: 15,
                        ),
                        if (i + 1 < items.length)
                          buildItem(items[i + 1], i + 1),
                      ],
                    ),
                    const SizedBox(height: 20.0), // Add space between rows
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildItem(Map<String, dynamic> item, int index) {
    final userData = Provider.of<UserData>(context);
    final registerID = int.parse(userData.registerID);
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {print('show contaaaaaaaaaaaainer listtttttttt');
            showContainerList[index] = !showContainerList[index];
          });
        },
        child: Container(
          height: 265,
          width: 180,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.black.withOpacity(0.8),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              item['softCopy'] == 0
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),

                      child: Image.network(
              item['image'],
              width: double.infinity,
              height: double.infinity,
 // Adjust the height as needed
                        fit: BoxFit.cover, // Adjust the fit as needed
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),

                                        child: Image.file(
                                          File(
                                            item["image"],
                                          ),
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                    
                    ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            await deletefavorite(
                                context: context,
                                iditem: items[index]["iditem"].toString(),
                                index: index,
                                registerid: registerID.toString());
                          },
                          child: Icon(
                            Icons.favorite_rounded,
                            color: const Color(0xFF000000).withOpacity(0.7),
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  showContainerList[index]
                      ? GestureDetector(
                          onTap: () async {
                            if (items[index]["softCopy"] == 0) {
                              final isFavorite = await checkFavorite(
                                  items[index]["iditem"], registerID);
                                  print(items[index]["iditem"]);
                                  print('____________________________________________________________________________________________________________________________');
                              print("isfavvv:");
                              print(isFavorite);

                              final isReserved = await checkReserved(
                                  items[index]["iditem"], registerID);
                              await searchItemsResults();
                              final updatedFavorites =
                                  await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EventsDetails(
                                    itemId: items[index]["iditem"],
                                    eventss: _allitems,
                                    isFavorite: isFavorite,
                                    isReserved: isReserved,
                                    showNavBar: true,
                                    gotoFav: true,
                                  ),
                                ),
                              );
                              if (updatedFavorites != null) {
                                setState(() {
                                  items = List.from(updatedFavorites);
                                });
                              }
                            }

                            // setState(() {
                            //   Navigator.of(context).push(MaterialPageRoute(
                            //       builder: (context) => FurnitureDetails(
                            //             itemId: items[index]["iditem"],
                            //             Furnitures: _allitems,
                            //             isFavorite: isFavorite,
                            //           )));
                            // });
                          },
                          child: Container(
                            height: 65,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFF000000).withOpacity(0.7),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            // child:
                            // Column(
                            //   children: [
                            //     Center(
                            //       child: Text(
                            //         item['title'],
                            //         style: const TextStyle(
                            //           fontSize: 20,
                            //           color: Color(0xFFffffff),
                            //           fontWeight: FontWeight.w600,
                            //         ),
                            //       ),
                            //     ),
                            //     Center(
                            //       child: Text(
                            //         item['price'].toString() + "₪",
                            //         style: const TextStyle(
                            //           fontSize: 20,
                            //           color: Color(0xFFffffff),
                            //           fontWeight: FontWeight.w600,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
