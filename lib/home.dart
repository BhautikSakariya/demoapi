import 'package:demoapi/login.dart';
import 'package:demoapi/model.dart';
import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String id = "";
  String name = "";
  String email = "";
  String contact = "";
  String password = "";
  String imagepath = "";
  String imageurl = "";

  @override
  void initState() {
    super.initState();
    getgata();
  }

  getgata() {
    id = model.prefs!.getString('id') ?? "";
    name = model.prefs!.getString('name') ?? "";
    email = model.prefs!.getString('email') ?? "";
    contact = model.prefs!.getString('contact') ?? "";
    password = model.prefs!.getString('password') ?? "";
    imagepath = model.prefs!.getString('imagepath') ?? "";
    imageurl = "https://bhautiksakariya.000webhostapp.com/Bhautik/$imagepath";
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("homepage"),),
      drawer: Drawer(
        child: ListView(
          children: [
            Center(
              child: UserAccountsDrawerHeader(
                accountName: Text("$name"),
                accountEmail: Text("$email"),
                currentAccountPicture: Image.network("$imageurl"),
              ),
            ),

            ListTile(
              title: Text("Log Out"),
              onTap: () {
                model.prefs!.clear();
                imageurl = "";
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return loginpage();
                },));


              },
            )
          ],
        ),
      ),
    );
  }
}
