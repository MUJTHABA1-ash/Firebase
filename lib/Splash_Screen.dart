import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled10/HomeScreen.dart';
import 'package:untitled10/Login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2),() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.containsKey("token")){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>Homescreen()),(route)=> false);
      }else{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>Login()),(route)=> false);
      }
    });
    return Scaffold(
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

        ],
      ),
    );
  }
}
