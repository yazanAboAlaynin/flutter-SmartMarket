import 'package:flutter/material.dart';
import 'package:flutter_smartmarket/models/item.dart';
import 'package:flutter_smartmarket/screens/display/show_products.dart';

import 'home.dart';

class DisplayWidgetArea extends StatelessWidget {
  List<Item> itemList;
  DisplayWidgetArea({this.itemList});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    // ===========width of the Display================
    PageController controller =
        PageController(viewportFraction: 0.6, initialPage: 1);

    // ==============list of Displays=====================
    List<Widget> items = new List<Widget>();

    for (int i = 0; i < itemList.length; i++) {
      print(itemList[i].name);
      var view = InkWell(
        onTap: (){
          Navigator.push<Object>(context, new MaterialPageRoute<dynamic>(
              builder: (context) => DetailsPage()));
        },
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                // ==========shadow of box===================
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(26.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[900],
                            offset: Offset(2.0, 2.0),
                            blurRadius: 6.0,
                            spreadRadius: 1.0)
                      ]),
                ),
                // ==========image in box=================
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  child: Image.network(
                    'http://192.168.1.7:8000/storage/' + itemList[i].image,
                    fit: BoxFit.cover,
                  ),
                ),
                // ==========shadow above the image==============
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black])),
                ),
                // ===============text above the image ==================
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        itemList[i].name,
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
      // ==========var add to list=================
      items.add(view);
    }
    ;
    //============design box============
    return Container(
      width: screenWidth,
      height: screenWidth * 9 / 23,
      child: PageView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: items,
      ),
    );
  }
}
