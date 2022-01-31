
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../models/cartitem.dart';
import '../data/sharedPref.dart';
import '../data/woocommerce.dart';

/// Home Screen Data =======================================================
final getAllProductProvider = FutureProvider.autoDispose.family<List<WooProduct>, String>((ref, catID) async {
  ref.maintainState = true;

  final products = await WooCommerceApi().getAllProducts(catID);
  return products;
});

/// Search
final getProductsQuery = FutureProvider.autoDispose.family<List<WooProduct>, String>((ref, query) async {
  ref.maintainState = true;

  final products = await WooCommerceApi().getProductBySearch(query);
  return products;
});
//Category
final getAllCategriesProvider = FutureProvider.autoDispose<List<WooProductCategory>>((ref) async {
  ref.maintainState = true;

  final productsCategories = await WooCommerceApi().getAllCategories();
  return productsCategories;
});
final productsChangeNotifierProvider =
    ChangeNotifierProvider<ProductsNotifier>((ref) => ProductsNotifier());



    final sharedPref = ChangeNotifierProvider<SharedPref>((ref) {
  return SharedPref();
});


class ProductsNotifier extends ChangeNotifier {
  String _catId = "15";
  int _selectedIndex = 0;

  int _selectedImage = 0;
  int _quantity = 1;

  String get catId => _catId;

  set kcatId(String value) {
    _catId = value;
  }

  int changeSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
    return _selectedIndex;
  }

  int changeSelectedImage(int newIndex) {
    _selectedImage = newIndex;
    notifyListeners();
    return _selectedImage;
  }

  void addQuantity() {
    print("addQuantity Called");
    // wooProduct.quantity++;
    // _quantity++;
    print("wooProduct.quantity : $_quantity ");

    notifyListeners();
  }

  void subQuantity() {
    if (_quantity > 1) {
      _quantity--;
    }

    notifyListeners();
  }

  int get selectedIndex => _selectedIndex;

  set kselectedIndex(int value) {
    _selectedIndex = value;
  }

  int get selectedImage => _selectedImage;

  set kselectedImage(int value) {
    _selectedImage = value;
  }

  int get quantity => _quantity;

  set kquantity(int value) {
    _quantity = value;
  }
}

/// Cart Screen Data =======================================================



final cartChangeNotifierProvider = ChangeNotifierProvider<CartNotifier>((ref) {
  return CartNotifier();
});

class CartNotifier extends ChangeNotifier {
  List<CartItem> _cartList = [];

  List<CartItem> get cartList => _cartList;

  var isExist = false;
  var _total;

  get total => _total;

  set ktotal(value) {
    _total = value;
  }

  double getTotalprice() {
    _total = 0.0;
    for (var cartItem in _cartList) {
      if(cartItem.product.price.isNotEmpty)
      _total += double.parse(cartItem.product.price) * cartItem.quantity;
      // notifyListeners();

    }
    return _total;
  }

  void addToCart({WooProduct wooProduct, int pQuantity}) async {
    print("CartNotifier addToCart $pQuantity");

    CartItem cartItem = CartItem(wooProduct, pQuantity);

    final checkItem = _cartList.firstWhere((element) => element.product.id == cartItem.product.id,
        orElse: () => null);
    if (checkItem != null) {
     
      isExist = true;
  

    } else {
      _cartList.add(cartItem);
   
      notifyListeners();
      isExist = false;
    }
  }


  void clearCart() async {
    print("CartNotifier clearCart ");
  

    _cartList.clear();
    print(_cartList.length);
    notifyListeners();
  }
}


/// Profile Screen Data =======================================================

final usersProvider = FutureProvider.autoDispose.family<WooCustomer,String>((ref,id) async {
  ref.maintainState = false;
  final customer = await WooCommerceApi().getCustomCustomer(id);
  return customer;
});


final ordersProvider = FutureProvider.autoDispose<List<WooOrder>>((ref) async {
  ref.maintainState = true;
  final products = await WooCommerceApi().getUserOrders();
  return products;
});
final shippingMethodsProvider = FutureProvider.autoDispose<List<WooShippingMethod>>((ref) async {
  ref.maintainState = true;
  final products = await WooCommerceApi().getShippingMethods();
  return products;
});



