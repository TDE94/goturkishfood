import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../helper.dart';
import '../../../service/data/sharedPref.dart';
import '../../../service/data/woocommerce.dart';
import '../../routing_screen.dart';
import '../signup/signup.dart';

class LoginScreen extends StatefulWidget {
  static final id = "LoginPage";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final SharedPref pref = SharedPref();


  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  String password;
  String username;

  bool hidePassword = true;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  //Basit bir form tasarımı yapıldı.
  // Butonlar aktif
  //Login otomatik yazıldı
  // Error handling yapılmadı

  Widget body(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.white,
      progressIndicator: spinkit,
      inAsyncCall: showSpinner,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40.0),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                        margin:
                            EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 10),
                                blurRadius: 20)
                          ],
                        ),
                        child: Form(
                          key: globalFormKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 25),
                              Text(
                                " Login ",
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                onSaved: (input) => username = input,
                                validator: (input) =>
                                    input.isEmpty ? "Enter Valid Username" : null,
                                decoration: new InputDecoration(
                                  labelText: 'Username',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green)),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                onSaved: (input) => password = input,
                                validator: (input) => input.length < 3
                                    ? "Password should be more than 3 characters"
                                    : null,
                                obscureText: hidePassword,
                                decoration:  InputDecoration(
                                  labelText: "Password",
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Colors.green.withOpacity(0.2))),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green)),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.orange,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        hidePassword = !hidePassword;
                                      });
                                    },
                                    color: Colors.green.withOpacity(0.4),
                                    icon: Icon(hidePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: Text(
                                        "Forgot Password",
                                      ),
                                      onTap: () async {
                                       await _forgetPass(
                                            );
                                      },
                                    ),
                                    GestureDetector(
                                      child: Text(
                                        "Register",
                                      ),
                                      onTap: () async {
                                        return Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                SignUpPage(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                              TextButton(
                                onPressed: () async {
                                  var isOk = await validateAndSave();
                                  if (isOk) {
                                    var sonuc = await WooCommerceApi()
                                        .loginUserCustom(
                                            username: "denizerd",
                                            password: "denizerd");
                                    if (sonuc) {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RoutingScreen()),
                                          (route) => false);
                                    } else {
                                      print("Hata Oluştu");
                                    }
                                  } else {
                                    print("Somthing Wrong!!");
                                  }
                                },
                                child: Text(
                                  "Login",
                                ),
                              ),
                              SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }

  Future<bool> validateAndSave() async {
    await Future.delayed(Duration(seconds: 0));

    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void clearForm() {
    globalFormKey.currentState.reset();
  }

  Future<void> _forgetPass() async {
    var url = "https://goturkishfood.com/my-account/lost-password/";
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
