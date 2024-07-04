import 'package:flutter/material.dart';
import 'package:frontend/additems/CustomCategoryDropMenu.dart';
import 'package:frontend/additems/CustomPhoneNumber.dart';

class addItem2 extends StatefulWidget {
  const addItem2({
    super.key,
    required this.containerHeight,
    required this.containerWidth,
    required this.onCategorySelected,
    required this.phoneNumber,
   // required this.onStatusSelected,
    //required this.phoneNumber,
  });
  final double containerHeight;
  final double containerWidth;
  final Function(int) onCategorySelected;
  final Function(String) phoneNumber;
 // final Function(int) onStatusSelected;
  

  @override
  State<addItem2> createState() => _addItem2State();
}

class _addItem2State extends State<addItem2> {
  late int _selectedCategoryRadio;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryDropDown(
          containerHeight: widget.containerHeight,
          containerWidth: widget.containerWidth,
          onCategorySelected: (selectedRadio) {
            // Handle the selected radio value here
            _selectedCategoryRadio = selectedRadio;
            print('Selected post: $selectedRadio');
            print('_selectedCategoryRadio: $_selectedCategoryRadio');
            widget.onCategorySelected(selectedRadio);
          },
        ),
        const SizedBox(
          height: 25,
        ),
        // StatusDropDown(
        //   containerHeight: widget.containerHeight,
        //   containerWidth: widget.containerWidth,
        //   onStatusSelected: (selectedRadio) {
        //     print('Selected Status: $selectedRadio');
        //     widget.onStatusSelected(selectedRadio);
        //   },
        // ),
        const SizedBox(
          height: 1,
        ),
        phoneNumberTxetfield(
          containerHeight: widget.containerHeight,
          containerWidth: widget.containerWidth,
          onPhoneNumberChanged: (newPhoneNumber) {
            // Handle the new phone number value here
            print('New Phone Number: $newPhoneNumber');
            widget.phoneNumber(newPhoneNumber);
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}


