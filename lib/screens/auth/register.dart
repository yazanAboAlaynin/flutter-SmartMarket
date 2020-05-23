import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_smartmarket/screens/home/home.dart';
import 'package:flutter_smartmarket/services/api.dart';
import 'package:flutter_smartmarket/shared/constants.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_smartmarket/shared/loading.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';
  String confirm_password = '';
  String mobile = '';
  String dob = DateTime.now().toString();
 // String image;

  String error = '';
  bool loading = false;

  Future<Null> _selectDate(BuildContext context) async {
    //var status = await Permission.accessMediaLocation.status;
    final DateTime picked = await DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1950, 1, 1),
        maxTime: DateTime.now(), onConfirm: (date) {
      setState(() {
        dob = date.toString();
      });
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  File _image;

  Future getImage() async {
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
      });
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
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
                      Container(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  RaisedButton(
                                    onPressed: (){
                                      widget.toggleView();
                                    },
                                    shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    color: Colors.blue[400],
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],),
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
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 20),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Center(
                                  child: _image == null
                                      ? Text('No image selected.')
                                      : Image.file(_image),
                              ),
                              RaisedButton(
                                shape: ContinuousRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30))),
                                onPressed: getImage,
                                child: Icon(Icons.add_a_photo),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Name', icon: Icon(Icons.person),),
                                validator: (val) =>
                                    val.isEmpty ? 'Enter your Name' : null,
                                onChanged: (val) {
                                  setState(() {
                                    name = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Email', icon: Icon(Icons.email)),
                                validator: (val) =>
                                    val.isEmpty ? 'Enter an email' : null,
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Password',
                                    icon: Icon(Icons.https)),
                                obscureText: true,
                                validator: (val) => val.length < 8
                                    ? 'Enter a password 8+ chars long'
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Confirm Password',
                                    icon: Icon(Icons.https)),
                                obscureText: true,
                                validator: (val) => val.length < 8
                                    ? 'Enter a password 8+ chars long'
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    confirm_password = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Mobile',
                                    icon: Icon(Icons.phone_android)),
                                validator: (val) =>
                                    val.isEmpty ? 'Enter your number' : null,
                                onChanged: (val) {
                                  setState(() {
                                    mobile = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(children: <Widget>[
                                Text('Date of Birth: '),
                                SizedBox(
                                  width: 15,
                                ),
                                Text("${dob}".split(' ')[0]),
                                SizedBox(
                                  width: 15,
                                ),
                                RaisedButton(
                                  shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  onPressed: () => _selectDate(context),
                                  child: Text('Select date'),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                              ]),
                              SizedBox(
                                height: 30,
                              ),

                              RaisedButton(
                                shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                color: Colors.blue[400],
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    var data = {
                                      'name': email,
                                      'email': email,
                                      'password': password,
                                      'c_password': confirm_password,
                                      'mobile': mobile,
                                      'dob': dob,
                                      'image': _image,
                                    };
                                    Response response =
                                    await Api().authData(data, '/register');
                                    Map<String,dynamic> body = json.decode(response.body);
                                    print(body);
                                    if (body['success'] != null) {
                                      print('here');
                                      SharedPreferences localStorage =
                                      await SharedPreferences.getInstance();
                                      localStorage.setString(
                                          'token', json.encode(body['success']['token']));
                                      localStorage.setString(
                                          'user', json.encode(body['user']));
                                      Navigator.pushReplacement<Object,Object>(
                                        context,
                                        new MaterialPageRoute<dynamic>(
                                            builder: (context) => Home()),
                                      );
                                    } else {
                                      // _showMsg(body['message']);
                                    }

                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                },
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
          ),
        ),
      ),
    );
  }
}

