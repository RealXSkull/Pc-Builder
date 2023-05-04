// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, prefer_final_fields, unnecessary_new, use_key_in_widget_constructors, avoid_print, non_constant_identifier_names, sized_box_for_whitespace, must_call_super, unnecessary_import, depend_on_referenced_packages, dead_code, unnecessary_null_comparison, prefer_conditional_assignment

// import 'package:fyp/LoginScreen.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/admin/screens/AdminRights.dart';
import 'package:fyp/admin/screens/Orders.dart';
import 'package:fyp/admin/screens/complaints.dart';
import 'package:fyp/user/Screens/SearchScreen.dart';
import 'package:fyp/admin/screens/inventory.dart';
import '../../user/classes/CardItem.dart';
import 'package:fyp/user/Bars/NavBar.dart';
import '../../user/classes/images.dart';
import '../../user/classes/global.dart' as global;

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class HomePage {
  String title;
  String icon;
  Color color;
  Function func;
  HomePage(this.title, this.icon, this.color, this.func);
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  // CollectionReference cf = FirebaseFirestore.instance.collection('Inventory');
  // DatabaseReference postListRef = FirebaseDatabase.instance.ref("Inventory");

  // void tryprintdata() {
  //   global.inventory['Item Name'] = postListRef;
  //   print('Item Name is: ${global.inventory['Item Name']}');
  //   // print('Inventory $postListRef');
  // }

  @override
  void initState() {
    super.initState();
    global.readdata(user);
    global.inventory = global.getcategory(context);

    // global.getinvo();
    fetchimage();
    //getdata();
    // tryprintdata();
  }

  // void getdata() {
  //   cf.doc().get().then(
  //     (value) {
  //       setState(() {
  //         global.inventory['Item Name'] = value.data();
  //         // ['Item Name']
  //       });
  //     },
  //   );
  //   print(global.inventory['Item Name']);
  // }

  // final data_controller controller = Get.put(data_controller());

  User user = FirebaseAuth.instance.currentUser!;

  // String name = "";
  List<CardItem> item = [
    CardItem(
        image: 'assets/icons/all_icon.jpg', title: 'ALL', subtitle: '\$100'),
    CardItem(
        image: 'assets/icons/all_icon.jpg', title: 'ALL', subtitle: '\$100'),
    CardItem(
        image: 'assets/icons/all_icon.jpg', title: 'ALL', subtitle: '\$100'),
    CardItem(
        image: 'assets/icons/all_icon.jpg', title: 'ALL', subtitle: '\$100'),
    CardItem(
        image: 'assets/icons/all_icon.jpg', title: 'ALL', subtitle: '\$100'),
    CardItem(
        image: 'assets/icons/all_icon.jpg', title: 'ALL', subtitle: '\$100'),
  ];
  Widget uploaditembtn() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => inventory()));
      },
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[350],
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Upload Item',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Icon(Icons.upload_file)
          ],
        ),
      ),
    );
  }

  Widget FetchComplaintsbtn() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Complaints()));
      },
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[350],
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Warranty Claims',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Icon(Icons.report)
          ],
        ),
      ),
    );
  }

  Widget Ordersbtn() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Orders()));
      },
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[350],
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Orders',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Icon(Icons.shopping_basket)
          ],
        ),
      ),
    );
  }

  Widget AdminRightsbtn() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AdminRights()));
      },
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[350],
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'Admin\nRights',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Icon(Icons.admin_panel_settings)
          ],
        ),
      ),
    );
  }

  Widget Searchbar() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(5)),
      child: TextField(
        decoration: const InputDecoration(
            border: InputBorder.none,
            suffixIcon: Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            hintText: 'Search Anything..',
            hintStyle: TextStyle(color: Colors.grey)),
        textInputAction: TextInputAction.search,
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
      ),
    );
  }

  // List<int> data = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1];
  Widget Buildcards(CardItem item) => Container(
        width: 200,
        child: Column(
          children: [
            Expanded(
                child: AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.asset(
                item.image,
                fit: BoxFit.cover,
              ),
            )),
            Text(
              item.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              item.subtitle,
              style: TextStyle(fontSize: 12, color: Colors.red),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.pink,
        drawer: NavBar(),
        appBar: AppBar(
          title: Text('Home Page'),
          backgroundColor: Color.fromARGB(255, 48, 10, 55),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => const inventory()),
          //         );
          //       },
          //       icon: Icon(Icons.inventory)),
          // ],
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xfff7f7f7),
                ),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Searchbar(),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Text(
                            "Categories",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          AspectRatio(
                            aspectRatio: 6 / 3,
                            child: Swiper(
                              autoplay: true,
                              // itemWidth: 250,
                              itemCount: cards.length,
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image(
                                    image: AssetImage(cards[index]),
                                    fit: BoxFit.fill,
                                  ),
                                );
                                // OnTap(index) {
                                //   // Navigator.push(
                                //   //     context,
                                //   //     MaterialPageRoute(
                                //   //         builder: (context) => Review()));
                                // }
                              },
                              viewportFraction: 0.8,
                              scale: 0.8,
                              pagination: SwiperPagination(),
                              // itemWidth: 500,
                              // layout: SwiperLayout.STACK,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 28.0,
                          runSpacing: 14,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            uploaditembtn(),
                            FetchComplaintsbtn(),
                            Ordersbtn(),
                            AdminRightsbtn(),
                            Ordersbtn(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future fetchimage() async {
    final ref =
        FirebaseStorage.instance.ref().child("DisplayPicture").child(user.uid);
    try {
      if (global.url == "") global.url = await ref.getDownloadURL();
      // global.img = Image(image: NetworkImage(global.url));
    } catch (e) {
      if (global.url == "") {
        global.url =
            "https://firebasestorage.googleapis.com/v0/b/pc-builder-2c0a4.appspot.com/o/DisplayPicture%2Fdefaultimage.jpg?alt=media&token=af41bdaf-f5f4-4f0d-ad96-78734f8eb73a";
        print("${global.url} \n defauly image");
      } //  global.img = Image(image: NetworkImage(global.url));
    }
    // print(" this is done ${global.topUserPostsRef}");
    // print(global.url);
    // print(user.uid);
  }
}
