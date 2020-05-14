import 'package:flutter/material.dart';


class DetailsPage extends StatefulWidget {

  @override
  _DetailsPageState createState() => _DetailsPageState();
}


class _DetailsPageState extends State<DetailsPage> {

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
        title: Text('Type Details', style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),),
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
                height: MediaQuery
                    .of(context)
                    .size
                    .height - 80,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height - 80,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                ),
              ),
              // =============Display the image of the catagory by place ======================
              Positioned(
                top: 6,
                left: (MediaQuery
                    .of(context)
                    .size
                    .width / 2) - 73,
                child: Hero(
                  tag: "tag",
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/product7.jpg'),
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
                      child: GridView.count(
                        crossAxisCount: 2,
                        primary: false,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 15.0,
                        childAspectRatio: 0.8,
                        children: <Widget>[
                          _bulidCard('Shoe', '\$100', 'images/product10.jpg'),
                          _bulidCard('Laptop', '\$105', 'images/product11.jpg'),
                          _bulidCard('Shoe', '\$100', 'images/product10.jpg'),
                          _bulidCard('Laptop', '\$105', 'images/product11.jpg'),
                          _bulidCard('Shoe', '\$100', 'images/product10.jpg'),
                          _bulidCard('Laptop', '\$105', 'images/product11.jpg'),

                        ],
                      ),

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


Widget _bulidCard(String name,String price,String imgPath){
  return Padding(
    padding: EdgeInsets.only(top:5.0,right: 5.0,left: 5.0,bottom: 5.0),
    child: InkWell(
      onTap: (){},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3.0,
              blurRadius: 5.0,
            ),
          ],
          color: Colors.white,
        ),

        child: Column(
          children: [
            Hero(
              tag: imgPath,
              child: Container(
                height: 151.0,
                width: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0),topRight: Radius.circular(12.0),bottomLeft: Radius.circular(9.0),bottomRight: Radius.circular(9.0)),
                  image: DecorationImage(
                    image: AssetImage(imgPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            SizedBox(height: 6.6,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(fontSize: 14.0,color: Colors.black54),
                ),
                Text(
                  price,
                  style: TextStyle(fontSize: 14.0,color: Colors.red[200]),
                ),
              ],
            ),

          ],
        ),

      ),
    ),
  );
}

