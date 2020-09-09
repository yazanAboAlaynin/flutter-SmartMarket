import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_smartmarket/models/item.dart';
import 'package:flutter_smartmarket/models/order_item.dart';
import 'package:flutter_smartmarket/models/product.dart';
import 'package:flutter_smartmarket/screens/cart/cart_view.dart';
import 'package:flutter_smartmarket/screens/display/products_card.dart';
import 'package:flutter_smartmarket/screens/rating/order_review.dart';
import 'package:flutter_smartmarket/services/api.dart';
import 'package:flutter_smartmarket/shared/loading.dart';
import 'package:flutter_smartmarket/shared/my_drawer.dart';
import 'package:flutter_smartmarket/shared/waiting.dart';
import 'package:http/http.dart';

import 'image_carusel.dart';
import 'item_display.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading1 = false;
  bool loading2 = false;
  bool loading3 = false;
  bool loading = false;
  List<OrderItem> items = [];
  void _checkReview() async {
    setState(() {
      loading = true;
    });

    List<OrderItem> x = await Api().checkReview();

    setState(() {
      items = x;
      loading = false;
    });

    getCategories();
    getBrands();
    getSellers();
  }

  List<Item> categories = List<Item>();
  Future<void> getCategories() async {
    setState(() {
      loading1 = true;
    });
    List<Item> x = await Api().getCategories();
    setState(() {
      categories = x;
      loading1 = false;
    });
  }

  List<Item> brands = List<Item>();
  Future<void> getBrands() async {
    setState(() {
      loading2 = true;
    });
    List<Item> x = await Api().getBrands();
    setState(() {
      brands = x;
      loading2 = false;
    });
  }

  List<Item> sellers = List<Item>();
  Future<void> getSellers() async {
    setState(() {
      loading3 = true;
    });
    List<Item> x = await Api().getSellers();
    setState(() {
      sellers = x;
      loading3 = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkReview();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // ==== widget for image =======
    if (items.length != 0) {
      return ListOrder(items: items);
    }
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              elevation: 0.1,
              title: Text(
                'Smart Market',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              backgroundColor: Colors.blue[200],
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showSearch(context: context, delegate: DataSearch());
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push<Object>(
                        context,
                        new MaterialPageRoute<dynamic>(
                            builder: (context) => CartView()));
                  },
                )
              ],
            ),

            // ====== start side bar =====
            drawer: Drawer(
              child: MyDrawer(),
            ),
            //===== end side bar =======
            // =========start body===============
            body: ListView(
              children: <Widget>[
                Container(
                  child: SafeArea(
                      child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // =========display image==============
                        ImageCarusel(),
                        // ========Text Category============
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 2.0, left: 8.0, right: 8.0),
                          child: Text(
                            'Categories',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // =========Category===========
                        loading1
                            ? Waiting()
                            : DisplayWidgetArea(
                                itemList: categories,
                                type: 'category',
                              ),

                        // ========Text brand============
                        SizedBox(
                          height: 20.0,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 2.0, left: 8.0, right: 8.0),
                          child: Text(
                            'Brand',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),

                        // ========Brand=========

                        loading2
                            ? Waiting()
                            : DisplayWidgetArea(
                                itemList: brands,
                                type: 'brand',
                              ),

                        // ========Text MostSelling============
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 2.0, left: 8.0, right: 8.0),
                          child: Text(
                            'Most Sellers',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),

                        // ========MostSelling=========

                        loading3
                            ? Waiting()
                            : DisplayWidgetArea(
                                itemList: sellers,
                                type: 'seller',
                              ),
                      ],
                    ),
                  )),
                ),
              ],
            ),
          );
  }
}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ShowPs(
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

class ShowPs extends StatefulWidget {
  String query;
  ShowPs({this.query});
  @override
  _ShowPsState createState() => _ShowPsState();
}

class _ShowPsState extends State<ShowPs> {
  List<Product> products = List<Product>();
  Future<void> getProducts() async {
    var data = {
      'query': widget.query,
    };
    List<Product> x = await Api().search(data);
    setState(() {
      products = x;
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 15.0, left: 22),
      width: MediaQuery.of(context).size.width - 30.0,
      height: MediaQuery.of(context).size.height,
      child: MyProducts(
        productsList: products,
        press: true,
      ),
    );
  }
}
