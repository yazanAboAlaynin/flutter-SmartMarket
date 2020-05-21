import 'package:flutter/material.dart';
import 'package:flutter_smartmarket/models/cart.dart';
import 'package:flutter_smartmarket/models/product.dart';

import 'cart_item.dart';

class CartItems extends StatefulWidget {
  Function f;
  CartItems(Function fn){
    f = fn;
  }
  @override
  _CartItemsState createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  List<Product> items = Cart.list;

  @override
  Widget build(BuildContext context) {
    List<Widget> products = [];
    products.add( SizedBox(height: 10.0,));
    for(int i=0;i<items.length;i++){
      products.add(CartItem(product: items[i],index: i,calc: widget.f,));
    }
    return Column(
      children:
        products,
    );
  }
}
