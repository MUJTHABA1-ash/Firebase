import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled10/create_task.dart';
import 'package:untitled10/toast.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  final auth = FirebaseAuth.instance;
  final task = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection("data");
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:     AppBar(
      backgroundColor: Colors.pink,
      title: Padding(
        padding: EdgeInsets.only(left: 50.w),
        child: Text(
          "Create Task",
          style:GoogleFonts.merriweather(textStyle:  TextStyle(
              color: Colors.white,
              fontSize: 25.sp,
              fontWeight: FontWeight.w700),
          ),
        ),
      ),
    ),
      backgroundColor: Colors.black,
      body: Column(
        children: [

          SizedBox(
            height: 50.h,
          ),
          SizedBox(
            height: 50.h,
            width: 290.w,
            child: TextFormField(
              style: TextStyle(
                color: Colors.white
              ),
              controller: task,
              decoration: InputDecoration(
                labelText: "New Task",
                labelStyle: GoogleFonts.breeSerif(textStyle: TextStyle(
                  color: Colors.grey,fontSize: 10.sp,
                ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r)
                )
              ),
              validator: (task){
                if(task!.isEmpty){
                  return "Enter Something";
                }

              },
            ),
          ),

          SizedBox(
            height: 10.h,
          ),
          Center(
            child: GestureDetector(onTap: () {
              final id = DateTime
                  .now()
                  .microsecondsSinceEpoch
                  .toString();
              firestore.doc(id)
                  .set({"id": id, "title": task.text}).then((value) {
                ToastMessage().toastmessage(message: "Task added");
                task.clear;
                Navigator.of(context).pop();
              },).onError((error, stackTrace) {
                ToastMessage().toastmessage(message: error.toString());
              },);},
              child:
              Container(
                height: 30.h,
                width: 150.w,
                decoration: ShapeDecoration(
                    color: Colors.pink,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)
                    )),
                child: Center(
                  child: Text(
                    "Create", style: GoogleFonts.breeSerif(textStyle: TextStyle(
                      color: Colors.white, fontSize: 15.sp
                  ),),
                  ),
                ),
              )
            ),
          ),

        ],
      ),
    );
  }
}
