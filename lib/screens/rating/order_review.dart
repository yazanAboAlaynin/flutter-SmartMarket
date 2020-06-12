import 'package:flutter/material.dart';
import 'package:flutter_smartmarket/models/order_item.dart';
import 'package:flutter_smartmarket/screens/home/home.dart';
import 'package:flutter_smartmarket/services/api.dart';
import 'package:flutter_smartmarket/shared/constants.dart';
import 'package:http/http.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ListOrder extends StatefulWidget {
  List<OrderItem> items;
  ListOrder({this.items});
  @override
  _ListOrderState createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {

  void erase(index){
    setState(() {
      widget.items.removeAt(index);
    });
    print(widget.items.length);
    if(widget.items.length == 0){
      Navigator.pushReplacement<Object, Object>(
        context,
        new MaterialPageRoute<dynamic>(
            builder: (context) => Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rating'),
        backgroundColor: Colors.blue[200],
      ),
      body: GridView.builder(
          padding: EdgeInsets.only(top: 10),
          itemCount: widget.items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2
          ),
          itemBuilder: (BuildContext context , int index){
            return Single_product(
              product_name: widget.items[index].product.name,
              product_picture: widget.items[index].product.image,
              product_id: widget.items[index].product_id,
              product_price: widget.items[index].price,
              order_id: widget.items[index].order_id,
              f: erase,
              index: index,
            );
          }
      ),
    );
  }
}

class Single_product extends StatefulWidget {

  final product_name;
  final product_picture;
  final product_id;
  final product_price;
  final order_id;
  final index;
  Function f;


  Single_product({this.product_name, this.product_picture,
    this.product_id, this.product_price,this.order_id,this.f,this.index});

  @override
  _Single_productState createState() => _Single_productState();
}

class _Single_productState extends State<Single_product> {
  var rating = 0.0;
  final _formKey = GlobalKey<FormState>();

  String comment='';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: Text('hero 1'),
        child: Material(
          child: InkWell(
            onTap:(){
              showDialog<Future>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Rate'),

                      content: Container(
                        height: 130.0,
                        child: Column(

                          children: <Widget>[
                            SmoothStarRating(
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
                                value = value.roundToDouble();
                                print("rating value -> $value");
                                setState((){
                                  rating = value;
                                });
                              },
                            ),
                            SizedBox(height: 10,),
                            Form(
                            key: _formKey,
                              child: TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'comment',
                                   ),
                                obscureText: true,
                                validator: (val) => val.length < 1
                                    ? 'Leave Comment please!'
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    comment = val;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        MaterialButton(
                          onPressed: () async{
                            if (_formKey.currentState.validate()) {
                              var data = {
                                'rate': rating,
                                'id': widget.product_id,
                                'order': widget.order_id,
                                'comment': comment,
                              };
                              Response response =
                              await Api().sendData(data, '/review');
                              Navigator.of(context).pop();
                              widget.f(widget.index);
                              print(response.body);
                            }
                          },
                          child: Text("Ok"),
                        ),
                        MaterialButton(
                          onPressed: (){
                            Navigator.of(context).pop();
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
                      child: Text(widget.product_name,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 23.0)),
                    ),
                    Text('${widget.product_price} S.P',style: TextStyle(fontWeight: FontWeight.w800,color: Colors.redAccent,fontSize: 16.0),),
                  ],
                ),
              ),
              child: Image.network(Api().getImagesUrl()+widget.product_picture,fit: BoxFit.fill),
            ),
          ),

        ),
      ),
    );
  }
}

