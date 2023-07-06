// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, prefer_final_fields, unnecessary_new, use_key_in_widget_constructors, avoid_print, non_constant_identifier_names, sized_box_for_whitespace, must_call_super, unnecessary_import, depend_on_referenced_packages, dead_code, unnecessary_null_comparison, prefer_conditional_assignment

import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:intl/intl.dart';
import '../../user/Screens/Categoriesdetail.dart';
import 'package:fyp/user/Bars/NavBar.dart';
import '../../user/Screens/itemdetail.dart';
import '../../user/classes/global.dart' as global;
import 'Editinvo.dart';

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
  List<dynamic> cardsData = [];
  @override
  void initState() {
    super.initState();
    global.readdata(user);
    fetchData();
    fetchimage();
  }

  Future<void> fetchData() async {
    List<dynamic> data = await fetchCardsData();
    setState(() {
      cardsData = data;
    });
  }

  Future<List<dynamic>> fetchCardsData() async {
    List<dynamic> cardsData = [];

    try {
      List<String> categories = await global.getcategory2(context);

      for (String category in categories) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Inventory')
            .where('Category', isEqualTo: category)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          cardsData.add(querySnapshot.docs.first.data());
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
    return cardsData;
  }

  User user = FirebaseAuth.instance.currentUser!;

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
          color: Color.fromARGB(255, 151, 33, 171),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Upload\nItem',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Icon(
              Icons.upload_file,
              color: Colors.white,
            )
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
          color: Color.fromARGB(255, 151, 33, 171),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Warranty Claims',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Icon(
              Icons.report,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget cpubtn() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => cat_detail(
              Category: 'CPU',
            ),
          ),
        );
      },
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color.fromARGB(255, 151, 33, 171),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/cpu.png',
              height: 40,
              width: 40,
            ),
            Text(
              'CPU',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget rambtn() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => cat_detail(
              Category: 'GPU',
            ),
          ),
        );
      },
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color.fromARGB(255, 151, 33, 171),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/gpu.png',
              height: 50,
              width: 50,
            ),
            Text(
              'GPU',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget psubtn() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => cat_detail(
              Category: 'PSU',
            ),
          ),
        );
      },
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color.fromARGB(255, 151, 33, 171),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/psu.png',
              height: 50,
              width: 50,
            ),
            Text(
              'PSU',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget Editinvobtn() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Edit_invo()));
      },
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 151, 33, 171),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edit\nInventory',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Icon(
              Icons.shopping_basket,
              color: Colors.white,
            )
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
          color: Color.fromARGB(255, 151, 33, 171),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Orders',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Icon(
              Icons.shopping_basket,
              color: Colors.white,
            )
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
          color: Color.fromARGB(255, 151, 33, 171),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'Admin\nRights',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Icon(
              Icons.admin_panel_settings,
              color: Colors.white,
            )
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

  Widget swipercards() {
    return Swiper(
        autoplay: true,
        onTap: (index) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => itemdetail(receivedMap: cardsData[index]),
            ),
          );
        },
        itemCount: cardsData.length,
        pagination: SwiperPagination(
            // margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            builder: DotSwiperPaginationBuilder(color: Colors.grey)),
        viewportFraction: 0.95,
        itemBuilder: (context, index) {
          NumberFormat commaFormat = NumberFormat('#,###');
          String formattedNumber =
              commaFormat.format(cardsData[index]['Price']);
          return Card(
            child: Column(
              children: [
                if (cardsData[index]['url'] != null ||
                    cardsData[index]['url'] != "")
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      cardsData[index]['url'],
                      fit: BoxFit.contain,
                      height: 180,
                      width: 180,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        // This builder is called when the image fails to load.
                        // You can return the alternate AssetImage widget here.
                        return Image.asset(
                          'assets/all_icon.jpg',
                          fit: BoxFit.contain,
                          height: 200,
                          width: 200,
                        );
                      },
                    ),
                  ),
                Align(
                  child: Text(
                    cardsData[index]['Item Name'],
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          cardsData[index]['Category'],
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Text(
                          formattedNumber.toString(),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.pink,
        drawer: NavBar(),
        appBar: AppBar(
          title: Text('Home Page'),
          backgroundColor: Color.fromARGB(255, 60, 13, 68),
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
                            aspectRatio: 4 / 3,
                            child: swipercards(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      Divider(thickness: 2),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 28.0,
                          runSpacing: 14,
                          children: [
                            AdminRightsbtn(),
                            FetchComplaintsbtn(),
                            Ordersbtn(),
                            uploaditembtn(),
                            Editinvobtn(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(thickness: 2),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 28.0,
                          runSpacing: 14,
                          children: [
                            cpubtn(),
                            rambtn(),
                            psubtn(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(thickness: 2),
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
      }
    }
  }
}
