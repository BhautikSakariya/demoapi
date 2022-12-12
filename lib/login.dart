import 'dart:convert';

import 'package:demoapi/home.dart';
import 'package:demoapi/model.dart';
import 'package:demoapi/ragister.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController tusername = TextEditingController();
  TextEditingController tpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 60,
                width: double.infinity,
                padding: EdgeInsets.all(8),
                child: Center(child: Text("Login",style: TextStyle(fontSize: 30,color: Colors.black),))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: tusername,
                  decoration: InputDecoration(
                      hintText: "Enter Email or Contact",
                      labelText: "Username",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10))))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: tpassword,
                  decoration: InputDecoration(
                      hintText: "Enter Password",
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10))))),
            ),
            InkWell(
                onTap: () async {
                  String username = tusername.text;
                  String password = tpassword.text;
                  String api = "https://bhautiksakariya.000webhostapp.com/Bhautik/login.php?username=$username&password=$password";

                  var response = await Dio().get(api);

                  if(response.statusCode==200)
                    {
                        Map map = jsonDecode(response.data);

                        int result = map['result'];

                        if(result==1)
                          {
                            await model.prefs!.setBool('loginstatus', true);

                            Map data = map['data'];

                            String id        = data['id'];
                            String name      = data['name'];
                            String email     = data['email'];
                            String contact   = data['contact'];
                            String password  = data['password'];
                            String imagepath = data['imagepath'];


                            await model.prefs!.setString('id', id);
                            await model.prefs!.setString('name', name);
                            await model.prefs!.setString('email', email);
                            await model.prefs!.setString('contact', contact);
                            await model.prefs!.setString('password', password);
                            await model.prefs!.setString('imagepath', imagepath);

                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                              return homepage();
                            },));
                          }
                        else
                          {
                            setState(() {
                              Fluttertoast.showToast(
                                  msg: "User Not Found",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            });
                          }


                    }








                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Text("Login"),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                )),
            Container(
              height: 60,
              width: double.infinity,
              child: Center(
                  child: Container(

                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return ragister();
                      },
                    ));
                  },
                  child: Text("Ragister",
                      style: TextStyle(
                          color: Color(0xFF092048),
                          decoration: TextDecoration.underline,
                          fontSize: 18)),
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
