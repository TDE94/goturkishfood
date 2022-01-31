import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        
        decoration: BoxDecoration(
          border: Border.all(color: Colors.orange)
        ),
        child: SingleChildScrollView(
                  child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: size.height / 5,
                width: double.infinity,
                decoration: BoxDecoration(
                
                  image: DecorationImage(image: AssetImage("images/app/logo.jpeg"),fit: BoxFit.contain),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                    
                  ),
                ),
              ),
              Text("About Us",style: TextStyle(fontStyle: FontStyle.italic),),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Goturkishfood family is an online ethnic and cultural food platform established in London, England in 2019."),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Goturkishfood; It is a company established by the need to combine Turkish food products that the Turks could not reach on a single platform and reach easily and practically as a result of our market research in England and a situation we experience. The richness of Goturkishfood Turk cuisine will offer you quality products in a convenient, practical and time-saving manner for your kitchen in England.",maxLines: 10,),
              ),
           
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("We are happy to offer you the shortest and healthiest form of the Goturkisfood family, together with the best quality and hard-to-reach products, the most affordable prices and cargo service.We exist as Goturkishfood family for happiness in your kitchen and at your table."),
              ),
           
              Text("With our best wishes, Goturkishfood family.")
            ],
          ),
        ),
      ),
    );
  }
}
