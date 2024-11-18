import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled10/HomeScreen.dart';
import 'package:untitled10/Screen.dart';

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            AppBar(
              backgroundColor: Colors.pink,
              title: Padding(
                padding: EdgeInsets.only(left: 80.w),
                child: Text(
                  "DATAS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 190.h,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => Homescreen()));
                },
                child: Container(
                  height: 100.h,
                  width: 300.w,
                  decoration: ShapeDecoration(
                      color: Colors.pink,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r))),
                  child: Center(
                    child: Text(
                      "Real Time",
                      style: GoogleFonts.merriweather(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 30.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Screen()));
              },
              child: Container(
                height: 100.h,
                width: 300.w,
                decoration: ShapeDecoration(
                    color: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r))),
                child: Center(
                  child: Text(
                    "Fire Store",
                    style: GoogleFonts.merriweather(
                      textStyle:
                          TextStyle(color: Colors.white, fontSize: 30.sp),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
