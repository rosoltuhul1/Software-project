import 'package:flutter/material.dart';
import 'package:frontend/categorise/GreenCircles.dart';
import 'package:frontend/categorise/appbar_details.dart';
import 'package:frontend/categorise/bottomNavigationbar.dart';
import 'package:frontend/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class EventsDetails extends StatefulWidget {
  const EventsDetails(
      {super.key,
      required this.itemId,
      required this.eventss,
      required this.isFavorite,
      required this.isReserved,
      required this.showNavBar,
      required this.gotoFav});

  final String itemId;
  final List<Map> eventss;
  final bool isFavorite;
  final bool isReserved;
  final bool showNavBar;
  final bool gotoFav;

  @override
  State<EventsDetails> createState() => _EventsDetailsState();
}

class _EventsDetailsState extends State<EventsDetails> {
  @override
  void initState() {
    super.initState();
    // Print statements for debugging
    print('widget.itemId: ${widget.itemId}');
    print('widget.eventss: ${widget.eventss}');
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Additional check for debugging
    final matchingEvents = widget.eventss.where((event) => event["id"] == widget.itemId).toList();
    print('Matching events: $matchingEvents');

    if (matchingEvents.isEmpty) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: appBarDetails(gotoFav: widget.gotoFav),
        ),
        backgroundColor: themeProvider.isDarkMode
            ? const Color.fromARGB(255, 37, 37, 37).withOpacity(0.3)
            : const Color(0xFFffffff),
        body: const Center(
          child: Text(
            'Event not found',
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
        ),
      );
    }

    final item = matchingEvents.first;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: appBarDetails(gotoFav: widget.gotoFav),
      ),
      backgroundColor: themeProvider.isDarkMode
          ? const Color.fromARGB(255, 37, 37, 37).withOpacity(0.3)
          : const Color(0xFFffffff),
      // backgroundColor: Color(0xFFffffff),
      body: LayoutBuilder(
        builder: ((context, constraints) {
          return Container(
            child: Column(
              children: [
                GreenCircles(item: item),
                //DetailsItem(constraints: constraints, item: item),
                Visibility(
                  visible: widget
                      .showNavBar, // Set this flag based on your condition
                  child: BottomNav(
                    itemId: widget.itemId,
                    isFavorite: widget.isFavorite,
                    isReserved: widget.isReserved,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
      //bottomNavigationBar: BottomNav(itemId: widget.itemId,isFavorite: widget.isFavorite),
    );
  }
}
