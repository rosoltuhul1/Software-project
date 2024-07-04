import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/services.dart';
import 'package:frontend/Notificationpage/CustomAlertConten.dart';
import 'package:frontend/Notificationpage/notificationMain.dart';
import 'package:frontend/additems/additemMain.dart';
import 'package:frontend/additems/additemSoft.dart';
import 'package:frontend/categorise/Otherspage/eventDetails.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/ipaddress.dart';
import 'package:frontend/registerID.dart';
import 'package:frontend/settingpage/theme/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:mime/mime.dart';
import 'accounteditpage.dart';
import 'editSoftpage.dart';
import 'edititempage.dart';
import 'requests.dart';


class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final double coverHeight = 240;
  final double profileHeight = 144;
  String Fname = '';
  String Lname = '';
  String Level = '';
  String Profileimage = '';
  String registerid = '';
  bool loading=true;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

File? image;
Future pickProfileImage(ImageSource source) async {
  try {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile == null) return;
    final imageTemporary = File(pickedFile.path);
    setState(() {
      this.image = imageTemporary;
      print("************imageTemporary:**********");
      print(imageTemporary);
    });
    await profileimage(registerID: registerid, profileimage: imageTemporary);
  } on PlatformException catch (e) {
    print('Failed to pick image: $e');
  }
}

Future<void> profileimage({
  required String registerID,
  required File profileimage,
}) async {
  final ipAddress = await getLocalIPv4Address();
  final url = Uri.parse('http://$ipAddress:3000/insertprofileimage');

  try {
    final mimeType = lookupMimeType(profileimage.path);
    final request = http.MultipartRequest('POST', url);
    request.fields['registerID'] = registerID;
    request.files.add(
      await http.MultipartFile.fromPath(
        'profileimage',
        profileimage.path,
        contentType: MediaType.parse(mimeType!),
      ),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      // Data sent successfully
      print('Image inserted successfully');
      setState(() {
        Profileimage = profileimage.path;
      });
    } else {
      print('HTTP error: ${response.statusCode}');
    }
  } catch (error) {
    // Handle network or other errors
    print('Error: $error');
  }
}
  Future<void> initializeData() async {
  try {
    final userData = Provider.of<UserData>(context, listen: false);
    final registerID = userData.registerID;
    registerid = registerID;

    if (registerID != null) {
      print("inside initializeData");
      print(registerID);
      await fetchProfileById(registerID);
      await fetchuserItems(registerID);
    } else {
      // Handle the case where registerID is null
      print('RegisterID is null.');
    }
  } catch (error) {
    // Handle errors
    print('Error initializing data: $error');
  }
}



Future<void> fetchProfileById(String id) async {
  final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/profile?id=$id'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    setState(() {
      registerid = data['registerID'];
      Fname = data['fname'];
      Lname = data['lname'];
      Level = data['level'] != null ? data['level'].toString() : 'Photographer Level';

      //Level = Level != null ? Level.toString() : 'Photographer Level';
      //Level=data['level'];
      Profileimage = 'http://10.0.2.2:3000/' + data['profilePicture'];
    });
  } else {
    setState(() {
      registerid = '';
      Fname = '';
      Lname = '';
      Level='';
      Profileimage = ''; // Set profilePictureUrl to empty string
    });
  }
}


  Future<void> fetchProfileInfo(String registerID) async {
    print("inside fetchProfileInfo");
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/profileInfo/$registerID');

    try {
       print("insiddddddddddddde fetchProfileInfo");
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse is List && jsonResponse.isNotEmpty) {
          final firstItem = jsonResponse.first;
          print('First Item: $firstItem');

          final fname = firstItem['Fname'];
          final lname = firstItem['Lname'];
          final level = firstItem['Level'];
          
          setState(() {
            Fname = fname;
            Lname = lname;
            Level = level != null ? level.toString() : 'Photographer Level';
          
          });
        } else {
          // Handle unexpected response format
          print('Invalid response format');
        }
      } else {
        // Handle errors or server response based on status code
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  List<Map> items = [];

Future<void> fetchuserItems(String registerID) async {
  print("inside fetchProfileInfo");
  final ipAddress = await getLocalIPv4Address();
  final response = await http.get(Uri.parse('http://$ipAddress:3000/userItems/$registerID'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    setState(() {
      items = data.map((post) {
        return {
          "id": post["_id"],
          "image": post["image"],
          "description": post["description"],
        };
      }).toList();
    });
    print("dfff");
    print(items);
    print('done items fetching');
  } else {print("not workinggggggggggggggggggg :");
    throw Exception('Failed to load user items');
  }
}


  List<Map> slides = [];
  Future<void> fetchuserSlides(String registerID) async {
    print("inside fetchProfileInfo");
    final ipAddress = await getLocalIPv4Address();
    final response = await http
        .get(Uri.parse('http://$ipAddress:3000/userSlides/$registerID'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        slides = data.map((slide) {
          return {
            "id": slide["iditem"],
            "image": slide["image"],
            "title": slide["title"],
            "price": slide["price"],
            "category": slide["CategoryName"],
            "Date": slide["date"],
            "phoneNumber": slide["phoneNumber"],
            "status": slide["status"],
            "description": slide["description"],
            "Fname": slide["Fname"],
            "Lname": slide["Lname"],
          };
        }).toList();
      });
    } else {
      throw Exception('Failed to load furniture items');
    }
  }

  // List<Map<String, dynamic>> _founditems = [];

  Future<bool> checkFavorite(int itemId) async {
    final ipAddress = await getLocalIPv4Address();
    print(ipAddress);
    final apiUrl = 'http://$ipAddress:3000/checkFavorite/$itemId';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['isFavorite'];
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      // Handle exceptions
      print('Exception: $error');
      return false;
    }
  }

  Future<void> deleteitems({
    required String iditem,
    required int index,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/deleteitem');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'iditem': iditem,
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        setState(() {
          setState(() {
            items.removeAt(index); // Remove the item from the list
          });
        });
        print('Deleted successful');
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  List<Map<String, dynamic>> reservedArray = [];

  Future<List<Map<String, dynamic>>> getReserveditem(String iditem) async {
    final ipAddress = await getLocalIPv4Address();
    final String apiUrl = "http://$ipAddress:3000/getReserveditem/$iditem";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse the response body
        List<dynamic> data = json.decode(response.body);

        // Convert the list of dynamic to List<Map<String, dynamic>>
        List<Map<String, dynamic>> reservedarray =
            List<Map<String, dynamic>>.from(data);
        return reservedarray;
      } else {
        throw Exception(
            'Failed to load reserved items. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Provide more meaningful error handling or logging
      print('Error fetching reserved items: $e');
      throw Exception('Failed to load reserved items');
    }
  }

  @override
Widget build(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  double containerWidth = MediaQuery.of(context).size.width;
  double containerHeight = MediaQuery.of(context).size.height;
  final top = containerHeight * 0.14 - profileHeight / 2; // Adjust top position to center profile image

  return Scaffold(
    backgroundColor: themeProvider.isDarkMode ? Colors.black54 : Color(0xFFffffff),
    body: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: () {
                print("indie on tap");
              },
              child: Container(
                height: containerHeight * 0.14,
                width: double.infinity,
                color: const Color.fromARGB(255, 27, 17, 122),
                child: Center(
                  child: buildCoverImage(), // Ensures the cover image is centered
                ),
              ),
            ),
            Positioned(
              
              top: 80.0, // Adjust the top position to center the profile image
              child: GestureDetector(
                onTap: () {
                  print("hi");
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        color: themeProvider.isDarkMode ? Colors.black87 : Colors.white,
                        child: Wrap(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(
                                Icons.photo_library,
                                size: 25,
                                color: const Color.fromARGB(255, 27, 17, 122),
                              ),
                              title: Text(
                                S.of(context).pick_from_gallery,
                                style: TextStyle(
                                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              onTap: () {
                                print("Pick from Gallery");
                                pickProfileImage(ImageSource.gallery);
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.camera_alt,
                                size: 25,
                                color: const Color.fromARGB(255, 27, 17, 122),
                              ),
                              title: Text(
                                S.of(context).take_photo,
                                style: TextStyle(
                                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              onTap: () {
                                print("Take a Photo");
                                pickProfileImage(ImageSource.camera);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                
                child: buildProfileImage(),
              ),

            ),
            
          ],
        ),
        buildContenet(containerWidth, containerHeight, themeProvider),
        buildMyProduct(themeProvider),
       // buildSoftSlides(themeProvider),
      ],
    ),
  );
}


Widget buildCoverImage() => Container(
  width: double.infinity,
  height: double.infinity,
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/coverBack.png"),
      fit: BoxFit.cover, // Ensures the image covers the container
    ),
  ),
);


  Widget buildContenet(double containerWidth, double containerHeight, themeProvider) {
  print("buildContenet called with containerWidth: $containerWidth, containerHeight: $containerHeight");

  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.only(left: 20, top: 55, bottom: 8, right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: containerHeight * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Fname + " " + Lname,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode ? Color(0xFFffffff) : Color(0xFF000000),
                    ),
                  ),
                  Text(
                    Level,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 50),
              GestureDetector(
                onTap: () {
                  print("Edit button tapped");
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => editAccount(
                      fName: Fname,
                      lName: Lname,
                      proficiencyLevel: Level,
                    ),
                  ));
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.edit,
                      size: 30,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Add button tapped");
                  showDialog(
                    context: context,
                    builder: (context) {
                      print("Showing dialog");
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Text(
                                S.of(context).Post_type,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 16),
                            CustomAlertContent(
                              alertText: S.of(context).select_post_type,
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: TextButton(
                                    onPressed: () {
                                      print("Tapped add reel");
                                      Navigator.pop(context); // Close Dialog
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => addReel(),
                                      ));
                                    },
                                    child: Text(
                                      S.of(context).Reels,
                                      style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Center(
                                  child: TextButton(
                                    onPressed: () {
                                      print("Tapped add post");
                                      Navigator.pop(context); // Close Dialog
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => addPost(),
                                      ));
                                    },
                                    child: Text(
                                      S.of(context).Pictures,
                                      style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 0.13 * containerWidth,
            child: Divider(
              thickness: 2,
              color: themeProvider.isDarkMode ? Color(0xFFffffff) : Colors.black45,
            ),
          ),
        ],
      ),
    ),
  );
}



Widget buildProfileImage() {
  loading = false;
  return Container(
    width: profileHeight ,
    height: profileHeight / 2.5,
    color: Colors.grey.shade300,
    child: Stack(
      alignment: Alignment.center,
      children: [
        if (loading)
          CircularProgressIndicator(), // Show a loading indicator
        if (!loading && Profileimage.isEmpty)
          Icon(
            Icons.person,
            size: 100,
            color: Colors.white,
          ),
        if (!loading && Profileimage.isNotEmpty)
          Image.network(
            Profileimage,
            width: double.infinity,
            height: double.infinity,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              }
            },
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              // Handle errors
              return Icon(Icons.error);
            },
          ),
      ],
    ),
  );
}
 

  Widget buildMyProduct(themeProvider) => Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).My_Posts,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                        color: themeProvider.isDarkMode
                            ? Color(0xFFffffff)
                            : Colors.black,
                      ),
                    ),
                    Text(
                      S.of(context).see_all,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: themeProvider.isDarkMode
                            ? Color(0xFFffffff)
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              items.isEmpty
                  ? Center(
                      child: Text(
                        S.of(context).Message_No_post,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: themeProvider.isDarkMode
                              ? Color(0xFFffffff)
                              : Colors.black,
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.73,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        void _showBottomSheet(BuildContext context) {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      20.0), // Adjust the radius as needed
                                  topRight: Radius.circular(20.0),
                                ),
                                child: Container(
                                  color: themeProvider.isDarkMode
                                      ? Colors.black87
                                      : Color(0xFFffffff),
                                  //color: Colors.white,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 18),
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.request_page_rounded,
                                            size: 25,
                                            color: themeProvider.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          title: Text(
                                            S.of(context).Requests,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: themeProvider.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                          onTap: () async {
                                            Navigator.pop(context);
                                            reservedArray =
                                                await getReserveditem(
                                                    items[index]["id"]
                                                        .toString());
                                            print(reservedArray);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NotificationMain(
                                                        reservedArray:
                                                            reservedArray,
                                                        resultReservedArray: [],
                                                        title: S.of(context).Requests,
                                                        fromUserprofiel: false,
                                                      )),
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.edit,
                                            size: 25,
                                            color: themeProvider.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          title: Text(
                                            S.of(context).Edit,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: themeProvider.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                            // Handle Edit action
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => editPost(
                                                  itemTitle: items[index]
                                                      ["description"],
                                                  itemDescription: items[index]
                                                      ["description"],                              
                                                  itemId: items[index]["id"],
                                                  itemImage: items[index]
                                                      ["image"],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.delete,
                                            size: 25,
                                            color: themeProvider.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          title: Text(
                                            S.of(context).Delete,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: themeProvider.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                          onTap: () async {
                                            Navigator.pop(context);
                                            // Handle Delete action
                                            await deleteitems(
                                              iditem:
                                                  items[index]['id'].toString(),
                                              index: index,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }

                        return GestureDetector(
  onTap: () async {
    print("hii");
    
    // final isFavorite =
    //     await checkFavorite(items[index]['iditem']);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EventsDetails(
        itemId: items[index]["id"],
       // itemId: items[index]['_id'],
        eventss: items,
        isFavorite: false,
        isReserved: false,
        showNavBar: false,
        gotoFav: false,
      ),
    ));
  },
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Stack(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(
                    items[index]['image'],
                  ),
                  fit: BoxFit.cover,
                  height: 500,
                  width: double.infinity,
                ),
              ),
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    items[index]['description'],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode
                          ? Color(0xFFffffff)
                          : Colors.black,
                    ),
                  ),
                  // Text(
                  //   '₪${items[index]['price']}',
                  //   style: const TextStyle(
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w700),
                  // ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _showBottomSheet(context);
              },
              child: Icon(
                Icons.more_horiz,
                color: themeProvider.isDarkMode
                    ? Color(0xFFffffff)
                    : Colors.black87,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);

                      },
                    ),
            ],
          ),
        ),
      );

  Widget buildSoftSlides(themeProvider) => Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).softcopy_slides,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      color: themeProvider.isDarkMode
                          ? Color(0xFFffffff)
                          : Colors.black,
                    ),
                  ),
                  Text(
                    S.of(context).see_all,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: themeProvider.isDarkMode
                          ? Color(0xFFffffff)
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            slides.isEmpty
                ? Center(
                    child: Text(
                      S.of(context).Message_No_post,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: themeProvider.isDarkMode
                            ? Color(0xFFffffff)
                            : Colors.black,
                      ),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.73,
                    ),
                    itemCount: slides.length,
                    itemBuilder: (context, index) {
                      void _showBottomSheet(BuildContext context) {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    20.0), // Adjust the radius as needed
                                topRight: Radius.circular(20.0),
                              ),
                              child: Container(
                                color: themeProvider.isDarkMode
                                    ? Colors.black87
                                    : Color(0xFFffffff),
                                //color: Colors.white,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.edit,
                                          size: 25,
                                          color: themeProvider.isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        title: Text(
                                          S.of(context).Edit,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: themeProvider.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  editSoftSlides(
                                                itemTitle: slides[index]
                                                    ["title"],
                                                itemPrice: slides[index]
                                                    ["price"],
                                                
                                                itemDescription: slides[index]
                                                    ["description"],
                                                itemId: slides[index]["id"],
                                                itemImage: slides[index]
                                                    ["image"],
                                              ),
                                            ),
                                          );
                                          // Handle Edit action
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.delete,
                                          size: 25,
                                          color: themeProvider.isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        title: Text(
                                          S.of(context).Delete,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: themeProvider.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        onTap: () async {
                                          Navigator.pop(context);
                                          // Handle Delete action
                                          await deleteitems(
                                            iditem:
                                                slides[index]['iditem'].toString(),
                                            index: index,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }

                      return GestureDetector(
                        onTap: () async {
                          print("hii");
                          print(slides);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    //color: Color.fromARGB(255, 27, 17, 122).withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.asset(
                                            "assets/pdf.png",
                                            fit: BoxFit.cover,
                                            height: 160,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      slides[index]['title'],
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: themeProvider.isDarkMode
                                            ? Color(0xFFffffff)
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      _showBottomSheet(context);
                                    },
                                    child: Icon(
                                      Icons.more_horiz,
                                      //color: Colors.black87,
                                      color: themeProvider.isDarkMode
                                          ? Color(0xFFffffff)
                                          : Colors.black87,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ]),
        ),
      );
}
