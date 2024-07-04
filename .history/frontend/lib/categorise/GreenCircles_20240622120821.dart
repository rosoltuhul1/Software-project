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

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        color: const Color.fromARGB(255, 34, 83, 98),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item["description"],
                style: TextStyle(
                  color: themeProvider.isDarkMode
                      ? const Color(0xFF000000)
                      : const Color(0xFFffffff),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: isArabic
                      ? const Color(0xFFFFFFFF)
                      : const Color.fromARGB(255, 27, 17, 122),
                  image: DecorationImage(
                    image: FileImage(File(item["image"])),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildDetailItem(context, themeProvider, Icons.person_sharp, S.of(context).Name, item["description"] + " " + item["description"]),
              const SizedBox(height: 10),
              _buildDetailItem(context, themeProvider, Icons.book, S.of(context).Category, item["description"]),
              const SizedBox(height: 10),
              _buildDetailItem(context, themeProvider, Icons.date_range_rounded, S.of(context).Date, item["description"]),
              const SizedBox(height: 10),
              _buildDetailItem(context, themeProvider, Icons.phone, S.of(context).Phone, item["description"]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, ThemeProvider themeProvider, IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIcon(themeProvider, icon),
        const SizedBox(width: 10),
        Expanded(
          child: _buildInfoColumn(context, themeProvider, title, value),
        ),
      ],
    );
  }

  Widget _buildIcon(ThemeProvider themeProvider, IconData icon) {
    return Container(
      width: 45,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: themeProvider.isDarkMode
                ? const Color(0xFF000000)
                : const Color(0xFFffffff),
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
                  : const Color(0xFFffffff),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
