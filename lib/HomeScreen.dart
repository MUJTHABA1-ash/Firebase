import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled10/auth_service.dart';
import 'package:untitled10/create_task.dart';
import 'package:untitled10/toast.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final ref = FirebaseDatabase.instance.ref("data");

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
              padding: EdgeInsets.only(left: 45.w),
              child: Text(
                "Real Time Data",
                style: GoogleFonts.merriweather(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          Expanded(
              child: StreamBuilder(
                  stream: ref.onValue,
                  builder: (BuildContext context,
                      AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text("Error"));
                    }
                    if (snapshot.hasData) {
                      Map<dynamic, dynamic> map =
                          snapshot.data!.snapshot.value as dynamic;
                      print("hi" + map.values.toString());
                      return ListView.builder(
                        itemCount: snapshot.data!.snapshot.children.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            tileColor: Colors.pink,
                            title: Text(
                              map.values.toList()[index]["title"].toString(),
                              style: GoogleFonts.breeSerif(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            trailing: Wrap(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    opendailoge(
                                        index: index,
                                        id: map.values
                                            .toList()[index]["id"]
                                            .toString(),
                                        snapshot: snapshot);
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 15.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ref
                                        .child(map.values
                                            .toList()[index]["id"]
                                            .toString())
                                        .remove();
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 15.sp,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return SizedBox();
                    }
                  })),
          Padding(
            padding: EdgeInsets.only(left: 300.w, bottom: 20.h),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => CreateTask()));
              },
              backgroundColor: Colors.pink,
              child: Icon(
                Icons.add,
                size: 20.sp,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future opendailoge(
      {required int index,
      required String id,
      required AsyncSnapshot<DatabaseEvent> snapshot}) async {
    final editpost = TextEditingController();

    final ref = FirebaseDatabase.instance.ref("data");
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
                    .child(id)
                    .update({'title': editpost.text.toString()})
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
