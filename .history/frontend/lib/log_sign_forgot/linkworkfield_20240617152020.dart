import 'package:flutter/material.dart';

class LinkTextField extends StatefulWidget {
  const LastNameTextField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<LastNameTextField> createState() => _LastNameTextFieldState();
}

class _LastNameTextFieldState extends State<LastNameTextField> {
  var obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        keyboardType: TextInputType.name,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: 'Last Name',
          contentPadding: const EdgeInsets.all(18),
          filled: true,
          fillColor: const Color.fromARGB(255, 207, 235, 244), // Background color
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30), // Rounded border
              borderSide: BorderSide.none),
          hintStyle: const TextStyle(fontSize: 16, color: Color(0xFF7d7d7d)),
        ),
        style: const TextStyle(fontSize: 20, color: Color(0xFF000000)),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter Last Name';
          }
          return null;
        },
      ),
    );
  }
}
