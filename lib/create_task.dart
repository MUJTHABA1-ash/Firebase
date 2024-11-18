import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled10/Forgetpassword.dart';
import 'package:untitled10/toast.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController post = TextEditingController();
  final database = FirebaseDatabase.instance.ref("data");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            backgroundColor: Colors.pink,
            title: Padding(
              padding:  EdgeInsets.only(left: 55.w),
              child: Text(
                "Create Tasks",
                style:GoogleFonts.merriweather(textStyle:  TextStyle(
                    fontSize: 25.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              ),
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          Center(
            child: SizedBox(
              height: 40.h,
              width: 280.w,
              child: TextFormField(
                controller: post,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'CreateTask',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r))),
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                final id = DateTime.now().microsecondsSinceEpoch.toString();
                database
                    .child(id)
                    .set({"id": id, "title": post.text.toString()}).then(
                  (value) {
                    ToastMessage().toastmessage(message: "successfully");
                    post.clear();
                    Navigator.pop(context);
                  },
                ).onError(
                  (error, stackTrace) {
                    ToastMessage().toastmessage(message: error.toString());
                  },
                );
              },
              child: Container(
                height: 30.h,
                width: 100.w,
                decoration: ShapeDecoration(
                    color: Colors.pink,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r))),
                child: Center(
                  child: Text(
                    "Create",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}