import 'package:flutter/material.dart';
import 'package:frontend/categorise/DetailsItem.dart';
import 'package:frontend/categorise/GreenCircles.dart';
import 'package:frontend/categorise/appbar_details.dart';
import 'package:frontend/categorise/bottomNavigationbar.dart';

class slideDetails extends StatefulWidget {
const slideDetails({Key? key, required this.itemId, required this.isFavorite, required this.isReserved})
      : super(key: key);  final String itemId;
  final bool isFavorite;
  final bool isReserved;
  @override
  State<slideDetails> createState() => _slideDetailsState();
}

class _slideDetailsState extends State<slideDetails> {
  List<Map> slides = [
    {
      "id": 1,
      "image": "assets/resturants/rest1.jpeg",
      "name": "item1 ",
      "description": "description1",
    },
    {
      "id": 2,
      "image": "assets/resturants/rest2.jpeg",
      "name": "item2",
      "description": "description2",
    },
    {
      "id": 3,
      "image": "assets/resturants/rest3.jpeg",
      "name": "item3",
      "description": "description3",
    },
    {
      "id": 4,
      "image": "assets/resturants/rest4.jpeg",
      "name": "item4",
      "description": "description4",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final item = slides.firstWhere((slide) => slide["id"] == widget.itemId);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: appBarDetails(
          gotoFav: false,
        ),
      ),
      // backgroundColor: Color(0xFFffffff),
      body: LayoutBuilder(
        builder: ((context, constraints) {
          return Container(
            child: Column(
              children: [
                GreenCircles(item: item),
                DetailsItem(constraints: constraints, item: item)
              ],
            ),
          );
        }),
      ),

      bottomNavigationBar: BottomNav(
        itemId: widget.itemId,
        isFavorite: widget.isFavorite,
        isReserved: widget.isReserved,
      ),
    );
  }
}
