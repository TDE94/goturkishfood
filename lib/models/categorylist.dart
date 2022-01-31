

class CategoryList {
  String categoryId;
  String name;
  CategoryList({
     this.categoryId,
     this.name,
  });
 static List<CategoryList> homecatAvatar = [
     CategoryList(name: "apulses",categoryId: "99"),
    CategoryList(name: "abeve",categoryId: "97"),
    CategoryList(name: "adairy",categoryId: "104"),
    CategoryList(name: "ahoney",categoryId: "105"),
    CategoryList(name: "ameats",categoryId: "98"),
    CategoryList(name: "aoils",categoryId: "116"),
    CategoryList(name: "aolives",categoryId: "106"),
    CategoryList(name: "apastas",categoryId: "100"),
    CategoryList(name: "aspices",categoryId: "110"),
    CategoryList(name: "asoups",categoryId: "109"),

  ];
  static List<CategoryList> categoryList =[
    CategoryList(name: "pulses",categoryId: "99"),
    CategoryList(name: "beverages",categoryId: "97"),
    CategoryList(name: "dairy",categoryId: "104"),
    CategoryList(name: "honeyjam",categoryId: "105"),
    CategoryList(name: "meat",categoryId: "98"),
    CategoryList(name: "oils",categoryId: "116"),
    CategoryList(name: "olives",categoryId: "106"),
    CategoryList(name: "pasta",categoryId: "100"),
    CategoryList(name: "spices",categoryId: "110"),
    CategoryList(name: "traditional",categoryId: "109"),
    CategoryList(name: "other",categoryId: "15")
  ];
  

}
