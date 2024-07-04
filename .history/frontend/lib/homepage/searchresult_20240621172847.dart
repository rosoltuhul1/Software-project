import 'package:flutter/material.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({
    Key? key,
    required this.controller,
    required this.allitems,
  }) : super(key: key);

  final TextEditingController controller;
  final List<Map<String, dynamic>> allitems;

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  List<Map<String, dynamic>> _founditems = [];
  bool isTextFieldFocused = true; // Track the focus state
  bool showImages = false; // Track if the images should be shown

  @override
  void initState() {
    super.initState();
    _founditems = widget.allitems;
    print("----------------------------------------");
    print(_founditems);
        print("----------------------------------------");

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
        .where((item) =>
            item["category"].toLowerCase().contains(enteredKeyword.toLowerCase()) ||
            (enteredKeyword.toLowerCase() == "w") ||
            (enteredKeyword.toLowerCase() == "we") ||
            (enteredKeyword.toLowerCase() == "wedd"))
        .toList();


        results = widget.allitems
        .where((item) =>
            item["category"==].toLowerCase().contains(enteredKeyword.toLowerCase()) ||
            (enteredKeyword.toLowerCase() == "b") ||
            (enteredKeyword.toLowerCase() == "bi") ||
            (enteredKeyword.toLowerCase() == "birth"))
        .toList();
  }

  // If the entered keyword is related to "Birthday", sort and take the top 3 most recent items


  setState(() {
    _founditems = results;
    showImages = results.isNotEmpty;
  });
}



  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor:
          themeProvider.isDarkMode ? Colors.black54 : const Color(0xFFffffff),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 25),
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
            const SizedBox(height: 20),
            // Conditionally display the item list based on search results
            if (!isTextFieldFocused || showImages)
              Expanded(
                child: ListView.builder(
                  itemCount: _founditems.length,
                  itemBuilder: (context, index) => Card(
                    key: ValueKey(_founditems[index]["id"]),
                    color: const Color(0xFFffffff).withOpacity(0.8),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to event details
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              _founditems[index]["image"],
                              width: MediaQuery.of(context).size.width,
                              height: 450,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Photographer: ${_founditems[index]['Fname']} ${_founditems[index]['Lname']}',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Level: ${_founditems[index]["level"]}',
                                  style: const TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: List.generate(
                                    _founditems[index]["review"],
                                    (index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Location: ${_founditems[index]["location"]}',
                                  style: const TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Date: ${_founditems[index]["date"]}',
                                  style: const TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Category: ${_founditems[index]["category"]}',
                                  style: const TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
