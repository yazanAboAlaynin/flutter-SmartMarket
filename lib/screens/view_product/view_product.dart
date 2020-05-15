import 'package:flutter/material.dart';
import 'package:flutter_smartmarket/screens/view_product/bottom.dart';

class ProductDetails extends StatefulWidget {


  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: (){},
          child: Text('Smart Market',
            style: TextStyle(color: Colors.white, fontSize: 18.0),),
        ),
        backgroundColor: Colors.blue[200],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white,), onPressed: () {},),

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
                child: Image.asset('images/product7.jpg'),
              ),
              // =============display name product and price abrove image ===================
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text('laptop',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                  title: Row(
                    children: <Widget>[
                      Expanded(child: Text("\$ 100",style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey),)),
                      Expanded(child: Text("\$ 60",style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.w600),)),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ===== the first buttons =====
          Row(
            children: <Widget>[
              // ===== the size button ====
              Expanded(
                child: MaterialButton(
                  elevation: 0.2,
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Size'),
                            content: Text('Chooes the size'),
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
                  color: Colors.white,
                  textColor: Colors.grey,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('Size'),
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),

              // ====== the Colors button ======
              Expanded(
                child: MaterialButton(
                  elevation: 0.2,
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Color'),
                            content: Text('Chooes the color'),
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
                  color: Colors.white,
                  textColor: Colors.grey,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('Color'),
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),
              // ====== the Quantity button ======
              Expanded(
                child: MaterialButton(
                  elevation: 0.2,
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Quantity'),
                            content: Text('Chooes the quantity'),
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
                  color: Colors.white,
                  textColor: Colors.grey,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('Qty'),
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          // ======= the second buttons ======
          Row(
            children: <Widget>[
              // ========= the Buy button ==========
              Expanded(
                child: MaterialButton(
                  onPressed: (){},
                  color: Colors.blue[200],
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: Text('Buy now'),
                ),
              ),
              IconButton(icon: Icon(Icons.add_shopping_cart,color: Colors.red[300],size: 30,), onPressed: (){}),
            ],
          ),

          // ===============description==================
          Divider(endIndent: 20.0,thickness: 1.5,indent: 15.0,height: 10.0,),
          ListTile(
            title: Text('product details',style: TextStyle(fontWeight: FontWeight.w400),),
            subtitle: Text('A shoe is an item of footwear intended to protect and comfort the human foot. Shoes are also used as an item of decoration and fashion. The design of shoes has varied enormously through time and from culture to culture, with appearance originally being tied to function.'),
          ),
          Divider(endIndent: 20.0,thickness: 1.5,indent: 15.0,height: 10.0,),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text('Category Name',style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(padding: EdgeInsets.all(5.0),
                child: Text('laptop'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text('Product Brand',style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(padding: EdgeInsets.all(5.0),
                child: Text('4.5'),
              ),
            ],
          ),



        ],
      ),

      // ==============Floating Action Button===================
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.blue[300],
        child: Icon(Icons.shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),

    );
  }
}


