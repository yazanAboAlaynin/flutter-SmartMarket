import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ======== image ========
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/shop2.jpg"),
              fit: BoxFit.contain,
              alignment: Alignment.topCenter,
            ),
          ),
          // ========== text and icon back ===============
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // =========== design =================
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  height: MediaQuery.of(context).size.height * 0.72,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                  ),
                  // ==========text field=============
                  child: ListView(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Welcome',
                            style: TextStyle(
                                color: Color(0xfff032f42),
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Register',
                            style: TextStyle(color: Colors.grey, fontSize: 20),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          InputTextField(
                            label: "Name",
                            icon: Icon(Icons.person),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InputTextField(
                            label: "Email",
                            icon: Icon(Icons.email),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InputTextField(
                            label: "Password",
                            isPassword: true,
                            icon: Icon(
                              Icons.https,
                              size: 27,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InputTextField(
                            label: "Mobile",
                            icon: Icon(Icons.phone_android),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InputTextField(
                            label: "dob",
                            icon: Icon(Icons.phone_android),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InputTextField(
                            label: "image",
                            icon: Icon(Icons.phone_android),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue[600],
                            ),
                            child: Center(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//===========text field=====================
class InputTextField extends StatelessWidget {
  final String label;
  final Widget icon;
  final bool isPassword;

  InputTextField({this.label, this.icon, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Color(0xfff234253), fontWeight: FontWeight.bold),
      obscureText: isPassword,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
          labelText: label,
          labelStyle:
              TextStyle(color: Color(0xfff234253), fontWeight: FontWeight.bold),
          suffixIcon: icon),
    );
  }
}
