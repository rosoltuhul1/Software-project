import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/screen/otherUserAccount.dart';
import 'package:frontend/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:frontend/homepage/locationplaces.dart';


class GreenCircles extends StatelessWidget {
  const GreenCircles({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isArabic = Intl.getCurrentLocale() == 'ar';

    return Expanded(
      flex: 4,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 411,
                        height: 400,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: isArabic
                              ? const Color(0xFFFFFFFF)
                              : const Color.fromARGB(255, 27, 17, 122),
                          image: DecorationImage(
                            image: FileImage(File(item["image"])),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailItem(context, themeProvider, Icons.person_sharp,"Photographer"+" "+ S.of(context).Name, "Omar" + " " + "Omar"),
                      _buildDetailItem(context, themeProvider, Icons.table_chart, S.of(context).Events, "Others"),
                      _buildDetailItem(context, themeProvider, Icons.date_range_rounded, S.of(context).Date, "2024-01-01"),
                      _buildDetailItem(context, themeProvider, Icons.phone, S.of(context).Phone, "0599999999"),
                      _buildDetailItem(context, themeProvider, Icons.place, S.of(context).Places, "Pardo Coffe", onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationDetailPage(
                              locationName: "Pardo Coffe", // Replace with actual location name
                              image: "assets/web/pardo.jpg", // Replace with actual image path
                              stars: 5, // Replace with actual star rating
                              price: 50, // Replace with actual price
                              owner: "John Doe", // Replace with actual owner name
                              phone: 123456789, // Replace with actual phone number
                              address: "Nblus, ", // Replace with actual address
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, ThemeProvider themeProvider, IconData icon, String title, String value, {VoidCallback? onTap}) {
    return Row(
      children: [
        _buildIcon(themeProvider, icon),
        const SizedBox(width: 10),
        _buildInfoColumn(context, themeProvider, title, value, onTap),
      ],
    );
  }

  Widget _buildIcon(ThemeProvider themeProvider, IconData icon) {
    return Container(
      width: 100,
      height: 45,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(255, 27, 17, 122),
      ),
      child: Icon(
        icon,
        color: themeProvider.isDarkMode
            ? const Color(0xFF000000)
            : const Color(0xFFffffff),
        size: 30,
      ),
    );
  }

  Widget _buildInfoColumn(BuildContext context, ThemeProvider themeProvider, String title, String value, VoidCallback? onTap) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: themeProvider.isDarkMode
                  ? const Color(0xFF000000)
                  : Color.fromARGB(255, 27, 17, 122),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              value,
              style: TextStyle(
                color: themeProvider.isDarkMode
                    ? const Color(0xFF000000)
                    : Color.fromARGB(255, 27, 17, 122),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
