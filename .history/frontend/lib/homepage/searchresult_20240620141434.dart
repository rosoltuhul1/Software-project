import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/categorise/Otherspage/eventDetails.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/ipaddress.dart';
import 'package:frontend/registerID.dart';
import 'package:frontend/settingpage/theme/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:frontend/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({
    super.key,
    required this.controller,
    required this.allitems,
  });
  final TextEditingController controller;
  final List<Map<String, dynamic>> allitems;

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor:
          themeProvider.isDarkMode ? Colors.black54 : const Color(0xFFffffff),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.allitems.length,
              itemBuilder: (context, index) => Card(
                key: ValueKey(widget.allitems[index]["category"]),
                color: const Color(0xFFffffff).withOpacity(0.8),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      widget.allitems[index]["image"],
                      width: 100,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    widget.allitems[index]['category'],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Photographer: ${widget.allitems[index]["photographer_name"]}'),
                      Text('Level: ${widget.allitems[index]["level"]}'),
                      Row(
                        children: List.generate(
                          widget.allitems[index]["review"],
                          (starIndex) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                        ),
                      ),
                      Text('Location: ${widget.allitems[index]["location"]}'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
