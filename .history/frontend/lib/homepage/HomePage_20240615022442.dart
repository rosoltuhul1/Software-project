import 'package:flutter/material.dart';
import 'package:frontend/homepage/EventsSection.dart';
import 'package:frontend/homepage/Custom_search_field.dart';
import 'package:frontend/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:frontend/Homepage/Places.dart'; // Ensure this import is correct

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double containerWidth = MediaQuery.of(context).size.width * 0.93;
    double containerHeight = MediaQuery.of(context).size.height * 0.18;
    return Scaffold(
      backgroundColor:
          themeProvider.isDarkMode ? Colors.black54 : const Color(0xFFffffff),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image(
                      image: const AssetImage('assets/lenssquat.jpg'),
                      width: containerWidth,
                      height: containerHeight,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SearchTextField(
                    controller: _searchController,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Places(),
            const SizedBox(height: 20),
            const EventsSection(),
            //const SizedBox(height: 20),
            
          ],
        ),
      ),
    );
  }
}
