import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:woocommerce/constants/constants.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/utilities/local_db.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../constant.dart';
import 'sharedPref.dart';

class WooCommerceApi {
  static WooCommerce prodMode = WooCommerce(
    baseUrl: "$baseUrl",
    consumerKey: "$consumerKey",
    consumerSecret: "$consumerSecret",
    isDebug: false,
  );
  Map<String, String> _urlHeader = {'Authorization': ''};
// Kategorileri Almak için kullanıldı
  /// Search Screen  ================================================================================
  Future<List<WooProduct>> getProductBySearch(String query) async {
    final myProducts = await prodMode.getProducts(
        status: "publish", perPage: 50, page: 1, search: "$query");
    print("WooCommerceApi === getProducts1 : ${myProducts.length}");
    return myProducts;
  }

  Future<WooProductTag> getProductBy(int tag) async {
    final myProducts = await prodMode.getProductTagById(id: tag);
    var name = myProducts.name;
    print(name);
    return myProducts;
  }

  /// Home Screen  ================================================================================
  Future<List<WooProduct>> getAllProducts(String catId) async {
    final myProducts = await prodMode.getProducts(
      status: "publish",
      perPage: 50,
      page: 1,
      category: "$catId",
    );
    print("WooCommerceApi === getProducts1 : ${myProducts.length}");
    return myProducts;
  }

  Future<List<WooProductCategory>> getAllCategories() async {
    final myProducts =
        await prodMode.getProductCategories(perPage: 50, hideEmpty: true);
    print("WooCommerceApi === getAllCategories : ${myProducts.length}");

    return myProducts;
  }

  /// SignUp screen ================================================================================
  Future<bool> createCustumer(WooCustomer customer) async {
    final user = await prodMode.createCustomer(customer);
    return user;
  }

// Kullanıcı Girişi için kullanıldı

  Future<bool> loginUserCustom({String username, String password}) async {
    final body = {
      'username': username,
      'password': password,
    };
    final response = await http.post(
      baseUrl + URL_JWT_TOKEN,
      body: body,
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var toke = json.decode(response.body);
      var token = toke['data']['token'];
      var id = toke['data']['id'];

      var newToken = await SharedPref().saveToken(token);
      var newid = await SharedPref().saveID(id);
      if (newToken && newid) {
        print(token);
        print(id);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

// Kayıtlı token kontrolü yapmak için kullanıldı
  Future<bool> checkLogged() async {
    bool login;

    final isLoged = await SharedPref().isLoged();
    if (isLoged == true) {
      login = isLoged;
    } else {
      login = isLoged;
    }
    return login;
  }

  Future<bool> logOut() async {
    //  final logged = await prodMode.isCustomerLoggedIn();
    var sonuc = await SharedPref().clear();
    return sonuc;
  }

  /// Profile Screen  ================================================================================
  Future<WooCustomer> getCustumerInfo() async {
    var authToken = await LocalDatabaseService().getSecurityToken();
    _urlHeader['Authorization'] = 'Bearer ' + authToken;
    final response = await http.get(baseUrl + URL_USER_ME, headers: _urlHeader);
    print(response.body);
    final userId = await prodMode.fetchLoggedInUserId();
    final myProducts = await prodMode.getCustomerById(id: userId);
    return myProducts;
  }

  Future<WooCustomer> getCustomCustomer(String id) async {
    print(id);
    final response = await http.get(
      customerUrl + id + customerUrl2,
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var cus = json.decode(response.body);
      var customer = WooCustomer.fromJson(cus);

      return customer;
    } else {
      return null;
    }
  }

  Future<bool> addAddressShip(
    Shipping ship,
    String id,
  ) async {
    var body = json.encode({
      "shipping": {
        "address_1": ship.address1,
        "address_2": ship.address2,
        "first_name": ship.firstName,
        "last_name": ship.lastName,
        "postcode": ship.postcode,
        "city": ship.city,
        "state": ship.state,
        "company": ship.company,
        "country": ship.country
      }
    });
    var response = await http.put(Uri.parse(customerUrl + id + customerUrl2),
        body: body,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      return null;
    }
  }

  Future<List<WooOrder>> getUserOrders() async {
    final customerId = await getCustumerInfo();
    print("customerId in getUserOrders: ${customerId.id} ");

    // final myProducts = await prodMode.getOrders(customer: customerId.id);
    var a = [
      'processing',
      'on-hold',
      'pending', // default
      'refunded',
      'cancelled',
      'completed',
      'failed',
      'trash',
      'any',
    ];

    final myProducts = await prodMode.getOrders();
    // final myProducts = await ApiRequest().(customer: 1);

    print("getUserOrders : ${myProducts.length} + $a[1] ");
    return myProducts;
  }

  Future<List<WooCoupon>> getCoupons() async {
    final myProducts = await prodMode.getCoupons();
    print("getCoupons : ${myProducts.length}");
    return myProducts;
  }

  /// Payment Screen  ================================================================================
  Future<List<WooShippingMethod>> getShippingMethods() async {
    final myProducts = await prodMode.getShippingMethods();
    print("getShippingMethods : ${myProducts.length}");
    return myProducts;
  }

  Future<WooOrder> createOrder(WooOrderPayload orderPayload) async {
    final myProducts = await prodMode.createOrder(orderPayload);
    print("createOrder : myProducts");
    return myProducts;
  }
}
