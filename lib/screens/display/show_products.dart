import 'package:flutter/material.dart';
import 'package:flutter_smartmarket/models/item.dart';
import 'package:flutter_smartmarket/models/product.dart';
import 'package:flutter_smartmarket/screens/display/products_card.dart';
import 'package:flutter_smartmarket/services/api.dart';

class ShowProducts extends StatefulWidget {
  Item item;
  String type;
  ShowProducts({this.item,this.type});

  @override
  _ShowProductsState createState() => _ShowProductsState();
}

class _ShowProductsState extends State<ShowProducts> {

  List<Product> products = List<Product>();
  Future<void> getProducts() async {
    List<Product> x = await Api().getProducts(widget.type, widget.item.id);
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
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          widget.item.name,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search), color: Colors.white, onPressed: () {}),
        ],
      ),
      body: ListView(
        children: [
          Stack(
            children: <Widget>[
              // ==========display height and width for page===============
              Container(
                height: MediaQuery.of(context).size.height - 80,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
              // =============size and design app bar==================
              Positioned(
                top: 75.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45.0),
                      topRight: Radius.circular(45.0),
                    ),
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height - 80,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              // =============Display the image of the catagory by place ======================
              Positioned(
                top: 6,
                left: (MediaQuery.of(context).size.width / 2) - 73,
                child: Hero(
                  tag: "tag",
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        Api().getImagesUrl() +
                            widget.item.image),
                  ),
                ),
                height: 146,
                width: 146,
              ),
              // ===================Display the box of the products ================================
              Positioned(
                top: 160,
                left: 20,
                right: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 15.0),
                      width: MediaQuery.of(context).size.width - 30.0,
                      height: MediaQuery.of(context).size.height - 250,
                      child: MyProducts(productsList: products),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


