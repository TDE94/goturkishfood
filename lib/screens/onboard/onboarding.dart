import 'package:flutter/material.dart';
import 'package:goturkishfoodapp/screens/auth/login/login.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}
// PageView kullanıldı
// fotoğraflar images/onboard dosyasında tutuldu
// Devam butonu aktif
class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
              flex: 6,
              child: PageView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/onboard/support.png",
                        fit: BoxFit.contain,
                      ),
                      Text(
                        "Secure Payment ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/onboard/turkish.png",
                        fit: BoxFit.contain,
                      ),
                      Text(
                        "100% Fresh Gourmet Turkish Food",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/onboard/delivery.png",
                        fit: BoxFit.contain,
                      ),
                      Text(
                        "Easy Support & Delivery System",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              )),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(20),
                height: size.height / 12,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false);
                    },
                    child: Text("Continue",style: TextStyle(color: Colors.white),)),
              ))
        ],
      ),
    );
  }
}
