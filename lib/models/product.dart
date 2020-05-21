class Product {
  int id;
  String name;
  String image;
  String item_num;
  String description;
  int price;
  int quantity;
  int vendor_id;
  int category_id;
  int brand_id;
  int discount;
  int qty;
  Product(
      {this.id,
      this.price,
      this.brand_id,
      this.category_id,
      this.description,
      this.discount,
      this.item_num,
      this.quantity,
      this.vendor_id,
      this.name,
      this.image,
      });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        brand_id: json["brand_id"],
        category_id: json["category_id"],
        description: json["description"],
        discount: json["discount"],
        item_num: json["item_num"],
        quantity: json["quantity"],
        vendor_id: json["vendor_id"],
      );

  Map<String, dynamic> toJson(Product p){
    Map<String, dynamic> j = {};
    j['id'] = p.id;
    j['name'] = p.name;
    j['image'] = p.image;
    j['price'] = p.price;
    j['brand_id'] = p.brand_id;
    j['category_id'] = p.category_id;
    j['description'] = p.description;
    j['discount'] = p.discount;
    j['item_num'] = p.item_num;
    j['quantity'] = p.quantity;
    j['vendor_id'] = p.vendor_id;
    j['qty'] = p.qty;
    return j;
  }
  void decQty(){
    qty--;
  }
  void incQty(){
    qty++;
  }
}
