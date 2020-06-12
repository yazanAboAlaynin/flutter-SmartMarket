import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smartmarket/models/cart.dart';
import 'package:flutter_smartmarket/models/product.dart';
import 'package:flutter_smartmarket/services/api.dart';
import 'package:flutter_smartmarket/shared/loading.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_item.dart';
import 'cart_items.dart';


class CartView extends StatefulWidget {

  @override
  _CartViewState createState() => _CartViewState();

}

class _CartViewState extends State<CartView> {
  bool loading = false;
  void calc(){
    setState(() {
      Cart.calcTotal();
    });
  }
  @override
  Widget build(BuildContext context) {
  Cart.calcTotal();
    return loading? Loading() : Scaffold(
      appBar: AppBar(
        title: Text('Cart view'),
        backgroundColor: Colors.blue[200],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: CartItems(calc),
          ),

        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text('Total : '),
                subtitle: Text('${Cart.total} S.P'),
              ),
            ),

            Expanded(
              child: MaterialButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  Map<String,int> m = Cart.getProducts();
                  Response response = await Api().sendData(m,'/order');
                  Map<String, dynamic> body =
                  json.decode(response.body);
                  bool success = true;
                  success = body['success'] == null ? false:true;
                  if(success){
                    Cart.clear();
                  }
                  setState(() {
                    loading = false;
                  });
                },
                child: Text('Check out',style: TextStyle(color: Colors.blue[50]),),
                color: Colors.blue[300],
              ),
            ),

          ],
        ),
      ),
    );
  }
}