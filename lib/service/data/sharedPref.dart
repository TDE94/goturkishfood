import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref extends ChangeNotifier{
  SharedPreferences prefs ;
// Token ve ID telefon hafızasında tutmak için kullanılan metodlar
Future<bool> saveToken(String token)async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var sonuc = await prefs.setString("token", token);
  notifyListeners();
  return sonuc;

}
Future<bool> saveID(int token)async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var sonuc = await prefs.setInt("id", token);
 
  return sonuc;
}
Future<String> getToken()async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
 var token = prefs.getString("token");
 
 return token;
}
Future<int > getID()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
 var token = prefs.getInt("id");
 print(token);
 
 return token;
}
Future<bool> isLoged()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString("token");
  var id = prefs.getInt("id");
  print(id.toString());
 
  if(token == null){
    return false;
  }else{
    return true;
  }
  
}

Future<bool> clear()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var sonuc = await prefs.remove("token");
    await prefs.remove("id");
    notifyListeners();
    return sonuc;
}
}