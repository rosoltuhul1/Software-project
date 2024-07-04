import 'package:flutter/material.dart';
import 'package:frontend/ipaddress.dart';
import 'package:frontend/log_sign_forgot/custom_FName_field.dart';
import 'package:frontend/log_sign_forgot/photographer_location.dart';
import 'package:frontend/log_sign_forgot/custom_RegisterID_field.dart';
import 'package:frontend/log_sign_forgot/custom_email_field.dart';
import 'package:frontend/log_sign_forgot/custom_password_field.dart';
import 'package:frontend/log_sign_forgot/custom_phoneno_field.dart';
import 'package:frontend/log_sign_forgot/custome_LName_field.dart';
import 'package:frontend/log_sign_forgot/loginpage.dart';
import 'package:http/http.dart' as http;

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _registerIdController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _linkworkController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined, // Back arrow icon
              color: Colors.white, // Change the color
              size: 30.0, // Change the size
            ), // Back arrow icon
            onPressed: () {
              Navigator.pop(context); // Return to the previous page
            },
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Color.fromARGB(255, 27, 17, 122),
                  Color.fromARGB(255, 27, 17, 122),
                  Color.fromARGB(255, 27, 17, 122),
                ], // Define your gradient colors here
              ),
            ),
          ),
        ),
        body: Container(
            // padding: EdgeInsets.symmetric(vertical: 0),
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Color.fromARGB(255, 27, 17, 122),
                  Color.fromARGB(255, 27, 17, 122),
                  Color.fromARGB(255, 27, 17, 122),
            ])),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Text("SIGN UP",
                                style: TextStyle(
                                    color: Color(0xFFffffff), fontSize: 40)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text("Create an account",
                                style: TextStyle(
                                    color: Color(0xFFffffff), fontSize: 20)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Form(
                        key: _formKey,
                        child: Container(
                            child: Container(
                              
                                decoration: BoxDecoration(
  color: const Color(0xFFffffff),
  borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(60),
    topRight: Radius.circular(60),
    bottomLeft: Radius.circular(60),
    bottomRight: Radius.circular(60),
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 5,
      blurRadius: 7,
      offset: const Offset(0, 3),
    ),
  ],
  border: Border.all(
    color: Colors.grey,
    width: 2,
  ),
),

                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: <Widget>[
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            RegisterIDTextField(
                                              controller: _registerIdController,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            FirstNameTextField(
                                              controller: _firstNameController,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            LastNameTextField(
                                              controller: _lastNameController,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            LastNameTextField(
                                              controller: _lastNameController,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            EmailAddressTextField(
                                              controller:
                                                  _emailAddressController,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            PasswordTextField(
                                              controller: _passwordController,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            locationTextField(
                                              controller: _locationController,
                                            ),
                                            // SizedBox(
                                            //   height: 5,
                                            // ),
                                            PhoneNumberTextField(
  controller: _phoneController,
  onPhoneNumberChanged: (phoneNumber) {
    // Handle phone number changes
  },
  containerHeight: MediaQuery.of(context).size.height,
  containerWidth: MediaQuery.of(context).size.width,
),
                                            
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        errorMessage,
                                        style: const TextStyle(
                                          color: Color(0xFFf25a46),
                                          fontSize: 16,
                                          backgroundColor: Color.fromARGB(
                                              255, 240, 192, 186),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          height: 60,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 50),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: const Color.fromARGB(255, 27, 17, 122),
                                          ),
                                          child: TextButton(
                                              onPressed: () async { 
                                                if (_formKey.currentState!
                                                    .validate()) { 
                                                  final registerId =
                                                      _registerIdController
                                                          .text;
                                                  final firstName =
                                                      _firstNameController.text;
                                                  final lastName =
                                                      _lastNameController.text;
                                                  final email =
                                                      _emailAddressController
                                                          .text;
                                                  final password =
                                                      _passwordController.text;
                                                  final location =
                                                      _locationController.text;
                                                  final phone =
                                                      _phoneController.text;
                                                  await signUp(
                                                    registerID: registerId,
                                                    fname: firstName,
                                                    lname: lastName,
                                                    phoneNO: phone,
                                                    email: email,
                                                    password: password,
                                                    location: location,
                                                    context: context,
                                                  );
                                                  await createProfile(
                                                    registerID: registerId,
                                                  );
                                                }
                                              },
                                              child: const Center(
                                                child: Text(
                                                  "Sign Up",
                                                  style: TextStyle(
                                                      color: Color(0xFFffffff),
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ))),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 45,
                                            ),
                                            const Text(
                                              "Already have an account?",
                                              style: TextStyle(
                                                  color: Color.fromARGB(255, 27, 17, 122),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const login()));
                                              },
                                              child: const Text(
                                                "Login",
                                                style: TextStyle(
                                                    color: Color(0xFF000000),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))))
                  ]),
            )));
  }

  Future<void> signUp({
    required String registerID,
    required String fname,
    required String lname,
    required String phoneNO,
    required String email,
    required String password,
    required String location,
    required BuildContext context,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/lens/photographer/signups');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'registerID': registerID,
          'fname': fname,
          'lname': lname,
          'phoneNO': phoneNO,
          'email': email,
          'password': password,
          'location':location,
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('Signup successful');
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => login()));
      } else {
        // Handle errors or server response based on status code
        setState(() {
          errorMessage =
              'This account does exist. You can try logging in with your register ID';
        });
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }


  Future<void> createProfile({
    required String registerID,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/lens/createprofile');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'registerID': registerID,
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('profile craeted successful');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const login()));
      } else {
        // Handle errors or server response based on status code
        setState(() {
          errorMessage =
              'This account doesn\'t exist. You can try logging in with your register ID';
        });
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }
}
