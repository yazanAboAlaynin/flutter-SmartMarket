import 'package:flutter/material.dart';
import 'package:flutter_smartmarket/models/order_item.dart';
import 'package:flutter_smartmarket/models/product.dart';
import 'package:flutter_smartmarket/screens/rating/order_review.dart';
import 'package:flutter_smartmarket/services/api.dart';
import 'package:flutter_smartmarket/shared/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/authenticate.dart';
import 'home/home.dart';

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;

  bool loading = true;
  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();

  }

  void _checkIfLoggedIn() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token') ?? '';
    print(token);
    if(token.isNotEmpty){
      setState(() {
        isAuth = true;
      });
    }

    setState(() {
      loading = false;
    });

  }
  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = Home();
    } else {
      child = Authenticate();
    }
    return loading ? Loading() : Scaffold(
      body: child,
    );
  }
}