import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_smartmarket/models/item.dart';
import 'package:flutter_smartmarket/services/api.dart';
import 'package:flutter_smartmarket/shared/my_drawer.dart';
import 'package:http/http.dart';

import 'image_carusel.dart';
import 'item_display.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Item> categories = List<Item>();
  Future<void> getCategories() async {
    List<Item> x = await Api().getCategories();
    setState(() {
      categories = x;
    });
  }

  List<Item> brands = List<Item>();
  Future<void> getBrands() async {
    List<Item> x = await Api().getBrands();
    setState(() {
      brands = x;
    });
  }

  List<Item> sellers = List<Item>();
  Future<void> getSellers() async {
    List<Item> x = await Api().getSellers();
    setState(() {
      sellers = x;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategories();
    getBrands();
    getSellers();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // ==== widget for image =======

    return Scaffold(
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
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {},
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
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // =========Category===========
                  DisplayWidgetArea(itemList: categories),

                  // ========Text brand============
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 13.0, bottom: 1.0, left: 8.0, right: 8.0),
                    child: Text(
                      'Brand',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // ========Brand=========
                  SizedBox(
                    height: 10.0,
                  ),
                  DisplayWidgetArea(itemList: brands),

                  // ========Text MostSelling============
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 13.0, bottom: 1.0, left: 8.0, right: 8.0),
                    child: Text(
                      'Most Sellers',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // ========MostSelling=========
                  SizedBox(
                    height: 10.0,
                  ),
                  DisplayWidgetArea(itemList: sellers),
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }
}
