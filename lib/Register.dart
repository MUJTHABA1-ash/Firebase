import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled10/HomeScreen.dart';
import 'package:untitled10/Login.dart';
import 'package:untitled10/toast.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Text(
                    'Welcome back! Glad \nto see you, Again!',
                    style:GoogleFonts.playfairDisplay(textStyle:  TextStyle(
                      color: Colors.white,
                      fontSize: 30.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700,
                    ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35.h,
                ),
                SizedBox(
                  height: 46.h,
                  width: 340.w,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: TextFormField(
                      controller: username,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle:GoogleFonts.lato(textStyle:  TextStyle(
                            color: Color(0xFF6A707C),
                            fontSize: 15.sp,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500,
                          ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r))),
                      validator: (username) {
                        if (username!.isEmpty) {
                          return "Enter Username";
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  height: 46.h,
                  width: 340.w,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: TextFormField(
                      controller: email,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle:GoogleFonts.lato(textStyle:  TextStyle(
                            color: Color(0xFF6A707C),
                            fontSize: 15.sp,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500,
                          ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r))),
                      validator: (Email) {
                        if (Email!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(Email)) {
                          return 'Enter a valid email!';
                        }
                        ;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  height: 46.h,
                  width: 340.w,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: TextFormField(
                      obscureText: true,
                      controller: password,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle:GoogleFonts.lato(textStyle:  TextStyle(
                            color: Color(0xFF6A707C),
                            fontSize: 15.sp,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500,
                          ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r))),
                      validator: (Pass) {
                        if (Pass!.isEmpty || Pass.length < 6) {
                          return "minimum 6 letters";
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  height: 46.h,
                  width: 340.w,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: TextFormField(
                      obscureText: true,
                      controller: confirmpass,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: 'Confirm password',
                          labelStyle:GoogleFonts.lato(textStyle:  TextStyle(
                            color: Color(0xFF6A707C),
                            fontSize: 15.sp,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500,
                          ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r))),
                      validator: (confirmpassword) {
                        if (confirmpassword!.isEmpty ||
                            password.text != confirmpass.text) {
                          return "enter same password";
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: GestureDetector(
                    onTap: () {
                      final isValid = _formKey.currentState!.validate();
                      if (isValid) {
                        auth
                            .createUserWithEmailAndPassword(
                                email: email.text.toString(),
                                password: password.text.toString())
                            .then((value) => {
                                  ToastMessage().toastmessage(
                                      message: 'Successfully registerd'),
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => Homescreen())),
                          CheckLogin()
                                })
                            .onError((error, stackTrace) => ToastMessage()
                                .toastmessage(message: error.toString()));
                      }
                      _formKey.currentState?.save();
                    },
                    child: Container(
                      width: 320.w,
                      height: 46.h,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                      ),
                      child: Center(
                        child: Text(
                          'Agree and Register',
                          textAlign: TextAlign.center,
                          style:GoogleFonts.inter(textStyle:  TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Row(
                    children: [
                      Container(
                        width: 113.66.w,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1.w,
                              color: Color(0xFFE8ECF4),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'Or Login with',
                        style: GoogleFonts.lato(textStyle: TextStyle(
                          color: Color(0xFF6A707C),
                          fontSize: 14.sp,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Container(
                        width: 113.66.w,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1.w,
                              color: Color(0xFFE8ECF4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 70.w),
                  child: Row(
                    children: [
                      Container(
                        width: 105.w,
                        height: 56.h,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.w, color: Color(0xFFDADADA)),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Image.asset(
                          "assets/ggl.png",
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Container(
                        width: 105.w,
                        height: 56.h,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.w, color: Color(0xFFDADADA)),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Image.asset(
                          "assets/call.png",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void CheckLogin() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("Token", true);
  }
}
