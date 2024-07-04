import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/homepage/hidden_drawer.dart';
import 'package:frontend/ipaddress.dart';
import 'package:frontend/registerID.dart';
import 'package:frontend/settingpage/theme/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


// import 'theme_provider.dart';
// import 'ipaddress.dart';
// import 'registerID.dart';
// import 'hidden_drawer.dart';

class editAccount extends StatefulWidget {
  editAccount({
    Key? key,
    required this.fName,
    required this.lName,
    required this.proficiencyLevel,
  }) : super(key: key);
  String fName;
  String lName;
  String proficiencyLevel;

  @override
  State<editAccount> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<editAccount> {
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  late String selectedLevel;

  @override
  void initState() {
    super.initState();
    fNameController.text = widget.fName;
    lNameController.text = widget.lName;

    // Ensure the level is one of the valid values
    if (['beginner', 'intermediate', 'professional'].contains(widget.proficiencyLevel)) {
      selectedLevel = widget.proficiencyLevel;
    } else {
      selectedLevel = 'beginner';
    }
  }

 Future<void> editProfileInfo({
  required String registerID,
  required String fName,
  required String lName,
  required String proficiencyLevel,
}) async {
  final ipAddress = await getLocalIPv4Address();
  final url = Uri.parse('http://$ipAddress:3000/lens/editprofileInfo');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'registerID': registerID,
        'fname': fName.isNotEmpty ? fName : widget.fName,
        'lname': lName.isNotEmpty ? lName : widget.lName,
        'proficiencyLevel': proficiencyLevel.isNotEmpty ? proficiencyLevel : widget.proficiencyLevel,  // Update this line
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        widget.fName = fName.isNotEmpty ? fName : widget.fName;
        widget.lName = lName.isNotEmpty ? lName : widget.lName;
        widget.proficiencyLevel = proficiencyLevel.isNotEmpty ? proficiencyLevel : widget.proficiencyLevel;  // Update this line
      });
    } else {
      print('HTTP error: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
  }
}

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userData = Provider.of<UserData>(context, listen: false);
    final registerID = userData.registerID;
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.black54 : Color(0xFFffffff),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(
                height: 200,
              ),
              buildTextField(S.of(context).first_name, widget.fName, fNameController, themeProvider),
              buildTextField(S.of(context).last_name, widget.lName, lNameController, themeProvider),
              buildDropdown(S.of(context).level, selectedLevel, themeProvider),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      S.of(context).Cancel,
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 2,
                        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await editProfileInfo(
                        registerID: registerID,
                        fName: fNameController.text,
                        lName: lNameController.text,
                        proficiencyLevel: selectedLevel,
                      );
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HiddenDrawer(page: 3)));
                    },
                    child: Text(
                      S.of(context).Save,
                      style: TextStyle(fontSize: 20, letterSpacing: 2, color: Colors.white),
                    ),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 27, 17, 122),
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeHolder, TextEditingController controller, ThemeProvider themeProvider) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeHolder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black45),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildDropdown(String labelText, String selectedValue, ThemeProvider themeProvider) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black45),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        items: ['beginner', 'intermediate', 'professional'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selectedLevel = newValue!;
          });
        },
      ),
    );
  }
}
