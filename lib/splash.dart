import 'package:demoapi/home.dart';
import 'package:demoapi/login.dart';
import 'package:demoapi/model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    next();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Loading..."),),
    );
  }

   next() async {
     model.prefs = await SharedPreferences.getInstance();
     await Future.delayed(Duration(seconds: 2));

     bool? loginstatus = model.prefs!.getBool('loginstatus') ?? false;

     if (loginstatus) {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
         return homepage();
       },));
     }
     else
       {
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
           return loginpage();
         },));
       }

   }


}
