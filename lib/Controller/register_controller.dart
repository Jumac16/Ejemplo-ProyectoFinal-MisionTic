import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Models/user_model.dart';

Future<User> saveUser(String name, String email, String password) async{
  var userRegister = User(name, email, password);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('user', jsonEncode(userRegister));
  return userRegister;
}