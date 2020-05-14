import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

// ==========categories================
var categoryItems = ["Laptop", "Watch", "Shoe", "Classes"];
var categoryImage = [
  "images/product7.jpg",
  "images/product8.jpg",
  "images/product10.jpg",
  "images/product11.jpg"
];
// =============brand================
var brandItems = ["Laptop", "Watch", "Shoe", "Classes"];
var brandImage = [
  "images/product7.jpg",
  "images/product8.jpg",
  "images/product10.jpg",
  "images/product11.jpg"
];
// =============Most Selling=================
var mostSellingItems = ["Laptop", "Watch", "Shoe", "Classes"];
var mostSellingImage = [
  "images/product7.jpg",
  "images/product8.jpg",
  "images/product10.jpg",
  "images/product11.jpg"
];

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // ==== widget for image =======
    Widget image_carousel = Container(
      height: 180.0,
      child: Carousel(
        boxFit: BoxFit.cover,
         images: <AssetImage>[
          AssetImage('images/product7.jpg'),
          AssetImage('images/product8.jpg'),
          AssetImage('images/product10.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000,),
        dotSize: 5.0,
        indicatorBgPadding: 5.0,
        dotBgColor: Colors.transparent,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        title: Text('Smart Market',
          style: TextStyle(color: Colors.white, fontSize: 18.0),),
        backgroundColor: Colors.blue[200],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white,), onPressed: () {},),
          IconButton(icon: Icon(Icons.shopping_cart, color: Colors.white,),
            onPressed: (){},)
        ],
      ),

      // ====== start side bar =====
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            // ====== start header ===
            UserAccountsDrawerHeader(
              accountName: Text('Mohammad Sulaiman'),
              accountEmail: Text('mohammadsulaiman@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/p.jpg'),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue[200],
              ),
            ),

            // ====== start body in the side bar ====
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home,color: Colors.red,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('My Accuont'),
                leading: Icon(Icons.person,color: Colors.red,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(Icons.shopping_basket,color: Colors.red,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Shopping Cart'),
                leading: Icon(Icons.shopping_cart,color: Colors.red,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Favourites'),
                leading: Icon(Icons.favorite,color: Colors.red,),
              ),
            ),

            //======الخط الفاصل =====
            Divider(
              height: 6.0,
              indent: 16.0,
              endIndent: 16.0,
              color: Colors.black26,
              thickness: 0.7,
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings,color: Colors.black54,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('About'),
                leading: Icon(Icons.help,color: Colors.blue[600],),
              ),
            ),
          ],
        ),
      ),
      //===== end side bar =======
      // =========start body===============
      body: ListView(
        children: <Widget>[
          Container(
            height: screenHeight,
            width: screenWidth,
            child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // =========display image==============
                      image_carousel,
                      // ========Text Category============
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0 , bottom: 2.0,left: 8.0,right: 8.0),
                        child: Text('Categories',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      ),
                      // =========Category===========
                      DisplayWidgetArea(name: "categoryItems", pathImg: "categoryImage",),

                      // ========Text brand============
                      Padding(
                        padding: const EdgeInsets.only(top: 13.0 , bottom: 1.0,left: 8.0,right: 8.0),
                        child: Text('Brand',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      ),

                      // ========Brand=========
                      SizedBox(height: 10.0,),
                      DisplayWidgetArea(name: "brandItems",pathImg: "brandImage",),

                      // ========Text MostSelling============
                      Padding(
                        padding: const EdgeInsets.only(top: 13.0 , bottom: 1.0,left: 8.0,right: 8.0),
                        child: Text('Most Selling',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      ),

                      // ========MostSelling=========
                      SizedBox(height: 10.0,),
                      DisplayWidgetArea(name: "mostSellingItems",pathImg: "mostSellingImage",),

                    ],
                  ),
                )),
          ),

        ] ,

      ),
    );
  }
}


class DisplayWidgetArea extends StatelessWidget {

  String name ;
  String pathImg ;


  DisplayWidgetArea({this.name, this.pathImg});

  @override
  Widget build(BuildContext context) {


    var screenWidth = MediaQuery.of(context).size.width;

    // ===========width of the Display================
    PageController controller =
    PageController(viewportFraction: 0.6, initialPage: 1);

    // ==============list of Displays=====================
    List<Widget> categories = new List<Widget>();

    for (int x = 0; x < categoryItems.length; x++) {
      var categoryView = Padding(
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
                child: Image.asset(
                  categoryImage[x],
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
                      categoryItems[x],
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
      // ==========var add to list=================
      categories.add(categoryView);
    }
    //============design box============
    return Container(
      width: screenWidth,
      height: screenWidth * 9 / 23,
      child: PageView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: categories,
      ),
    );

  }

}


