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

class SearchResult extends StatefulWidget {
  const SearchResult({
    super.key,
    required this.controller,
    required this.allitems,
  });
  final TextEditingController controller;
  final List<Map<String, dynamic>> allitems;
  //final Function(List<Map<String, dynamic>>) onsearchResults;

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  List<Map<String, dynamic>> _founditems = [];
  bool isTextFieldFocused = true; // Track the focus state

  Future<bool> checkFavorite(int itemId, int registerId) async {
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
  void initState() {
    super.initState();
    //FocusScope.of(context).requestFocus(_focusNode);
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = widget.allitems;
    } else {
      results = widget.allitems
          .where((item) => item["description"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _founditems = results;
    });
  }

  // Future<void> _runFilter(String enteredKeyword)  {
  //   List<Map<String, dynamic>> results = [];
  //   if (enteredKeyword.isEmpty) {
  //     results = widget.allitems;
  //   } else {
  //     results = widget.allitems
  //         .where((item) => item["title"]
  //             .toLowerCase()
  //             .contains(enteredKeyword.toLowerCase()))
  //         .toList();
  //   }
  //   setState(() {
  //     _founditems = results;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userData = Provider.of<UserData>(context);
    final registerID = int.parse(userData.registerID);
    return Scaffold(
      backgroundColor:
          themeProvider.isDarkMode ? Colors.black54 : const Color(0xFFffffff),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  focusNode: _focusNode,
                  onChanged: (value) => _runFilter(value),
                  decoration: InputDecoration(
                    hintText: S.of(context).Search,
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.all(10),
                    filled: true,
                    fillColor: const Color(0xFFebedee).withOpacity(0.85),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 170, 170, 170),
                    ),
                  ),
                  style: const TextStyle(fontSize: 20, color: Color(0xFF000000)),
                  onTap: () {
                    setState(() {
                      isTextFieldFocused = true;
                    });
                  },
                  onFieldSubmitted: (_) {
                    setState(() {
                      isTextFieldFocused = false;
                    });
                  },
                ),
              ),
              isTextFieldFocused
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          _controller.clear();
                          _runFilter('');
                          FocusScope.of(context).unfocus();
                          isTextFieldFocused = false;
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        S.of(context).Cancel,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: themeProvider.isDarkMode
                              ? const Color(0xFFffffff)
                              : const Color(0xFF000000).withOpacity(0.7),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // Conditionally display the item list based on focus state
          if (isTextFieldFocused)
            Expanded(
              child: ListView.builder(
                itemCount: _founditems.length,
                itemBuilder: (context, index) => Card(
                  key: ValueKey(_founditems[index]["id"]),
                  color: const Color(0xFFffffff).withOpacity(0.8),
                  //Color(0xFFc0edda),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () async {
                      final isFavorite = await checkFavorite(
                          _founditems[index]["id"], registerID);
                      final isReserved = await checkReserved(
                          _founditems[index]["id"], registerID);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EventsDetails(
                                itemId: _founditems[index]["id"],
                                eventss: _founditems,
                                isFavorite: isFavorite,
                                isReserved: isReserved,
                                showNavBar: true,
                                gotoFav: false,
                              )));
                    },
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(
                            _founditems[index]["image"],
                          ),
                          width: 100,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Text(
                      //   _founditems[index]["id"].toString(),
                      //   style: const TextStyle(
                      //     fontSize: 24,
                      //     color: Color(0xFFffffff),
                      //   ),
                      // ),
                      title: Text(
                        _founditems[index]['title'],
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w800),
                      ),
                      subtitle: Text(
                        '${_founditems[index]["price"].toString()} ₪',
                        style: const TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
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
