import 'dart:convert';
import 'dart:io';
import 'package:demoapi/login.dart';
import 'package:demoapi/model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ragister extends StatefulWidget {
  const ragister({Key? key}) : super(key: key);

  @override
  State<ragister> createState() => _ragisterState();
}

class _ragisterState extends State<ragister> {
  TextEditingController name2 = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  String? imagepath;
  String user = "image/user.png";
  bool emailerror = false;
  bool contacterror = false;
  final ImagePicker _picker = ImagePicker();

  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(children: [
          Container(
              height: 60,
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: Center(child: Text("Ragister",style: TextStyle(fontSize: 30,color: Colors.black),))),
          Container(
            width: double.infinity,
            height: 200,
            child: Center(
                child: InkWell(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            title: Text("Select Choice"),
                            children: [
                              ListTile(
                                  onTap: () async {
                                    final XFile? gallary = await _picker
                                        .pickImage(source: ImageSource.gallery);
                                    setState(() {
                                      if (gallary != null) {
                                        setState(() {
                                          imagepath = gallary.path;
                                          Navigator.pop(context);
                                        });
                                      }
                                    });
                                  },
                                  title: Text("Gellary")),
                              ListTile(
                                  onTap: () async {
                                    final XFile? camera = await _picker
                                        .pickImage(source: ImageSource.camera);
                                    setState(() {
                                      if (camera != null) {
                                        setState(() {
                                          imagepath = camera.path;
                                          Navigator.pop(context);
                                        });
                                      }
                                    });
                                  },
                                  title: Text("Camera")),
                            ],
                          );
                        },
                      );
                      setState(() {});
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      child: imagepath != null
                          ? CircleAvatar(
                              backgroundImage: FileImage(File(imagepath!)),
                            )
                          : CircleAvatar(
                              backgroundImage: AssetImage(user),
                            ),
                      decoration: BoxDecoration(shape: BoxShape.circle),
                    ))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: name2,
              decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Enter Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  if (emailerror) {
                    if (value.isNotEmpty) {
                      emailerror = false;
                    }
                  }
                });
              },
              controller: email,
              decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Enter Email",
                  errorText: emailerror ? "Email Already Exist" : null,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  if (contacterror) {
                    if (value.isNotEmpty) {
                      contacterror = false;
                    }
                  }
                });
              },
              controller: mobile,
              decoration: InputDecoration(
                  labelText: "Contact No",
                  hintText: "Enter Contact No",
                  errorText: contacterror ? "Contact Already Exist" : null,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: password,
              decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          InkWell(
            onTap: () async {
              waiting();

              String api =
                  "https://bhautiksakariya.000webhostapp.com/Bhautik/ragister.php";

              String name1 = name2.text;
              String email1 = email.text;
              String password1 = password.text;
              String contact = mobile.text;

              DateTime dt = DateTime.now();
              String imagename =
                  "$name1${dt.year}${dt.month}${dt.day}${dt.hour}${dt.minute}${dt.second}.jpg";

              var formData = FormData.fromMap({
                'name': name1,
                'email': email1,
                'password': password1,
                'contact': contact,
                'file': await MultipartFile.fromFile(imagepath!,
                    filename: imagename),
              });
              var response = await Dio().post(api, data: formData);
              Navigator.pop(context);
              print("Response: ${response.statusCode}");
              if (response.statusCode == 200) {
                print("Response: ${response.data}");
                Map map = jsonDecode(response.data);
                int result = map['result'];
                if (result == 0) {
                  setState(() {
                    Fluttertoast.showToast(
                        msg: "Try Again!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  });
                } else if (result == 1) {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return loginpage();
                    },
                  ));
                } else if (result == 2) {
                  setState(() {
                    Fluttertoast.showToast(
                        msg: "Email or Contact is Already Exist",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    contacterror = true;
                  });
                } else if (result == 3) {
                  setState(() {
                    Fluttertoast.showToast(
                        msg: "Email or Contact is Already Exist",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    emailerror = true;
                  });
                }
              } else {
                setState(() {
                  Fluttertoast.showToast(
                      msg: "Try Again!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                });
              }
            },
            child: Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: 100,
              child: Center(
                child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("Ragister")),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  waiting() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            Container(
              height: 60,
              child: ListTile(
                leading: Container(
                    height: 50, width: 50, child: CircularProgressIndicator()),
                title: Text("Please Wait..."),
              ),
            )
          ],
        );
      },
    );
  }
}
