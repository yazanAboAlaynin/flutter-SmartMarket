import 'package:flutter/material.dart';
import 'package:flutter_smartmarket/models/cart.dart';
import 'package:flutter_smartmarket/models/product.dart';
import 'package:flutter_smartmarket/services/api.dart';

class CartItem extends StatefulWidget {
  Product product;
  int index;
  Function calc;
  CartItem({this.product,this.index,this.calc});

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {

  @override
  Widget build(BuildContext context) {
    double priceAfterDiscount = (widget.product.price-
        (widget.product.price * widget.product.discount)/100.0)*widget.product.qty;

    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          // ================image =====================
          Container(
            width: 90,
            height: 90,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(Api().getImagesUrl()+widget.product.image),fit: BoxFit.fill),
              color: Colors.blue[400],
              borderRadius: BorderRadius.only(topRight: Radius.circular(6),bottomRight: Radius.circular(6),bottomLeft: Radius.circular(6),topLeft: Radius.circular(6)),
            ),
          ),
          // ==================name and qut===================
          SizedBox(width: 15.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // ==================name===================

                Row(
                  children: <Widget>[
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 10,top: 1),
                      child: Icon(Icons.close,size: 18,color: Colors.black,),
                    ),

                  ],
                ),
                Container(
                  width: 100.0,
                  child: Text(widget.product.name,style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    // ================== qut - ===================
                    InkWell(
                      onTap: () {
                        if (widget.product.qty > 1) {
                          setState(() {
                            Cart.decQty(widget.index);
                            widget.calc();
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
                        '${widget.product.qty}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ),
                    // ================== qut + ===================
                    InkWell(
                      onTap: () {
                        if (widget.product.qty < 10) {
                          setState(() {
                            Cart.incQty(widget.index);
                            widget.calc();
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
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        '\$$priceAfterDiscount',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0,color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
