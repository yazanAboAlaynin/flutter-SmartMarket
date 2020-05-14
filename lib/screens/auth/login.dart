import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smartmarket/screens/home/home.dart';
import 'package:flutter_smartmarket/services/api.dart';
import 'package:flutter_smartmarket/shared/constants.dart';
import 'package:flutter_smartmarket/shared/loading.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  Login({this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            // ======== image ========
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/shop2.jpg"),
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter,
                  ),
                ),
                // ========== text and icon back ===============
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // =========== design =================
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        height: MediaQuery.of(context).size.height * 0.72,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25),
                          ),
                        ),
                        // ==========text field=============
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Welcome',
                                style: TextStyle(
                                    color: Color(0xfff032f42),
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Sign in',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 20),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Email', icon: Icon(Icons.email)),
                                validator: (val) =>
                                    val.isEmpty ? 'Enter an email' : null,
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Password',
                                    icon: Icon(Icons.https)),
                                obscureText: true,
                                validator: (val) => val.length < 8
                                    ? 'Enter a password 8+ chars long'
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              RaisedButton(
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: Colors.blue[400],
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    var data = {
                                      'email': email,
                                      'password': password
                                    };
                                    Response response =
                                        await Api().authData(data, '/login');
                                    Map<String, dynamic> body =
                                        json.decode(response.body);

                                    if (body['success'] != null) {
                                      print('here');
                                      SharedPreferences localStorage =
                                          await SharedPreferences.getInstance();
                                      localStorage.setString(
                                          'token', json.encode(body['token']));
                                      localStorage.setString(
                                          'user', json.encode(body['user']));
                                      Navigator.pushReplacement<Object, Object>(
                                        context,
                                        new MaterialPageRoute<dynamic>(
                                            builder: (context) => Home()),
                                      );
                                    } else {
                                      // _showMsg(body['message']);
                                    }

                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
