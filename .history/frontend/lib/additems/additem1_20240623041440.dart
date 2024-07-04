import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/additems/CustomItemname_tx.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/settingpage/theme/theme_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddItem1 extends StatefulWidget {
  const AddItem1({
    super.key,
    required this.containerWidth,
    required this.containerHeight,
    required GlobalKey<FormState> formKey,
    required TextEditingController itemnameController,
    required this.imagepicker,
  })  : _formKey = formKey,
        _itemnameController = itemnameController;

  final double containerWidth;
  final double containerHeight;
  final GlobalKey<FormState> _formKey;
  final TextEditingController _itemnameController;
  final Function(File) imagepicker;

  @override
  State<AddItem1> createState() => _AddItem1State();
}

class _AddItem1State extends State<AddItem1> {
  File? image;
  bool showFilterImage = false;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        widget.imagepicker(imageTemporary);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    color: themeProvider.isDarkMode ? Colors.black87 : Colors.white,
                    child: Wrap(
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.photo_library, size: 25, color: Color.fromARGB(255, 27, 17, 122)),
                          title: Text(
                            S.of(context).pick_from_gallery,
                            style: TextStyle(
                              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          onTap: () {
                            pickImage(ImageSource.gallery);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.camera_alt, size: 25, color: Color.fromARGB(255, 27, 17, 122)),
                          title: Text(
                            S.of(context).take_photo,
                            style: TextStyle(
                              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          onTap: () {
                            pickImage(ImageSource.camera);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: DottedBorder(
              dashPattern: const [20, 12, 12, 20],
              borderType: BorderType.Rect,
              radius: const Radius.circular(10),
              padding: const EdgeInsets.all(6),
              strokeWidth: 1,
              color: Colors.grey.shade500,
              child: Container(
                padding: const EdgeInsets.all(20),
                width: widget.containerWidth * 1.15,
                height: widget.containerHeight * 1.5,
                child: Stack(
                  children: [
                    if (image != null)
                      Image.file(
                        image!,
                        width: widget.containerWidth * 1.15,
                        height: widget.containerHeight * 1.5,
                        fit: BoxFit.cover,
                      )
                    else
                      Column(
                        children: [
                          const Icon(
                            Icons.image_rounded,
                            size: 100,
                            color: Color.fromARGB(255, 27, 17, 122),
                          ),
                          Text(
                            S.of(context).add_image,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            S.of(context).remove_image,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    if (showFilterImage)
                      Positioned.fill(
                        child: Image.asset(
                          'assets/web/filter.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    if (image != null)
                      Positioned(
                        top: -8,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              image = null;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black.withOpacity(0.5),
                            ),
                            child: const Icon(
                              Icons.close_rounded,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showFilterImage = !showFilterImage;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: const Icon(
                            Icons.filter,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Form(
            width:23
            key: widget._formKey,
            child: Column(
              children: <Widget>[
                ItemNameTextField(
                  itemName: S.of(context).post_description,
                  controller: widget._itemnameController,
                ),
                 const SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
