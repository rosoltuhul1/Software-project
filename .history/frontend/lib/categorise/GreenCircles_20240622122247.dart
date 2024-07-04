import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/screen/otherUserAccount.dart';
import 'package:frontend/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class GreenCircles extends StatelessWidget {
  const GreenCircles({
    super.key,
    required this.item,
  });

  final Map item;

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
           // padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 400,
                      height: 380,
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
                
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailItem(context, themeProvider, Icons.person_sharp, S.of(context).Name, item["description"] + " " + item["description"]),
                          _buildDetailItem(context, themeProvider, Icons.book, S.of(context).Category, item["description"]),
                          _buildDetailItem(context, themeProvider, Icons.date_range_rounded, S.of(context).Date, item["description"]),
                          _buildDetailItem(context, themeProvider, Icons.phone, S.of(context).Phone, item["description"]),
                        ],
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, ThemeProvider themeProvider, IconData icon, String title, String value) {
    return Row(
      children: [
        _buildIcon(themeProvider, icon),
        _buildInfoColumn(context, themeProvider, title, value),
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

  Widget _buildInfoColumn(BuildContext context, ThemeProvider themeProvider, String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: themeProvider.isDarkMode
                  ? const Color(0xFF000000)
                  : const Color.fromARGB(255, 27, 17, 122),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => otherUserAccountPage(
                    userRegisterID: item["registerID"].toString(),
                    flagReserved: false,
                    itemTitle: '',
                    itemId: '',
                    goNotification: false,
                    flagReservedResult: false,
                    desicion: false,
                    price: " ",
                  ),
                ),
              );
            },
            child: Text(
              value,
              style: TextStyle(
                color: themeProvider.isDarkMode
                    ? const Color(0xFF000000)
                    : const Color.fromARGB(255, 27, 17, 122),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
