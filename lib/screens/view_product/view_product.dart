import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smartmarket/models/cart.dart';
import 'package:flutter_smartmarket/models/product.dart';
import 'package:flutter_smartmarket/models/property.dart';
import 'package:flutter_smartmarket/screens/view_product/bottom.dart';
import 'package:flutter_smartmarket/services/api.dart';
import 'package:flutter_smartmarket/shared/constants.dart';
import 'package:flutter_smartmarket/shared/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetails extends StatefulWidget {
  int id;
  ProductDetails({this.id});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Product product;
  int qty = 1;
  String category = '';
  String brand = '';
  List<Property> properties = [];
  List<Property> other = [];
  bool loading = true;

  Future<void> getCategory() async {
    String x = await Api().getProductCategory(product.id);
    setState(() {
      category = x;
    });
  }

  Future<void> getBrand() async {
    String x = await Api().getProductBrand(product.id);
    setState(() {
      brand = x;
    });
  }

  Future<void> getProductProperties() async {
    List<Property> x = await Api().getProductProperties(product.id);
    setState(() {
      properties = x;
    });
    otherProp();
  }

  Future<void> otherProp() async {
    List<Property> x = await Api().otherProperties(product.id);
    setState(() {
      other = x;
    });
  }

  Future<void> getProduct(int id) async {
    Product x = await Api().getProduct(id);
    setState(() {
      product = x;
      loading = false;
    });
    getCategory();
    getBrand();
    getProductProperties();
  }

  @override
  void initState() {
    super.initState();
    getProduct(widget.id);
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: InkWell(
                onTap: () {},
                child: Text(
                  product.name,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
              backgroundColor: Colors.blue[200],
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ],
            ),

            // === body =====
            body: ListView(
              children: <Widget>[
                Container(
                  height: 240.0,
                  child: GridTile(
                    // =========display image===============
                    child: Container(
                      color: Colors.white,
                      child:
                          Image.network(Api().getImagesUrl() + product.image),
                    ),
                    // =============display name product and price abrove image ===================
                  ),
                ),
                Container(
                  color: Colors.white70,
                  child: ListTile(
                    leading: Text(
                      'Price:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    title: Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          "\$ ${product.price}",
                          style: TextStyle(
                              //decoration: TextDecoration.lineThrough,
                              color: Colors.grey),
                        )),
                        Expanded(
                            child: Text(
                          "Discount:  % ${product.discount}",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w600),
                        )),
                      ],
                    ),
                  ),
                ),
                // ===== the first buttons =====
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: <Widget>[
                      Text('quantity:   '),
                      InkWell(
                        onTap: () {
                          if (qty > 1) {
                            setState(() {
                              qty--;
                            });
                          }
                        },
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: Colors.blue[300],
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                      // ===================number======================
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          '$qty',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                      ),
                      // ================== qut + ===================
                      InkWell(
                        onTap: () {
                          if (qty < 10) {
                            setState(() {
                              qty++;
                            });
                          }
                        },
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: Colors.blue[300],
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ======= the second buttons ======
                Row(
                  children: <Widget>[
                    // ========= the Buy button ==========
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            product.qty = qty;
                          });

                          Cart.addItem(product);
                        },
                        color: Colors.blue[200],
                        textColor: Colors.white,
                        elevation: 0.2,
                        child: Text('Add to cart'),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.add_shopping_cart,
                          color: Colors.red[300],
                          size: 30,
                        ),
                        onPressed: () {}),
                  ],
                ),

                // ===============description==================
                Divider(
                  endIndent: 20.0,
                  thickness: 1.5,
                  indent: 15.0,
                  height: 10.0,
                ),
                Text(
                  'Product properties',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                ShowProperties(
                  prop: properties,
                  other: other,
                ),
                ListTile(
                  title: Text(
                    'Product details',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text(product.description),
                ),
                Divider(
                  endIndent: 20.0,
                  thickness: 1.5,
                  indent: 15.0,
                  height: 10.0,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                      child: Text(
                        'Category name',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(category),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                      child: Text(
                        'Product Brand',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(brand),
                    ),
                  ],
                ),
              ],
            ),

            // ==============Floating Action Button===================
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.blue[300],
              child: Icon(Icons.shopping_cart),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomBar(),
          );
  }
}

class ShowProperties extends StatefulWidget {
  List<Property> prop;
  List<Property> other;
  ShowProperties({this.prop, this.other});
  @override
  _ShowPropertiesState createState() => _ShowPropertiesState();
}

class _ShowPropertiesState extends State<ShowProperties> {
  @override
  Widget build(BuildContext context) {
    List<Widget> properties = new List<Widget>();
    for (int i = 0; i < widget.prop.length; i++) {
      List<Property> l = [];
      for (int j = 0; j < widget.other.length; j++) {
        Property op = widget.other[j];
        if (op.name == widget.prop[i].name) {
          l.add(op);
        }
      }
      Widget property = ListTile(
        title: Text('${widget.prop[i].name}'),
        subtitle: DropdownButtonFormField(
          value: widget.prop[i].product_id,
          decoration: textInputDecoration,
          items: l.map((property) {
            return DropdownMenuItem(
              value: property.product_id,
              child: Text('${property.value}'),
            );
          }).toList(),
          onChanged: (val) {
            Navigator.pushReplacement<Object, Object>(
                context,
                new MaterialPageRoute<dynamic>(
                    builder: (context) => ProductDetails(
                          id: val,
                        )));
          },
        ),
      );
      properties.add(property);
    }
    return Container(
      //height: 150.0,
      // width: 250.0,
      child: Column(
        children: properties,
      ),
    );
  }
}
