import 'package:flutter/material.dart';
import 'package:flutter_smartmarket/screens/profile/profile.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      // ============display circular bottom app bar============
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      color: Colors.transparent,
      elevation: 9.0,
      clipBehavior: Clip.antiAlias,
      // ==============height and border Radius bottom app bar ====================
      child: Container(
        height: 46.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0),topRight: Radius.circular(25.0)),
          color: Colors.white,
        ),
        // ======================display icon ==============================
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width /2 - 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.home,color: Color(0xffef7532),),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                  ),
                ],
              ),
            ),

            Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width /2 - 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                      onTap: (){
                        Navigator.push<Object>(
                          context,
                          new MaterialPageRoute<dynamic>(
                              builder: (context) => Profile()),
                        );
                      },
                      child: Icon(Icons.person_outline,color: Color(0xff676e79),)),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
