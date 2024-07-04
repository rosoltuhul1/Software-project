

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/homepage/searchresult.dart';
import 'package:frontend/ipaddress.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:frontend/homepage/searchresult.dart';

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
      "image": 'assets/wedding.png',
      "category": "Wedding",
      "photographer_name": "Abood",
      "level": "Intermediate",
      "review": 4,
      "location": "Amanda House",
    },
    // Add more items if needed
  ];

  List<Map<String, dynamic>> _foundItems = [];

  void _searchItemsResults(String query) {
    setState(() {
      _foundItems = _allitems.where((item) {
        return item["category"].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
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
              hintText: "Search",
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
            onChanged: (value) {
              _searchItemsResults(value);
            },
            onTap: () async {
              _focusNode.unfocus();
              // When the search TextField is tapped, navigate to the SearchResultsPage
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SearchResult(
                  controller: _searchController,
                  allitems: _foundItems,
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
