import 'package:charity_life/enums/dependencies.dart';

class SharedPref {

  static saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }

  static getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    return email;
  }

  static saveUserPassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('password', password);
  }

  static getUserPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('password');
    return value;
  }

  static saveUserID(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userID', id);
  }

  static getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt('userID');
    return value;
  }

  static saveIsLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);
  }

  static getUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool('isLoggedIn');
    return boolValue;
  }

  static saveRememberMe(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('remember_me', value);
  }

  static getRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool('remember_me');
    return boolValue;
  }

}
