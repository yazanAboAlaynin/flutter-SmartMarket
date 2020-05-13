import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smartmarket/screens/home/home.dart';
import 'package:flutter_smartmarket/services/api.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  Login({this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

