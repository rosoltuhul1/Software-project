import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';



class phoneNumberTxetfield extends StatefulWidget {
  final Function(String) onPhoneNumberChanged;
  final double containerHeight;
  final double containerWidth;
  const phoneNumberTxetfield({
    super.key,
    required this.containerHeight,
    required this.containerWidth,
    required this.onPhoneNumberChanged,
  });

  @override
  State<phoneNumberTxetfield> createState() => _phoneNumberTxetfieldState();
}

class _phoneNumberTxetfieldState extends State<phoneNumberTxetfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.containerWidth * 1.5,
      height: widget.containerHeight * 0.37,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            blurRadius: 3, // Blur radius
            offset: const Offset(0, 1), // Offset
          ),
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 8.0, right: 8.0, top: 18, bottom: 8),
        child: IntlPhoneField(
          decoration: InputDecoration(
            labelText: 'Phone Number',
            labelStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black54,
            ),
            filled: true,
            fillColor: const Color.fromARGB(255, 207, 235, 244),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          initialCountryCode: 'IN',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade800,
          ),
          onChanged: (phone) {
            print(phone.completeNumber);
            final phoneNumber = phone.completeNumber;
            print(phoneNumber);
            widget.onPhoneNumberChanged(phoneNumber);
          },
        ),
      ),
    );
  }
}
