import 'package:flutter/material.dart';
import 'package:flutter_smartmarket/models/product.dart';
class Cart{
  static List<Product> list = [];
  static double total = 0;

  static void addItem(Product product){
    list.add(product);
  }

  static void deleteItem(int index){
    list.removeAt(index);
  }

  static void calcTotal(){
    double tot = 0;
    for(int i=0;i<list.length;i++){
      double tmp = (list[i].price - (list[i].price * list[i].discount)/100.0)*list[i].qty;
      tot+= tmp;
    }
    total = tot;
  }

  static void decQty(int index){
    list[index].qty--;
    calcTotal();
    print(total);
  }

  static void incQty(int index){
    list[index].qty++;
    calcTotal();
  }

  static Map<String,int> getProducts(){
    Map<String,int> m = {};
    for(int i=0;i<list.length;i++){
      m['${list[i].id}'] = list[i].qty;
    }
    return m;
  }

  static void clear(){
    list.clear();
    total = 0;
  }


}