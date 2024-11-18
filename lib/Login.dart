import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled10/First.dart';
import 'package:untitled10/Forgetpassword.dart';
import 'package:untitled10/HomeScreen.dart';
import 'package:untitled10/Phone_verification.dart';
import 'package:untitled10/Register.dart';
import 'package:untitled10/auth_service.dart';
import 'package:untitled10/toast.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final Formkey = GlobalKey<FormState>();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signinwithgoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn
          .signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!
          .authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken
      );

      final UserCredential userCredential = await auth.signInWithCredential(
          credential);
      final User? user = userCredential.user;
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => Homescreen()));
        ToastMessage().toastmessage(message: 'succusfully completed');
      }
    } catch (e) {
      ToastMessage().toastmessage(message: e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
            child: Form(
              key: Formkey,
              child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 20.sp,
                    color: Colors.white,
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
                  height: 37.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: SizedBox(
                    height: 46.h,
                    width: 310.w,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: email,
                      decoration: InputDecoration(
                          labelText: 'Enter your email',
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
                            !RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(Email)) {
                          return 'Enter a valid email!';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: SizedBox(
                    height: 46.h,
                    width: 310.w,
                    child: TextFormField(
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      controller: password,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.remove_red_eye),
                          labelText: 'Enter your password',
                          labelStyle:GoogleFonts.lato(textStyle:  TextStyle(
                            color: Color(0xFF6A707C),
                            fontSize: 15.sp,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500,
                          ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r))),
                      validator: (pass) {
                        if (pass!.isEmpty || pass.length < 6) {
                          return 'Minimum 6 letters';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 200.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => Forgetpassword()));
                    },
                    child: Text(
                      'Forgot Password?',
                      textAlign: TextAlign.right,
                      style: GoogleFonts.breeSerif(textStyle: TextStyle(
                        color: Color(0xFF6A707C),
                        fontSize: 14.sp,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: GestureDetector(
                    onTap: () {
                      if (Formkey.currentState!.validate()) {
                        auth
                            .signInWithEmailAndPassword(
                            email: email.text, password: password.text)
                            .then(
                              (value) =>
                          {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => First()))
                          },
                        )
                            .onError((error, stackTrace) =>
                            ToastMessage()
                                .toastmessage(message: error.toString()));
                      }
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
                          'Login',
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
                        style:GoogleFonts.lato(textStyle:  TextStyle(
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
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 60.w),
                  child: Row(
                    children: [
                      GestureDetector(onTap: () {
                        signinwithgoogle();
                        AuthService().signInWithGoogle(context);
                      },
                        child: Container(
                          width: 105.w,
                          height: 56.h,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.w, color: Color(0xFFDADADA)),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Image.asset("assets/ggl.png"),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Container(
                        width: 105.w,
                        height: 56.h,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.w, color: Color(0xFFDADADA)),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => PhoneVerification()));
                            },
                            child: Image.asset("assets/call.png")),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50.w),
                  child: Row(
                    children: [
                      Text(
                        "Don’t have an account? ",
                        style:GoogleFonts.inter(textStyle:  TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w500,
                        ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: ((_) => Register())));
                        },
                        child: Text(
                          'Register Now',
                          style:GoogleFonts.inter(textStyle:  TextStyle(
                            color: Color(0xFF34C2C1),
                            fontSize: 15.sp,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            )),
      ),
    );
  }
  void CheckLogin() async{
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("Token", true);
  }
}