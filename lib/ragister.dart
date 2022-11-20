import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ragister extends StatefulWidget {
  const ragister({Key? key}) : super(key: key);

  @override
  State<ragister> createState() => _ragisterState();
}

class _ragisterState extends State<ragister> {
  @override
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  String? temp;
  String user ="image/user.png";
  final ImagePicker _picker = ImagePicker();


  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Container(

            width: double.infinity,
            height: 200,

            child: Center(child: InkWell(onLongPress: () {
              showDialog(context: context, builder: (context) {
                return SimpleDialog(title: Text("Select Choice"),children: [
                  ListTile(onTap: () async {


                    final XFile? gallary = await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      if(gallary!=null)
                        {

                         setState(() {
                           temp = gallary.path;
                           Navigator.pop(context);
                         });

                        }
                    });
                  },title: Text("Gellary")),
                  ListTile(onTap: () async {
                    final XFile? camera = await _picker.pickImage(source: ImageSource.camera);
                    setState(() {
                      if(camera!=null)
                        {

                          setState(() {
                            temp =camera.path;
                            Navigator.pop(context);
                          });

                        }
                    });

                  },title: Text("Camera")),
                ],);
              },);
              setState(() {

              });
            },child: Container(height: 150, width: 150, child:temp != null ?  CircleAvatar(backgroundImage:FileImage(File(temp!)),) :


            CircleAvatar(backgroundImage: AssetImage(user),)

              ,decoration: BoxDecoration(shape: BoxShape.circle),))),
          ),
          Container(
            padding: EdgeInsets.all(10),

            width:double.infinity,
            height: 80,

            child: TextField(

              controller: name,
              decoration: InputDecoration(hintText:"Enter Name",
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),),),
          Container(
            padding: EdgeInsets.all(10),

            width:double.infinity,
            height: 80,

            child: TextField(

              controller: email,
              decoration: InputDecoration(hintText:"Enter Email",
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),),),
          Container(
            padding: EdgeInsets.all(10),

            width:double.infinity,
            height: 80,

            child: TextField(

              controller: mobile,
              decoration: InputDecoration(hintText:"Enter Mobile No",
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),),),
          Container(
            padding: EdgeInsets.all(10),

            width:double.infinity,
            height: 80,

            child: TextField(

              controller: password,
              decoration: InputDecoration(hintText:"Enter Password",
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),),) ,

          Container(
            padding: EdgeInsets.all(10),
            width:double.infinity,
            height: 100,

            child: Center(child: Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),child: Text("Ragister")),),
      ),
    ])

    );
  }
}
