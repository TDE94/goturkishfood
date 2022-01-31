import 'package:flutter/material.dart';
import '../../../helper.dart';
import '../../../models/categorylist.dart';
import '../../product/store.dart';
//Our Tastes altındaki kategoriler
// Tıklanan kategoriye göre ürün sayfası açılıyor
class CategoriesItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var list = CategoryList.homecatAvatar;
    var height = SizeHelper.height(context);
    var widtth = SizeHelper.width(context);
    return Container(
        height: height / 7,
        width: double.infinity,
        margin: EdgeInsets.all(8),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            var model = list[i];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StoreScreen(
                              catId: model.categoryId.toString(),
                            )));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage(
                          "images/categorya/${model.name}.png",
                        ))),
                width: widtth * 0.15,
              ),
            );
          },
          separatorBuilder: (context, i) {
            return SizedBox(
              width: 15,
            );
          },
          itemCount: list.length,
        )
     
        );
  }


}
