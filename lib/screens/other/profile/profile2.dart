import 'package:flutter/material.dart';
import 'package:goturkishfoodapp/screens/other/address/addadres.dart';
import 'package:woocommerce/woocommerce.dart';

class ProfilePage extends StatelessWidget {
  final WooCustomer user;

  const ProfilePage({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Profile Info"),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: size.height / 10,
              decoration: BoxDecoration(
                
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: ListTile(
                
                trailing: Icon(Icons.info,color: Colors.orange,),
                title: Text("${user.firstName} ${user.lastName}"),
                subtitle: Text("Username : " + user.username),
              ),
            ),
             Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: size.height / 10,
              decoration: BoxDecoration(
                  
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: ListTile(
                trailing: Icon(Icons.email,color: Colors.orange,),
                title: Text("Email : ${user.email} "),
                subtitle: Text(""),
              ),
            ),
             Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: size.height / 10,
              decoration: BoxDecoration(
                  
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: ListTile(
                trailing: Icon(Icons.lock_clock_outlined,color: Colors.orange,),
                title: Text("Password : ******** "),
                subtitle: Text("You want to change password"),
              ),
            ),
            Divider(color: Colors.orange,height: 2,),
            user.shipping.address1 != null ? 
        Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: size.height / 10,
              decoration: BoxDecoration(
                  
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: ListTile(
                trailing:Text(user.shipping.postcode),
                title: Text(user.shipping.address1 + " "+ user.shipping.address2),
                subtitle: Text(user.shipping.state + " " + user.shipping.city),

              ),
            ): Column(
              children: [
                Text("Address not found"),
                Divider(),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAdres(user: user,)));
                }, child: Text("Do you want to add ?"))
              ],
            ),

          ],
        ),
      ),
    );
  }
}
