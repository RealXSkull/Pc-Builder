// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:fyp/user/Screens/LoginScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Bars/bottomNavBar.dart';

var useridd;

class Signup extends StatefulWidget {
  final VoidCallback onClickedLogin;

  const Signup({
    Key? key,
    required this.onClickedLogin,
  }) : super(key: key);
  @override
  SignupArea createState() => SignupArea();
}

class SignupArea extends State<Signup> {
  User? user = FirebaseAuth.instance.currentUser;
  int maxLength = 11;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  String contactno = "";
  bool obscureTextt = true;
  bool _passwordVisible = false;
  bool _passwordVisible2 = false;
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  final confirmpasscontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailcontroller.dispose();
    passcontroller.dispose();
    confirmpasscontroller.dispose();
    _controller.dispose();
    _namecontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _passwordVisible = false;
    _passwordVisible2 = false;
    super.initState();
  }

  Widget buildname() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Full Name',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all()),
          height: 60,
          child: TextFormField(
            controller: _namecontroller,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == "") {
                return 'Name Cannot be Empty';
              } else {
                return null;
              }
            },
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                border: InputBorder.none,
                errorStyle: TextStyle(height: 0.1),
                prefixIcon: Icon(
                  Icons.person,
                  color: Color(0xff5ac18e),
                ),
                hintText: 'Full Name',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildemail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Email',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(),
              ),
              height: 60,
              child: TextFormField(
                controller: emailcontroller,
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(val!);
                  if (val == "") {
                    return 'Email Cannot be Empty';
                  } else if (!emailValid) {
                    return 'Invalid Email Address';
                  } else {
                    return null;
                  }
                },
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    errorStyle: TextStyle(height: 0.1),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color(0xff5ac18e),
                    ),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.black38)),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget buildpassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Password',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(),
          ),
          height: 60,
          child: TextFormField(
            controller: passcontroller,
            obscureText: !_passwordVisible,
            validator: (value) {
              if (value == "") {
                return 'Field Cannot be left Empty';
              } else if (value.toString().length < 6) {
                return 'Enter Minimum 6 characters';
              } else {
                return null;
              }
            },
            style: const TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Color(0xff5ac18e),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                hintText: 'Password',
                errorStyle: const TextStyle(height: 0.1),
                hintStyle: const TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildconfirmpassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Confirm Password',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(),
          ),
          height: 60,
          child: TextFormField(
            controller: confirmpasscontroller,
            obscureText: !_passwordVisible2,
            validator: (value) {
              if (value == "") {
                return 'Field Cannot be left Empty';
              } else if (value.toString().length < 6) {
                return 'Enter Minimum 6 characters';
              } else if (value != passcontroller.text) {
                return 'Password Doesnot Match';
              } else {
                return null;
              }
            },
            style: const TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Color(0xff5ac18e),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible2 ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible2 = !_passwordVisible2;
                    });
                  },
                ),
                hintText: 'Retype Password',
                errorStyle: const TextStyle(height: 0.1),
                hintStyle: const TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildphone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Contact No.',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(),
          ),
          height: 60,
          child: TextField(
            controller: _controller,
            onChanged: (String newVal) {
              if (newVal.length <= maxLength) {
                contactno = newVal;
              } else {
                _controller.text = contactno;
              }
            },
            // maxLength: 11,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.phone,
                  color: Color(0xff5ac18e),
                ),
                hintText: '03xx-xxxxxxx',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget alreadyaccountbtn() {
    return Container(
      padding: const EdgeInsets.only(left: 60.0),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Already an account? ",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          RichText(
            text: TextSpan(
              recognizer: TapGestureRecognizer()..onTap = widget.onClickedLogin,
              text: 'LOGIN',
              style: const TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget registerbtn() {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.lightBlue),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ))),
          child: const Text('Register'),
          onPressed: () {
            signup();
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('REGISTRATION'),
          backgroundColor: const Color.fromARGB(255, 48, 10, 55),
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Form(
            key: formkey,
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(247, 247, 247, 1),
                  ),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromARGB(255, 11, 4, 109),
                          ),
                          child: const Image(
                            image: AssetImage('assets/Pc_builder_logo.png'),
                            height: 180,
                            width: double.infinity,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        buildname(),
                        const SizedBox(
                          height: 15,
                        ),
                        buildemail(),
                        const SizedBox(
                          height: 20,
                        ),
                        buildpassword(),
                        const SizedBox(
                          height: 20,
                        ),
                        buildconfirmpassword(),
                        const SizedBox(
                          height: 20,
                        ),
                        registerbtn(),
                        const SizedBox(
                          height: 20,
                        ),
                        alreadyaccountbtn()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future signup() async {
    String name = _namecontroller.text;
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailcontroller.text.trim(),
              password: passcontroller.text);
      await result.user?.updateDisplayName(name);
      final user = FirebaseAuth.instance.currentUser!;
      final docuser =
          FirebaseFirestore.instance.collection('Users').doc(user.uid);
      final data = {
        'Name': name,
        'role': 'user',
        'Email': emailcontroller.text,
        'Address': '',
        'Phone': ''
      };
      await docuser.set(data);
      Fluttertoast.showToast(msg: 'Signup Succesful!');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainMenu(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.BOTTOM);
    }
    // Navigator.pop(context);
  }
}
