import 'dart:convert';

import 'package:flutter_smartmarket/models/item.dart';
import 'package:flutter_smartmarket/models/order_item.dart';
import 'package:flutter_smartmarket/models/product.dart';
import 'package:flutter_smartmarket/models/property.dart';
import 'package:flutter_smartmarket/models/user.dart';
import 'package:flutter_smartmarket/screens/home/home.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  final String _url = 'http://192.168.81.138:8000/api';
  final String _images_url = 'http://192.168.81.138:8000/storage/';
  String token = '';

  String getImagesUrl() => _images_url;
  // to get the token
  Future _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'));
  }

  // to make post requests
  Future authData(dynamic data, String apiUrl) async {
    String fullUrl = _url + apiUrl;
    return await post(fullUrl, body: jsonEncode(data), headers: _setHeaders());
  }

  // to make get requests
  Future getData(String apiUrl) async {
    String fullUrl = _url + apiUrl;
    await _getToken();
    return await get(fullUrl, headers: _setHeaders());
  }

  Future sendData(dynamic data, String apiUrl) async {
    String fullUrl = _url + apiUrl;
    await _getToken();
    return await post(fullUrl, body: jsonEncode(data), headers: _setHeaders());
  }

  // set the headers for requests
  Map<String, String> _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

  Future<List<Item>> getCategories() async {
    Response response = await Api().getData('/categories');
    var categories =
        json.decode(response.body)['success']['categories'] as List;
    List<Item> myModels =
        categories.map((dynamic i) => Item.fromJson(i)).toList();
    return myModels;
  }

  Future<List<Item>> getBrands() async {
    Response response = await Api().getData('/brands');
    var brands = json.decode(response.body)['success']['brands'] as List;
    List<Item> myModels = brands.map((dynamic i) => Item.fromJson(i)).toList();
    return myModels;
  }

  Future<List<Item>> getSellers() async {
    Response response = await Api().getData('/sellers');
    var sellers = json.decode(response.body)['success']['sellers'] as List;
    List<Item> myModels = sellers.map((dynamic i) => Item.fromJson(i)).toList();
    return myModels;
  }

  Future<List<Product>> getProducts(String s, int id) async {
    switch (s) {
      case 'category':
        Response response = await Api().getData('/products/category/$id');
        //print(response.body);
        var products = json.decode(response.body)['products'] as List;
        List<Product> myModels =
            products.map((dynamic i) => Product.fromJson(i)).toList();
        //print(myModels);
        return myModels;

      case 'brand':
        Response response = await Api().getData('/products/brand/$id');
        //print(response.body);
        var products = json.decode(response.body)['products'] as List;
        List<Product> myModels =
            products.map((dynamic i) => Product.fromJson(i)).toList();
        //print(myModels);
        return myModels;

      case 'seller':
        Response response = await Api().getData('/products/seller/$id');
        //print(response.body);
        var products = json.decode(response.body)['products'] as List;
        List<Product> myModels =
            products.map((dynamic i) => Product.fromJson(i)).toList();
        //print(myModels);
        return myModels;
    }
  }

  Future<String> getProductCategory(int id) async {
    Response response = await Api().getData('/product/$id/category');
    //print(response.body);
    String category = json.decode(response.body)['category'];

    return category;
  }

  Future<String> getProductBrand(int id) async {
    Response response = await Api().getData('/product/$id/brand');
    //print(response.body);
    String brand = json.decode(response.body)['brand'];

    return brand;
  }

  Future<List<Property>> getProductProperties(int id) async {
    Response response = await Api().getData('/product/$id/prop');
    //print(response.body);
    var property = json.decode(response.body)['properties'] as List;
    List<Property> myModels =
        property.map((dynamic i) => Property.fromJson(i)).toList();
    // print(myModels);
    return myModels;
  }

  Future<List<Property>> otherProperties(int id) async {
    Response response = await Api().getData('/product/$id/other');
    //print(response.body);
    var property = json.decode(response.body)['other'] as List;
    List<Property> myModels =
        property.map((dynamic i) => Property.fromJson(i)).toList();
    //print(myModels);
    return myModels;
  }

  Future<Product> getProduct(int id) async {
    Response response = await Api().getData('/product/$id');
    print(response.body);
    Map<String,dynamic> product = json.decode(response.body)['product'];
    Product myModels = Product(
      id: product['id'],
      name: product['name'],
      image: product['image'],
      price: product['price'],
      description: product['description'],
      brand_id: product['brand_id'],
      category_id: product['category_id'],
      discount: product['discount'],
      item_num: product['item_num'],
      quantity: product['quantity'],
      vendor_id: product['vendor_id'],
    );
    print(myModels);
    return myModels;
  }

  Future<User> profile() async {
    Response response = await Api().getData('/profile');
    print(response.body);
    Map<String,dynamic> user = json.decode(response.body)['user'];
    User myModels = User(
      id: user["id"],
      name: user["name"],
      image: user["image"],
      email: user["email"],
      password: user["password"],
      dob: user["dob"],
      mobile: user["mobile"],
    );
    //print(myModels);
    return myModels;
  }

  Future<List<Product>> search(dynamic data) async {
    Response response = await Api().sendData(data,'/search');
    //print(response.body);
    var products = json.decode(response.body)['products'] as List;
    List<Product> myModels =
        products.map((dynamic i) => Product.fromJson(i)).toList();
    //print(myModels);
    return myModels;
  }

  Future<List<Product>> myItems() async{
    Response response = await Api().getData('/my/items');
    //print(response.body);
    var products = json.decode(response.body)['products'] as List;
    List<Product> myModels =
    products.map((dynamic i) => Product.fromJson(i)).toList();
    //print(myModels);
    return myModels;
  }

  Future<List<OrderItem>> checkReview() async{
    Response response = await Api().getData('/orderReview');
    print(response.body);
    var products = json.decode(response.body)['products'] as List;
    List<OrderItem> myModels =
    products.map((dynamic i) => OrderItem.fromJson(i)).toList();
    //print(myModels);
    return myModels;
  }

}
