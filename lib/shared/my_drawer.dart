import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smartmarket/models/user.dart';
import 'package:flutter_smartmarket/screens/auth/authenticate.dart';
import 'package:flutter_smartmarket/screens/auth/login.dart';
import 'package:flutter_smartmarket/screens/cart/cart_view.dart';
import 'package:flutter_smartmarket/screens/home/home.dart';
import 'package:flutter_smartmarket/screens/profile/profile.dart';
import 'package:flutter_smartmarket/screens/recommendation.dart';
import 'package:flutter_smartmarket/services/api.dart';
import 'package:flutter_smartmarket/shared/waiting.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  User user;
  bool loading = true;
  Future<void> getData() async {
    User u = await Api().profile();
    setState(() {
      user = u;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void logout() async {
    Response res = await Api().getData('/logout');
    Map<String, dynamic> body = json.decode(res.body);
    print(body);
    if (body['success'] != null) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.pushReplacement<Object, Object>(context,
          new MaterialPageRoute<dynamic>(builder: (context) => Authenticate()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Waiting()
        : ListView(
            children: <Widget>[
              // ====== start header ===
              UserAccountsDrawerHeader(
                accountName: Text(user.name),
                accountEmail: Text(user.email),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(Api().getImagesUrl() + user.image),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[200],
                ),
              ),

              // ====== start body in the side bar ====
              InkWell(
                onTap: () {
                  Navigator.push<Object>(
                      context,
                      new MaterialPageRoute<dynamic>(
                          builder: (context) => Home()));
                },
                child: ListTile(
                  title: Text('Home Page'),
                  leading: Icon(
                    Icons.home,
                    color: Colors.red,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push<Object>(
                      context,
                      new MaterialPageRoute<dynamic>(
                          builder: (context) => Profile()));
                },
                child: ListTile(
                  title: Text('Profile'),
                  leading: Icon(
                    Icons.person,
                    color: Colors.red,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('My Orders'),
                  leading: Icon(
                    Icons.shopping_basket,
                    color: Colors.red,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push<Object>(
                      context,
                      new MaterialPageRoute<dynamic>(
                          builder: (context) => CartView()));
                },
                child: ListTile(
                  title: Text('Shopping Cart'),
                  leading: Icon(
                    Icons.shopping_cart,
                    color: Colors.red,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push<Object>(
                      context,
                      new MaterialPageRoute<dynamic>(
                          builder: (context) => Recommendations()));
                },
                child: ListTile(
                  title: Text('Get Recommendations'),
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ),

              //======الخط الفاصل =====
              Divider(
                height: 6.0,
                indent: 16.0,
                endIndent: 16.0,
                color: Colors.black26,
                thickness: 0.7,
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Settings'),
                  leading: Icon(
                    Icons.settings,
                    color: Colors.black54,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('About'),
                  leading: Icon(
                    Icons.help,
                    color: Colors.blue[600],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  logout();
                },
                child: ListTile(
                  title: Text('Logout'),
                  leading: Icon(
                    Icons.highlight_off,
                    color: Colors.red[600],
                  ),
                ),
              ),
            ],
          );
  }
}
