import 'package:flutter/material.dart';
import 'package:flutter_smartmarket/screens/profile/profile.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  ListView(
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
          onTap: () {},
          child: ListTile(
            title: Text('Home Page'),
            leading: Icon(
              Icons.home,
              color: Colors.red,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push<Object>(context, new MaterialPageRoute<dynamic>(
                builder: (context) => Profile()));
          },
          child: ListTile(
            title: Text('My Accuont'),
            leading: Icon(
              Icons.person,
              color: Colors.red,
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('My Orders'),
            leading: Icon(
              Icons.shopping_basket,
              color: Colors.red,
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('Shopping Cart'),
            leading: Icon(
              Icons.shopping_cart,
              color: Colors.red,
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('Favourites'),
            leading: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
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
          onTap: () {},
          child: ListTile(
            title: Text('Settings'),
            leading: Icon(
              Icons.settings,
              color: Colors.black54,
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('About'),
            leading: Icon(
              Icons.help,
              color: Colors.blue[600],
            ),
          ),
        ),
      ],
    );
  }
}
