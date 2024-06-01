import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/pages/NavBar.dart';

class SplashPage extends StatefulWidget {

  @override
  State<SplashPage> createState() => SplashPageState();
}


class SplashPageState extends State<SplashPage>{
  static const String keyLogin= "login";
  static var cnic;
  @override
  void initState() {
    checkLogin();
    super.initState();
  }


// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Material(

    );
  }
  void checkLogin() async{
    var pref= await SharedPreferences.getInstance();
    var isLoggedIn= pref.getBool(keyLogin);
    if (isLoggedIn == null || isLoggedIn == false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavBar()),
      );
    }
  }

  Future<void> fetchCNIC() async{
      SharedPreferences prefLogin = await SharedPreferences.getInstance();
      cnic= prefLogin.getString('cnic') ?? '';
    }


}





