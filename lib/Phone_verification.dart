import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled10/HomeScreen.dart';
import 'package:untitled10/Otp_verfication.dart';
import 'package:untitled10/toast.dart';

class PhoneVerification extends StatefulWidget {
  const PhoneVerification({super.key});

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  TextEditingController phone = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final Formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Form(
          key: Formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: Container(
                    width: 41.w,
                    height: 41.h,
                    decoration: ShapeDecoration(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.w, color: Colors.white),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  'Phone Verification',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.sp,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  "Please enter the Phone Number linked\nwith your account.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: SizedBox(
                  height: 50.h,
                  width: 300.w,
                  child: TextFormField(
                    controller: phone,
                    style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.datetime,
                    maxLength: 10,
                    decoration: InputDecoration(
                        labelText: 'Enter your phone number',
                        prefix: Text("+91 "),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r))),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: GestureDetector(
                  onTap: () {
                    auth.verifyPhoneNumber(
                      phoneNumber:  "+91${phone.text.toString()}",
                        verificationCompleted: (_) {},
                        verificationFailed: (error) {
                          ToastMessage()
                              .toastmessage(message: error.toString());
                        },
                        codeSent: (String verificationId, int? token) async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => OtpVerfication()));
                        },
                        codeAutoRetrievalTimeout: (error) {
                          ToastMessage()
                              .toastmessage(message: error.toString());
                        });
                  },
                  child: Container(
                    width: 300.w,
                    height: 40.h,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                    ),
                    child: Center(
                      child: Text(
                        'Send Code',
                        style: TextStyle(
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
            ],
          ),
        ),
      ),
    );
  }
}
