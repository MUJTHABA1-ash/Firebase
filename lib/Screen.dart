import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled10/create_task.dart';
import 'package:untitled10/toast.dart';

import 'Screen2.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  final editpost = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('data').snapshots();
  final ref =FirebaseFirestore.instance.collection('data');

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
              padding: EdgeInsets.only(left: 60.w),
              child: Text(
                "Fire Store",
                style: GoogleFonts.merriweather(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 25.sp),
                ),
              ),
            ),
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: firestore,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('error'),
                      );
                    }
                    if (snapshot.hasData) {
                      return
                      ListView.builder(
                        itemCount:snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            tileColor: Colors.pink,
                            title: Text(
                                    snapshot.data!.docs[index]['title'].toString(),
                              style: GoogleFonts.breeSerif(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 15.sp),
                              ),
                            ),
                            trailing: Wrap(
                              children: [
                                GestureDetector(onTap: (){
                                  opendailoge(index: index, id: snapshot.data!.docs[index].id.toString(), snapshot: snapshot);
                                },
                                  child: Icon(
                                    Icons.edit,
                                    size: 16.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                GestureDetector(onTap: (){
                                  ref.doc(snapshot.data!.docs[index]["id"].toString()).delete();
                                },
                                  child: Icon(
                                    Icons.delete,
                                    size: 16.sp,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                    else{
                      return SizedBox();
                    }
                  })),
          Padding(
            padding: EdgeInsets.only(left: 300.w, bottom: 10.h),
            child: FloatingActionButton(
                backgroundColor: Colors.pink,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => Screen2()));
                }),
          )
        ],
      ),
    );
  }

  Future opendailoge(
      {required int index,
      required String id,
      required AsyncSnapshot<QuerySnapshot> snapshot}) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Here'),
        content: TextFormField(
          controller: editpost,
          textInputAction: TextInputAction.next,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
              filled: true,
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              fillColor: Color(0xFFF7F8F9),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8)),
              hintText: 'Type here',
              hintStyle:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
              labelStyle: GoogleFonts.poppins(
                color: Color(0xFF7C7C7C),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 0.10,
              )),
          validator: (email) {
            if (email!.isEmpty) {
              return 'Enter something';
            }
            return null;
          },
        ),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.black)),
              onPressed: () {
                ref
                    .doc(snapshot.data!.docs[index]["id"].toString())
                    .update({"title": editpost.text.toString()})
                    .then(
                      (value) => {
                        ToastMessage()
                            .toastmessage(message: 'Edited Succesfull'),
                        editpost.clear(),
                        Navigator.pop(context),
                      },
                    )
                    .onError(
                      (error, stackTrace) => ToastMessage()
                          .toastmessage(message: error.toString()),
                    );
              },
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
