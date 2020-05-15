import 'dart:convert';

import 'package:flutter_smartmarket/models/item.dart';
import 'package:flutter_smartmarket/models/product.dart';
import 'package:flutter_smartmarket/screens/home/home.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api{
  final String _url = 'http://192.168.1.7:8000/api';
  final String _images_url = 'http://192.168.1.7:8000/storage/';
  String token='';

  String getImagesUrl() => _images_url;
  // to get the token
  Future _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'));
  }

  // to make post requests
   Future authData(dynamic data,String apiUrl) async {
    String fullUrl = _url + apiUrl;
    return await post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }

  // to make get requests
  Future getData(String apiUrl) async {
    String fullUrl = _url + apiUrl;
    await _getToken();
    return await get(
        fullUrl,
        headers: _setHeaders()
    );
  }

  // set the headers for requests
  Map<String,String> _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };

  Future<List<Item>> getCategories() async {
    Response response = await Api().getData('/categories');
    var categories = json.decode(
        response.body)['success']['categories'] as List;
    List<Item> myModels = categories.map(( dynamic i) => Item.fromJson(i)).toList();
    return myModels;
  }

  Future<List<Item>> getBrands() async {
    Response response = await Api().getData('/brands');
    var brands = json.decode(
        response.body)['success']['brands'] as List;
    List<Item> myModels = brands.map((dynamic i) => Item.fromJson(i)).toList();
    return myModels;
  }

  Future<List<Item>> getSellers() async {
    Response response = await Api().getData('/sellers');
    var sellers = json.decode(
        response.body)['success']['sellers'] as List;
    List<Item> myModels = sellers.map((dynamic i) => Item.fromJson(i)).toList();
    return myModels;
  }

  Future<List<Product>> getProducts(String s,int id) async {
    switch(s){
      case 'category':
        Response response = await Api().getData('/products/category/$id');
        //print(response.body);
        var products = json.decode(
            response.body)['products'] as List;
        List<Product> myModels = products.map((dynamic i) => Product.fromJson(i)).toList();
        //print(myModels);
        return myModels;

      case 'brand':
        Response response = await Api().getData('/products/brand/$id');
        //print(response.body);
        var products = json.decode(
            response.body)['products'] as List;
        List<Product> myModels = products.map((dynamic i) => Product.fromJson(i)).toList();
        //print(myModels);
        return myModels;

      case 'seller':
        Response response = await Api().getData('/products/seller/$id');
        //print(response.body);
        var products = json.decode(
            response.body)['products'] as List;
        List<Product> myModels = products.map((dynamic i) => Product.fromJson(i)).toList();
        //print(myModels);
        return myModels;
    }

  }

  Future<String> getProductCategory(int id) async{
    Response response = await Api().getData('/product/$id/category/');
    String category = json.decode(response.body)['category'];
    return category;
  }


}
