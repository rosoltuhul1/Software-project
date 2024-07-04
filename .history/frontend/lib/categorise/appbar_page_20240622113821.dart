import 'package:flutter/material.dart';
import 'package:frontend/homepage/hidden_drawer.dart';
import 'package:intl/intl.dart';

class appBarPage extends StatelessWidget {
  const  appBarPage({super.key, required this.slidepage});
  final bool slidepage;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //  backgroundColor: Color(0xFFffffff).withOpacity(0.05),
      backgroundColor: const Color.fromARGB(255, 27, 17, 122),
      leading: IconButton(
        icon: Icon(
          Intl.getCurrentLocale() == 'ar'
              ? Icons.arrow_forward_ios_outlined
              : Icons.arrow_back_ios_new_outlined, // Back arrow icon
          color: Colors.black, // Change the color
          size: 30, // Change the size
        ), // Back arrow icon
        onPressed: () {
          if (slidepage) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HiddenDrawer(
                          page: 0,
                        )));
          } else {
            Navigator.pop(context); // Return to the previous page
          }
        },
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            // Handle notification icon press
          },
          icon: const Icon(
            Icons.search,
            size: 30,
            color: Colors.black,
          ),
        ),
        
      ],
    );
  }
}