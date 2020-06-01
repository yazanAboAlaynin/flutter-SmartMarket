import 'package:flutter/material.dart';
import 'package:flutter_smartmarket/models/product.dart';
import 'package:flutter_smartmarket/models/user.dart';
import 'package:flutter_smartmarket/screens/display/products_card.dart';
import 'package:flutter_smartmarket/services/api.dart';
import 'package:flutter_smartmarket/shared/loading.dart';


class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user;
  bool loading = true;
  List<Product> products = List<Product>();

  Future<void> getData()async{
    User u = await Api().profile();
    setState(() {
      user = u;
      loading = false;
    });
  }

  Future<void> myItems()async{
    List<Product> x = await Api().myItems();
    setState(() {
      products = x;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    myItems();
  }
  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.blue[200],
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10,),
          // ================ name and dob and phone and email ========================
          Padding(
            padding: EdgeInsets.only(top: 18.0, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // ================name=========================
                      SizedBox(height: 15,),
                      Text(user.name, style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                      // ==============dob and phone==================
                      SizedBox(height: 12,),
                      Row(
                        children: <Widget>[
                          Icon(Icons.date_range,color: Colors.grey[200],),
                          SizedBox(width: 20,),
                          Text('${user.dob.substring(0,10)}', style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),),
                        ],
                      ),
                      SizedBox(height: 12.0,),
                      Row(
                        children: <Widget>[
                          Icon(Icons.phone_android,color: Colors.grey[200],),
                          SizedBox(width: 20,),
                          Text('${user.mobile}', style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),),
                        ],
                      ),

                    ],
                  ),
                ),
                // ===================image=========================
                Padding(
                  padding: EdgeInsets.only(right: 9),
                  child: CircleAvatar(
                    radius: 56.6,
                    backgroundImage: NetworkImage(Api().getImagesUrl() + user.image),
                  ),
                ),

              ],
            ),
          ),
          // =================email===========================
          SizedBox(height: 10.0,),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Column(
              children: <Widget>[

                Row(
                  children: <Widget>[
                    Icon(Icons.email,color: Colors.grey[200],),
                    SizedBox(width: 5,),
                    Text(user.email, style: TextStyle(fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70),),
                  ],),
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.only(left: 176),
                  child: Container(
                    child: RaisedButton(
                      onPressed: (){},
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // =================border circular  ==========================
          SizedBox(height: 16.0,),
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height - 186.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            // =================List View for my Shop=======================
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 26.0, right: 20.0),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 26.0),
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height - 300,
                    child: ListView(
                      children: <Widget>[
                        // =================text======================
                        Padding(
                          padding: EdgeInsets.only(left: 100),
                          child: Text(
                            'My Items',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(height: 6,),
                        // =============List my shop===================
                        Container(
                          height: 300.0,
                          padding: EdgeInsets.only(right: 8.0),
                          width: MediaQuery.of(context).size.width - 30.0,
                         // height: MediaQuery.of(context).size.height - 250,
                          child: MyProducts(productsList: products),
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===============  My Shop Item ===========================
  Widget _bulidMyShopItem(String imgPath, String productName, String price) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  // =================image===================
                  Hero(
                    tag: imgPath,
                    child: CircleAvatar(
                      radius: 48,
                      backgroundImage: AssetImage(imgPath),
                    ),
                  ),
                  SizedBox(width: 16.0,),
                  // =================name product and price===================
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(productName, style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),),
                      SizedBox(height: 2.0,),
                      Text(price,
                        style: TextStyle(fontSize: 14.0, color: Colors.red),),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

