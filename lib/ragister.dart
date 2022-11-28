import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
  String user ="image/user.png";
  final ImagePicker _picker = ImagePicker();


  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: Column(
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
                               imagepath = gallary.path;
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
                                imagepath =camera.path;
                                Navigator.pop(context);
                              });

                            }
                        });

                      },title: Text("Camera")),
                    ],);
                  },);
                  setState(() {

                  });
                },child: Container(height: 150, width: 150, child:imagepath!= null ?  CircleAvatar(backgroundImage:FileImage(File(imagepath!)),) :


                CircleAvatar(backgroundImage: AssetImage(user),)

                  ,decoration: BoxDecoration(shape: BoxShape.circle),))),
              ),
              Container(
                padding: EdgeInsets.all(10),

                width:double.infinity,
                height: 80,

                child: TextField(

                  controller: name2,
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

              InkWell(
                onTap: () async {

                  waiting();

                  String api = "https://bhautiksakariya.000webhostapp.com/Bhautik/ragister.php";

                  String name1 =  name2.text;
                  String email1= email.text;
                  String password1 = password.text;
                  String contact = mobile.text;

                  DateTime dt = DateTime.now();
                  String imagename = "$name1${dt.year}${dt.month}${dt.day}${dt.hour}${dt.minute}${dt.second}.jpg";



                  var formData = FormData.fromMap({
                    'name':name1,
                    'email':email1,
                    'password':password1,
                    'contact':contact,
                    'file': await MultipartFile.fromFile(imagepath!, filename: imagename),

                  });
                  var response = await Dio().post(api, data: formData);
                  Navigator.pop(context);
                  print("Response: ${response.statusCode}");
                  if(response.statusCode==200)
                    {
                      print("Response: ${response.data}");
                      Map map = jsonDecode(response.data);
                      int result =map['result'];
                      if(result==0)
                        {
                          print("try again");
                        }
                      else if(result==1)
                        {
                          print("login");
                        }
                    }
                  else
                    {
                      print("eroor");
                    }







                  

                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  width:double.infinity,
                  height: 100,

                  child: Center(child: Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),child: Text("Ragister")),),
          ),
              ),
    ]),
      ),
   

    );
  }

  waiting() {
    showDialog(context: context, builder: (context) {
      return SimpleDialog(
        children: [
          Container(
            height: 60,
            child: ListTile(
              leading: Container(height: 50,width: 50,child: CircularProgressIndicator()),
              title:Text("Please Wait...") ,
            ),
          )
        ],
      );
    },);
  }
}
