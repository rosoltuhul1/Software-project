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

  List<Map<String, dynamic>> _allitems = [
    {
      "id": 1,
      "image": "assets/web/wedding1.jpg",
      "category": "Wedding",
      "date": "2024-06-19",
      "Fname": "Abood",
      "Lname": "",
      "level": "intermediate",
      "review": 4,
      "location": "Amanda House"
    },
    {
      "id": 2,
      "image": "assets/web/wedding2.jpg",
      "category": "Wedding",
      "date": "2024-01-01",
      "Fname": "Rayan",
      "Lname": "Johny",
      "level": "intermediate",
      "review": 3,
      "location": "Balaa Villa"
    },
    {
      "id": 3,
      "image": "assets/web/wedding3.jpg",
      "category": "Wedding",
      "date": "2023-09-01",
      "Fname": "Omar",
      "Lname": "Omar",
      "level": "proffesional",
      "review": 5,
      "location": "Golden house "
    },
    {
      "id": 4,
      "image": "assets/web/birth1.jpg",
      "category": "Birth",
      "date": "2023-09-01",
      "Fname": "Omar",
      "Lname": "Omar",
      "level": "proffesional",
      "review": 5,
      "location": "Golden house "
    },
    {
      "id": 3,
      "image": "assets/web/birth2.jpg",
      "category": "Birth",
      "date": "2022-09-09",
      "Fname": "Omar",
      "Lname": "Omar",
      "level": "proffesional",
      "review": 5,
      "location": "Golden house "
    },
    {
      "id": 3,
      "image": "assets/web/wedding3.jpg",
      "category": "Wedding",
      "date": "2023-09-01",
      "Fname": "Omar",
      "Lname": "Omar",
      "level": "proffesional",
      "review": 5,
      "location": "Golden house "
    }
  ];

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
            onTap: () {
              print("********************");
              print(_allitems);
                            print("********************");

              // Remove the focus from the TextField to prevent the keyboard from appearing
              _focusNode.unfocus();
              // Navigate to the SearchResultsPage with hardcoded data
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
