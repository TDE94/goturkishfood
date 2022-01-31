import 'dart:async';
import 'package:flutter/material.dart';
import 'helper.dart';
import 'screens/onboard/onboarding.dart';
import 'screens/routing_screen.dart';
import 'service/data/woocommerce.dart';

class CheckLogin extends StatefulWidget {
  @override
  _CheckLoginState createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  @override
  void initState() {
    super.initState();

    
   Timer(Duration(seconds: 3), () => goToHomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: spinLogin,),
    );
  }

  goToHomePage() async {
    // Woocommerce paketindeki login durumunu
    //kontrol ettikten sonra Onboarding veya anasayfaya yönlendiriyor
    var service = await WooCommerceApi().checkLogged();
    if (service) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => RoutingScreen()));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => OnBoardingPage()));
    }
  }
}
