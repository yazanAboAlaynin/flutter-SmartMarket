import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ListOrder extends StatefulWidget {
  @override
  _ListOrderState createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {

  var product_list_order = [
    {
      "name" : "H",
      "picture" : "images/product8.jpg",
      "old_price" : 200,
      "price" : 100,
    },
    {
      "name" : "Shoe",
      "picture" : "images/product10.jpg",
      "old_price" : 100,
      "price" : 90,
    },
    {
      "name" : "dd",
      "picture" : "images/product7.jpg",
      "old_price" : 400,
      "price" : 200,
    },


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rating'),
        backgroundColor: Colors.blue[200],
      ),
      body: GridView.builder(
          padding: EdgeInsets.only(top: 10),
          itemCount: product_list_order.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2
          ),
          itemBuilder: (BuildContext context , int index){
            return Single_product(
              product_name: product_list_order[index]['name'],
              product_picture: product_list_order[index]['picture'],
              product_old_price: product_list_order[index]['old_price'],
              product_price: product_list_order[index]['price'],
            );
          }
      ),
    );
  }
}

class Single_product extends StatelessWidget {

  final product_name;
  final product_picture;
  final product_old_price;
  final product_price;


  Single_product({this.product_name, this.product_picture,
    this.product_old_price, this.product_price});


  var rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: Text('hero 1'),
        child: Material(
          child: InkWell(
            onTap:(){
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Rate'),

                      content: SmoothStarRating(
                        rating: rating,
                        size: 40,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: true,
                        spacing: 2.0,
                        color: Colors.amber,
                        onRated: (value) {
                          print("rating value -> $value");
                          // print("rating value dd -> ${value.truncate()}");
                        },
                      ),
                      actions: <Widget>[
                        MaterialButton(
                          onPressed: (){
                            Navigator.of(context).pop(context);
                          },
                          child: Text("close"),
                        ),
                      ],
                    );
                  }
              );
            },
            child: GridTile(
              footer: Container(
                color: Colors.white70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(product_name,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 23.0)),
                    ),
                    Text('\$$product_price',style: TextStyle(fontWeight: FontWeight.w800,color: Colors.redAccent,fontSize: 16.0),),
                  ],
                ),
              ),
              child: Image.asset(product_picture,fit: BoxFit.fill),
            ),
          ),

        ),
      ),
    );
  }
}

