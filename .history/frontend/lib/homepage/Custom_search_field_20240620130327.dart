

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/homepage/searchresult.dart';
import 'package:frontend/ipaddress.dart';
import 'package:http/http.dart' as http;

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

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
            "id": item["iditem"],
           // "title": item["title"],
           // "price": item["price"],
            "image": item["image"],
            "category": item["CategoryName"],
            "Date": item["date"],
            // "phoneNumber": item["phoneNumber"],
            // "status": item["status"],
            // "description": item["description"],
            "Fname": item["Fname"],
            "Lname": item["Lname"],
          };
        }).toList();
        print("Items details: $_allitems");
      });
    } else {
      // Handle API error
      print('Failed to load furniture details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: S.of(context).Search,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.filter_list),
              contentPadding: const EdgeInsets.all(18),
              filled: true,
              fillColor: const Color(0xFFebedee), // Background color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // Rounded border
                borderSide: BorderSide.none,
              ),
              hintStyle: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 170, 170, 170),
              ),
            ),
            style: const TextStyle(fontSize: 20, color: Color(0xFF000000)),
            onTap: () async {
              // Remove the focus from the TextField to prevent the keyboard from appearing
              _focusNode.unfocus();
              await searchItemsResults();
              print("after call");
              print(_allitems);
              // When the search TextField is tapped, navigate to the SearchResultsPage
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SearchResult(
                  controller: _searchController,
                  allitems: _allitems,
                ),
              ));
            },
            // Assign the FocusNode to the TextField
            focusNode: _focusNode,
          ),
        ],
      ),
    );
  }
}
