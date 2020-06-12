import 'package:flutter_smartmarket/models/product.dart';

class OrderItem {
  int id;
  int order_id;
  int product_id;
  int quantity;
  int price;
  int done;
  int rated;
  Product product;

  OrderItem(
      {this.id,
        this.price,
        this.quantity,
        this.product_id,
        this.done,
        this.order_id,
        this.rated,
        this.product
      });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json["id"],
    price: json["price"],
    quantity: json["quantity"],
    rated: json["rated"],
    product_id: json["product_id"],
    done: json["done"],
    order_id: json["order_id"],
    product: Product(
      id: json['product']['id'],
      name: json['product']['name'],
      image: json['product']['image'],
      price: json['product']['price'],
      description: json['product']['description'],
      brand_id: json['product']['brand_id'],
      category_id: json['product']['category_id'],
      discount: json['product']['discount'],
      item_num: json['product']['item_num'],
      quantity: json['product']['quantity'],
      vendor_id: json['product']['vendor_id'],
    )
  );

}
