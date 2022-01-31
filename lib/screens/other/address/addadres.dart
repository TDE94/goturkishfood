import 'package:flutter/material.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/woocommerce.dart';

import 'package:goturkishfoodapp/service/data/woocommerce.dart';

class AddAdres extends StatefulWidget {
  final WooCustomer user;
  final bool added;
  const AddAdres({
    Key key,
    this.user,
    this.added,
  }) : super(key: key);
  @override
  _AddAdresState createState() => _AddAdresState();
}

class _AddAdresState extends State<AddAdres> {
  final _formKey = GlobalKey<FormState>();
  WooCommerceApi service = WooCommerceApi();
  var ship = Shipping();

  @override
  Widget build(BuildContext context) {
    var model = widget.user;
    return Scaffold(
        appBar: AppBar(
          title: widget.added ?Text("Update Address") : Text("Add Address"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: model.firstName + " " + model.lastName,
                      enabled: false,
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.0)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (val) {
                    if (val.length > 0) {
                      ship.company = val;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Company",
                      hintText: "If you want to order as company, add it",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.0)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (val) {
                    ship.address1 = val;
                  },
                  validator: (val) {
                    if (val.length > 3) {
                      return null;
                    } else {
                      return "Please check address";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: widget.added ?  model.shipping.address1 : "Adress 1 *",
                      labelText: widget.added ?  "12" :  "Address 1 *",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.0)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (val) {
                    ship.address2 = val;
                  },
                  validator: (val) {
                    if (val.length > 3) {
                      return null;
                    } else {
                      return "Please check address";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Address 2 *",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.0)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (val) {
                    ship.state = val;
                  },
                  validator: (val) {
                    if (val.length > 3) {
                      return null;
                    } else {
                      return "Please check state";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "State *",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.0)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (val) {
                    ship.postcode = val;
                  },
                  validator: (val) {
                    if (val.length > 3) {
                      return null;
                    } else {
                      return "Please check postcode";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "PostCode *",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.0)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (val) {
                    ship.city = val;
                  },
                  validator: (val) {
                    if (val.length > 3) {
                      return null;
                    } else {
                      return "Please check city";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "City * ",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.0)))),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      ship.firstName = model.firstName;
                      ship.lastName = model.lastName;
                      ship.country = "UK";
                      var result = await service.addAddressShip(
                          ship, model.id.toString());
                      if (result) {
                        _formKey.currentState.reset();
                        Navigator.pop(context);
                      }else{
                        print("Hata");
                      }
                    }
                  },
                  child: Text("Add Address"))
            ],
          ),
        ));
  }
}
