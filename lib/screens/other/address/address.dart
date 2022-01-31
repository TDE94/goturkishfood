import 'package:flutter/material.dart';
import 'package:goturkishfoodapp/screens/other/address/addadres.dart';
import 'package:woocommerce/woocommerce.dart';

class Address extends StatelessWidget {
  final WooCustomer user;
  const Address({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Address"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Shipping Address"),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  ListTile(
                    trailing: Column(
                      children: [
                        user.shipping.address1 != null
                            ? Text("Update ")
                            : Text("Add "),
                        Expanded(
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => AddAdres(
                                    user: user,
                                    added: user.shipping.address1 == "" ? false : true
                                  ),
                                ));
                              },
                              icon: Icon(Icons.add)),
                        ),
                      ],
                    ),
                    subtitle: Text(user.shipping.address1 +
                        " " +
                        user.shipping.address2 +
                        " " +
                        user.shipping.state),
                    title: Text("Address"),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.white,
                  ),
                  ListTile(
                    title: Text("City & PostCode"),
                    subtitle: Text(user.shipping.city),
                    trailing: Text(user.shipping.postcode),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.white,
                  ),
                  ListTile(
                    trailing: user.shipping.company != null
                        ? Text(user.shipping.company)
                        : Text(""),
                    title: Text(user.firstName + " " + user.lastName),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.white,
                  ),
                  ListTile(
                    trailing: Text(user.shipping.country),
                    subtitle: Text(user.email),
                    title: Text("E-mail "),
                  ),
                ],
              ),
            ),
            Text("Billing Address"),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  ListTile(
                    trailing: Column(
                      children: [
                        user.billing.address1 != ""
                            ? Text("Update ")
                            : Text("Add "),
                        Expanded(
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => AddAdres(
                                    user: user,
                                    added: user.billing.address1 == "" ? false : true,
                                  ),
                                ));
                              },
                              icon: Icon(Icons.add)),
                        ),
                      ],
                    ),
                    subtitle: Text(user.billing.address1 +
                        " " +
                        user.billing.address2 +
                        " " +
                        user.billing.state),
                    title: Text("Address"),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.white,
                  ),
                  ListTile(
                    title: Text("City & PostCode"),
                    subtitle: Text(user.billing.city),
                    trailing: Text(user.billing.postcode),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.white,
                  ),
                  ListTile(
                    trailing: Text(user.billing.country),
                    title: Text(user.firstName + " " + user.lastName),
                  ),
                  ListTile(
                    title: Text("Phone Number & E-mail"),
                    subtitle: Text(user.billing.phone),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
