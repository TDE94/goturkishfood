import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../helper.dart';
import '../../service/data/sharedPref.dart';
import '../../service/provider/provider.dart';
import 'about/about.dart';
import 'address/address.dart';
import 'profile/profile2.dart';
import 'social.dart';

class OthersPage extends StatefulWidget {
  @override
  _OthersPageState createState() => _OthersPageState();
}

class _OthersPageState extends State<OthersPage> {
  String id;
  List<String> otherList = [
    "Profile",
    "My Orders",
    "My Address",
    "Privacy & Policy",
  ];
  @override
  Widget build(BuildContext context) {
    SharedPref().getID().then((value) => id = value.toString());
    return Consumer(
      builder: (context, watch, child) {
        var user = watch(usersProvider(id));
        return user.map(
          data: (data) {
            return buildScaffold(data.value);
          },
          loading: (_) {
            return Scaffold(
              body: Center(
                child: spinkit,
              ),
            );
          },
          error: (e) {
            return Scaffold(body: Center(child: Text(e.toString())));
          },
        );
      },
    );
  }

  Scaffold buildScaffold(WooCustomer user) {
    return Scaffold(
        body: Column(
      children: [
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage(
                            user: user,
                          )));
            },
            child: buildGridView("Profile")),
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Address(
                            user: user,
                          )));
            },
            child: buildGridView("My Address")),
        buildGridView("My Orders"),
        GestureDetector(
            onTap: () async {
              await SocialButton.goToSocial("https://goturkishfood.com/privacy-policy/");
            },
            child: buildGridView("Privacy & Policy")),
        GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutPage()));
            },
            child: buildGridView("About Us")),
        Divider(
          height: 10,
          color: Colors.white10,
        ),
        Text("Contact Us"),
        Divider(
          height: 10,
          color: Colors.white10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                child: GestureDetector(
              onTap: () async {
                await SocialButton.goToSocial(
                    "https://www.facebook.com/goturkishfooduk");
              },
              child: Image(
                image: AssetImage(
                  "images/social/facebook.png",
                ),
                width: 50,
              ),
            )),
            Container(
                child: GestureDetector(
              onTap: () async {
                await SocialButton.goToSocial(
                    "https://www.instagram.com/goturkishfooduk");
              },
              child: Image(
                image: AssetImage("images/social/instgram.jpeg"),
                width: 50,
              ),
            )),
            Container(
                child: GestureDetector(
              onTap: () async {
                await SocialButton.goToSocial(
                    "https://api.whatsapp.com/send?phone=+447856440490");
              },
              child: Image(
                image: AssetImage(
                  "images/social/whatsapp.png",
                ),
                width: 50,
              ),
            )),
          ],
        ),
      
      ],
    ));
  }

  Widget buildGridView(String title) {
    return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
            gradient: LinearGradient(colors: [
              Colors.orange,
              Colors.orangeAccent,
              Colors.deepOrangeAccent,
            ]),
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Align(
            alignment: AlignmentDirectional.center,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
            )));
  }
}
