import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api{
  final String _url = 'http://192.168.1.7:8000/api';
  String token;

  Future _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'))['token'];
  }

  Future authData(dynamic data,String apiUrl) async {
    String fullUrl = _url + apiUrl;
    return await post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }

  Future getData(String apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await get(
        fullUrl,
        headers: _setHeaders()
    );
  }

  Map _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    //'Authorization' : 'Bearer $token'
  };

}
