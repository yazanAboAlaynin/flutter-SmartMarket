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
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  String address = '';
  String gender = null;
  String carrer = '';
  String social_status = null;
  String scientific_level = null;
  String three_most_hobbies = '';

  String dob = DateTime.now().toString();
  // String image;

  String error = '';
  bool loading = false;

  List genders = ['Male', 'Female'];
  List socials_status = [
    'Single',
    'Married',
    'Widowed',
    'Separated',
    'Divorced'
  ];
  List scientific_levels = [
    'Not Educated',
    'High school diploma',
    'Associate degree',
    'Bachelor\'s degree',
    'Master\'s degree',
    'Doctoral degree'
  ];

  upload(File imageFile, data, context) async {
    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("http://192.168.43.145:8000/api/register");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);
    request.fields['name'] = data['name'];
    request.fields['email'] = data['email'];
    request.fields['password'] = data['password'];
    request.fields['c_password'] = data['c_password'];
    request.fields['mobile'] = data['mobile'];
    request.fields['dob'] = data['dob'];
    request.fields['address'] = data['address'];
    request.fields['gender'] = data['gender'];
    request.fields['career'] = data['career'];
    request.fields['social_status'] = data['social_status'];
    request.fields['scientific_level'] = data['scientific_level'];

    // send
    var response = await request.send();
    print('here');
    print(response.reasonPhrase);
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) async {
      print(value);
      Map<String, dynamic> body = json.decode(value);
      if (value != null) {
        print('here');
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', json.encode(body['success']['token']));
        Navigator.pushReplacement<Object, Object>(
          context,
          new MaterialPageRoute<dynamic>(builder: (context) => Home()),
        );
      } else {
        // _showMsg(body['message']);
      }
    });

    setState(() {
      loading = false;
    });
  }

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
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            // ======== image ========
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                                  onPressed: () {
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
                              ],
                            ),
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
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      bottomRight: Radius.circular(30))),
                              onPressed: getImage,
                              child: Icon(Icons.add_a_photo),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                hintText: 'Name',
                                icon: Icon(Icons.person),
                              ),
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
                              height: 15,
                            ),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Address', icon: Icon(Icons.home)),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter your address' : null,
                              onChanged: (val) {
                                setState(() {
                                  address = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'career',
                                  icon: Icon(Icons.format_align_justify)),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter your carrer' : null,
                              onChanged: (val) {
                                setState(() {
                                  carrer = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 60.0,
                              child: DropdownButtonFormField(
                                itemHeight: 50.0,
                                value: gender,
                                validator: (value) =>
                                    value == null ? 'field required' : null,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Gender',
                                    icon: Icon(Icons.person_outline)),
                                items: genders.map((s) {
                                  return DropdownMenuItem(
                                    value: s,
                                    child: Text(s),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    gender = val;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 60.0,
                              child: DropdownButtonFormField(
                                itemHeight: 50.0,
                                value: social_status,
                                validator: (value) =>
                                    value == null ? 'field required' : null,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Social Status',
                                    icon: Icon(Icons.person_outline)),
                                items: socials_status.map((s) {
                                  return DropdownMenuItem(
                                    value: s,
                                    child: Text(s),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    social_status = val;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 60.0,
                              child: DropdownButtonFormField(
                                itemHeight: 50.0,
                                value: scientific_level,
                                validator: (value) =>
                                    value == null ? 'field required' : null,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Scientific level',
                                    icon: Icon(Icons.person_outline)),
                                items: scientific_levels.map((s) {
                                  return DropdownMenuItem(
                                    value: s,
                                    child: Text(s),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    scientific_level = val;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 15,
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
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
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
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
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
                                    'name': name,
                                    'email': email,
                                    'password': password,
                                    'c_password': confirm_password,
                                    'mobile': mobile,
                                    'dob': dob,
                                    'address': address,
                                    'gender': gender,
                                    'social_status': social_status,
                                    'scientific_level': scientific_level,
                                    'career': carrer,
                                  };
                                  upload(_image, data, context);
//                                    Response response =
////                                    await Api().authData(data, '/register');
////                                    Map<String,dynamic> body = json.decode(response.body);
////                                    print(body);

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
            ),
          );
  }
}
