import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:woocommerce/models/customer.dart';
import '../../../helper.dart';
import '../../../service/data/woocommerce.dart';
import '../login/login.dart';

class SignUpPage extends StatefulWidget {
  static final id = "SignUpPage";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _fname;
  String _lname;
  String _email;
  String _password;
  String _username;

  bool hidePassword = true;
  bool showSpinner = false;

  Future<WooCustomer> createdNewCustomerFromInput() async {
    log("createdNewCustomerFromInput Called");
    final customer = WooCustomer(
        firstName: _fname,
        lastName: _lname,
        email: _email,
        password: _password,
        username: _username);
    return customer;
  }

  Future<bool> createdNewCustomerInServer() async {
    final customer = await createdNewCustomerFromInput();
    setState(() {
      showSpinner = true;
    });

    final rigesterd =
        await WooCommerceApi().createCustumer(customer).whenComplete(() {
      setState(() {
        showSpinner = false;
      });

      // return Scaffold.of(context).showSnackBar(snackBar);
    }).then((value) {
      if (value == true) {
     
        return Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen(),
          ),
        );
      }
    }).catchError((e) {
    print(e.toString());
    });

    return rigesterd;
  }

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  Widget body(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.white,
      progressIndicator: spinkit,
      inAsyncCall: showSpinner,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 40.0),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(20),
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
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 25),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onSaved: (input) {
                              return _fname = input;
                            },
                            validator: (value){
                              if(value.length > 3){
                                return null;
                              } else return "Enter Valid Firstname";
                            },
                            decoration: new InputDecoration(
                              labelText: "First Name",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange.withOpacity(0.2))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange)),
                              prefixIcon: Icon(
                                Icons.receipt,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          new TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onSaved: (input) => _lname = input,
                              validator: (value){
                              if(value.length > 3){
                                return null;
                              } else return "Enter Valid Lastname";
                            },
                            decoration: new InputDecoration(
                              labelText: "Lastname",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green.withOpacity(0.2))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange)),
                              prefixIcon: Icon(
                                Icons.receipt,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          new TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (input) => _email = input,
                            validator: (input) => !input.contains('@')
                                ? "Email Id should be valid"
                                : null,
                            decoration: new InputDecoration(
                              labelText: 'E-mail',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.orangeAccent)),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onSaved: (input) => _username = input,
                            validator: (input) => input.length < 3
                                ? "Username should be more than 3 characters"
                                : null,
                            decoration: new InputDecoration(
                              labelText: "Username",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange.withOpacity(0.2))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green)),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            onSaved: (input) => _password = input,
                            validator: (input) => input.length < 3
                                ? "Password should be more than 3 characters"
                                : null,
                            obscureText: hidePassword,
                            decoration: InputDecoration(
                              labelText: "Password",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange.withOpacity(0.2))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange)),
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
                                color: Colors.orange.withOpacity(0.4),
                                icon: Icon(hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          GestureDetector(
                            child: Text(
                              " I have account ",
                            ),
                            onTap: () {
                              return Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginScreen(),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 30),
                          TextButton(
                            onPressed: () async {
                              var isOk = await validateAndSave();
                              if (isOk) {
                                final customer =
                                    await createdNewCustomerInServer();
                                if (customer is WooCustomer) {
                                  _formKey.currentState.reset();
                                  return Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginScreen(),
                                    ),
                                  );
                                } else if (customer is WooCustomer) {
                                  print("customer");
                                }
                                print(customer);
                              } else {
                                print(" Wrong  Inputs!!");
                              }
                            },
                            child: Text(
                              "Register",
                            ),
                          ),
                          SizedBox(height: 15),
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

    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
