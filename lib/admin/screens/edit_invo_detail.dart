// ignore_for_file: unused_local_variable, avoid_print, prefer_const_constructors, camel_case_types, sized_box_for_whitespace, non_constant_identifier_names, unnecessary_null_comparison, prefer_typing_uninitialized_variables, use_build_context_synchronously, must_be_immutable, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fyp/user/classes/global.dart' as globals;
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:insta_assets_picker_demo/widgets/crop_result_view.dart';

var image;

class Edit_invo_detail extends StatefulWidget {
  Map<String, dynamic> receivedMap;

  Edit_invo_detail({required this.receivedMap});
  @override
  State<Edit_invo_detail> createState() => _Edit_invo_detailState();
}

class _Edit_invo_detailState extends State<Edit_invo_detail> {
  final picker = ImagePicker();
  bool _imageselected = false;
  PlatformFile? pickedFile;
  final category = TextEditingController();
  late TextEditingController ItemName;
  late TextEditingController desc1;
  late TextEditingController desc2;
  late TextEditingController desc3;
  late TextEditingController price;
  late TextEditingController invo;

  List<String> dropdownvaluelist = [];
  var image;
  String dropdownvalue = '';
  bool dropvisible = false;
  bool light0 = false;
  List<List<dynamic>> data = [];
  final formkey = GlobalKey<FormState>();
  String? FilePath;
  Future<List<String>>? _futureItems;
  @override
  void dispose() {
    super.dispose();
    category.dispose();
    ItemName.dispose();
    desc1.dispose();
    desc3.dispose();
    desc2.dispose();
    invo.dispose();

    price.dispose();
  }

  @override
  void initState() {
    super.initState();
    dropdownvalue = widget.receivedMap['Category'];
    String initialItemName = widget.receivedMap['Item Name'];
    String initialdesc1 = widget.receivedMap['desc1'];
    String initialdesc2 = widget.receivedMap['desc2'];
    String initialdesc3 = widget.receivedMap['desc3'];
    String initialprice = widget.receivedMap['Price'].toString();
    String initialinvo = widget.receivedMap['Inventory'].toString();
    ItemName = TextEditingController(text: initialItemName);
    desc1 = TextEditingController(text: initialdesc1);
    desc2 = TextEditingController(text: initialdesc2);
    price = TextEditingController(text: initialprice.toString());
    invo = TextEditingController(text: initialinvo.toString());
    desc3 = TextEditingController(text: initialdesc3);
    _futureItems = globals.getcategory2(context);
    // assignitems();
  }

  // void assignitems() async {
  //   dropdownvaluelist = widget.receivedMap['Category'];
  // }

  Future upload() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;
    Reference reff =
        FirebaseStorage.instance.ref().child('Inventory').child(ItemName.text);
    if (dropvisible == false) {
      try {
        Reference reff = FirebaseStorage.instance
            .ref()
            .child('Inventory')
            .child(ItemName.text);
        if (image != null) await reff.putFile(image);

        final ref = FirebaseStorage.instance
            .ref()
            .child("Inventory")
            .child(ItemName.text);
        String imgurl = await ref.getDownloadURL();
        // if (name != null) {
        final docuser = FirebaseFirestore.instance
            .collection('Inventory')
            .doc(ItemName.text);
        if (_imageselected == false) {
          imgurl = widget.receivedMap['url'];
        }
        if (imgurl == null || imgurl == "") {
          imgurl = "";
        }
        final data = {
          'url': imgurl,
          // 'url2': imgref,
          'Category': dropdownvalue,
          'Item Name': ItemName.text,
          'Inventory': int.parse(invo.text),
          'Price': int.parse(price.text),
          'desc1': desc1.text,
          'desc2': desc2.text,
          'desc3': desc3.text,
        };
        await docuser.set(data);

        // }

        // Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Item Has Been Updated!')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    } else {
      try {
        if (image != null) await reff.putFile(image);
        final ref = FirebaseStorage.instance
            .ref()
            .child("Inventory")
            .child(ItemName.text);
        String imgurl = await ref.getDownloadURL();
        final docuser = FirebaseFirestore.instance
            .collection('Inventory')
            .doc(ItemName.text);
        final data = {
          'url': imgurl,
          // 'url2': imgref,
          'Category': category.text,
          'Item Name': ItemName.text,
          'Inventory': int.parse(invo.text),
          'Price': int.parse(price.text),
          'desc1': desc1.text,
          'desc2': desc2.text,
          'desc3': desc3.text,
        };
        await docuser.set(data);
        // }

        // Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Item Updated!')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
    Navigator.pop(context);
  }

  Future imagepicker() async {
    final pick = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        image = File(pick.path);
        _imageselected = true;
      } else {}
    });
  }

  Widget selectimage() {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ))),
        label: Text('Select Image'),
        onPressed: () {
          imagepicker();
        },
        icon: Icon(
          Icons.camera_alt_outlined,
          size: 24,
        ),
      ),
    );
  }

  Widget uploadbtn() {
    return Container(
      height: 40,
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ))),
        label: const Text('Update'),
        onPressed: () {
          upload();
        },
        icon: Icon(
          Icons.upload_file,
          size: 24,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('UPDATE INVENTORY'),
          backgroundColor: Color.fromARGB(255, 48, 10, 55),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Form(
            key: formkey,
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(247, 247, 247, 1),
                  ),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Category',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Switch(
                                    value: dropvisible,
                                    onChanged: ((value) {
                                      setState(() {
                                        dropvisible = !dropvisible;
                                      });
                                    })),
                              ],
                            ),
                          ],
                        ),
                        Visibility(
                          visible: !dropvisible,
                          child: SafeArea(child: dropdown()),
                        ),
                        Visibility(
                          visible: dropvisible,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              controller: category,
                              validator: (value) {
                                if (value == "") {
                                  return 'Category Cannot be Empty';
                                } else {
                                  return null;
                                }
                              },
                              style: TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                hintText: 'Category',
                                contentPadding: EdgeInsets.only(left: 14),
                                hintStyle: TextStyle(color: Colors.black38),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Item Name: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            controller: ItemName,
                            validator: (value) {
                              if (value == "") {
                                return 'Item Name Cannot be Empty';
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(color: Colors.black87),
                            decoration: InputDecoration(
                              hintText: 'Item Name',
                              contentPadding: EdgeInsets.only(left: 14),
                              hintStyle: TextStyle(color: Colors.black38),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Description 1:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            controller: desc1,
                            validator: (value) {
                              if (value == "") {
                                return 'Description Cannot be Empty';
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(color: Colors.black87),
                            decoration: InputDecoration(
                              hintText: 'Description 1',
                              contentPadding: EdgeInsets.only(left: 14),
                              hintStyle: TextStyle(color: Colors.black38),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Description 2: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            controller: desc2,
                            validator: (value) {
                              if (value == "") {
                                return 'Description Cannot be Empty';
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(color: Colors.black87),
                            decoration: InputDecoration(
                              hintText: 'Description 2',
                              contentPadding: EdgeInsets.only(left: 14),
                              hintStyle: TextStyle(color: Colors.black38),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Description 3:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            controller: desc3,
                            validator: (value) {
                              if (value == "") {
                                return 'Description Cannot be Empty';
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(color: Colors.black87),
                            decoration: InputDecoration(
                              hintText: 'Description 3',
                              contentPadding: EdgeInsets.only(left: 14),
                              hintStyle: TextStyle(color: Colors.black38),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Price:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            controller: price,
                            validator: (value) {
                              if (value == "") {
                                return 'Price Cannot be Empty';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.black87),
                            decoration: InputDecoration(
                              hintText: 'Price /-',
                              contentPadding: EdgeInsets.only(left: 14),
                              hintStyle: TextStyle(color: Colors.black38),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Inventory:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            controller: invo,
                            validator: (value) {
                              if (value == "") {
                                return 'Inventory Cannot be Empty';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.black87),
                            decoration: InputDecoration(
                              hintText: 'Inventory',
                              contentPadding: EdgeInsets.only(left: 14),
                              hintStyle: TextStyle(color: Colors.black38),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Image',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        if (widget.receivedMap['url'] != "")
                          Visibility(
                            visible: !_imageselected,
                            child: Center(
                              child: ClipRRect(
                                child: Image.network(
                                  widget.receivedMap['url'],
                                  fit: BoxFit.fill,
                                  height: 200,
                                  width: 200,
                                ),
                              ),
                            ),
                          ),
                        if (image != null)
                          Center(
                            child: Visibility(
                              visible: _imageselected,
                              child: ClipRRect(
                                child: Image.file(
                                  image,
                                  fit: BoxFit.fill,
                                  height: 200,
                                  width: 200,
                                ),
                              ),
                            ),
                          ),
                        SizedBox(
                          height: 15,
                        ),
                        selectimage(),
                        SizedBox(
                          height: 15,
                        ),
                        uploadbtn(),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dropdown() {
    return FutureBuilder<List<String>>(
      future: _futureItems,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DropdownButton<String>(
            value: dropdownvalue,
            // value: dropdownvaluelist[0].toString(),
            icon: const Icon(Icons.keyboard_arrow_down),
            items: snapshot.data!.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(fontSize: 20),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
                // dropdownvaluelist[0] = newValue;
              });
            },
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}