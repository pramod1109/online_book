import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_book/screens/homescreen.dart';
import 'package:online_book/screens/login_screen.dart';
import 'package:online_book/screens/subscription.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  bool _status = true;
  var dob;
  final FocusNode myFocusNode = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  String name, gender;
  String imageUrl, mobile, uid;
  bool imageChanged = false, uploading = false;

  File _image;

  Future<String> getDetails() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await Firestore.instance
        .collection('user')
        .document(user.uid)
        .get()
        .then((value) {
      setState(() {
        uid = user.uid;
        name = value.data['name'];
        imageUrl = value.data['image'] ?? user.photoUrl;
        mobile = value.data['phone'];
        dob = value.data['dob'];
        gender = value.data['gender'];
      });
    });
  }

  @override
  Future<void> initState() {
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  if (_status) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Subscription(uid),
                        ));
                  }
                },
                child: Text(
                  'Interests',
                  style: TextStyle(color: Colors.blue),
                )),
            FlatButton(
                onPressed: () {
                  if (_status) {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) {
                      return LoginScreen();
                    }));
                  }
                },
                child: Text(
                  'Log Out',
                  style: TextStyle(color: Colors.blue),
                )),
          ],
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20),
                    child: new Stack(fit: StackFit.loose, children: <Widget>[
                      new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                              width: 140.0,
                              height: 140.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  image: _image == null
                                      ? imageUrl != null
                                          ? NetworkImage(imageUrl)
                                          : AssetImage('assets/images/as.png')
                                      : FileImage(_image),
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 90.0, right: 100.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              if (!_status)
                                new CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 25.0,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                    onPressed: pickImage,
                                  ),
                                ),
                              if (!_status && _image != null)
                                CircleAvatar(
                                  backgroundColor: Colors.green,
                                  radius: 25.0,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        imageChanged = false;
                                        _image = null;
                                      });
                                    },
                                  ),
                                ),
                            ],
                          )),
                    ]),
                  ),
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 25.0, right: 25.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Personal Information',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    _status ? _getEditIcon() : new Container(),
                                  ],
                                )
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Name',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: _status
                                      ? Text(name ?? '-')
                                      : new TextField(
                                          controller: _nameController,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                            hintText: "Enter Your Name",
                                          ),
                                          enabled: !_status,
                                          autofocus: !_status,
                                        ),
                                ),
                              ],
                            )),
                        /*Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Date Of Birth',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],

                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: ListTile(
                                    title: Text(dob != null
                                        ? "${dob['day']}/${dob['month']}/${dob['year']}"
                                        : '-'),
                                    trailing: Icon(
                                      Icons.keyboard_arrow_down,
                                      color:
                                          _status ? Colors.white : Colors.black,
                                    ),
                                    onTap: _pickDate,
                                  ),
                                ),
                              ],
                            )),*/
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Mobile',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: _status
                                      ? Text(mobile ?? '-')
                                      : TextField(
                                          controller: _mobileController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                              hintText: "Enter Mobile Number"),
                                          enabled: !_status,
                                        ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Gender',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: _status
                                      ? Text(gender ?? '-')
                                      : DropdownButton(
                                          items: [
                                            DropdownMenuItem(
                                              child: Text('Male'),
                                              value: 'Male',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Female'),
                                              value: 'Female',
                                            ),
                                          ],
                                          value: gender,
                                          onChanged: (v) {
                                            setState(() {
                                              gender = v;
                                            });
                                          },
                                          isExpanded: true,
                                        ),
                                ),
                              ],
                            )),
                        !_status ? _getActionButtons() : new Container(),
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (uploading)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[CircularProgressIndicator()],
                ),
              )
          ],
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () async {
                  setState(() {
                    uploading = true;
                  });
                  String img;
                  final FirebaseUser user = await firebaseAuth.currentUser();
                  await Firestore.instance
                      .collection("user")
                      .document(user.uid)
                      .updateData({
                    "name": _nameController.text,
                    "dob": dob,
                    "phone": _mobileController.text,
                    'gender': gender
                  });
                  if (imageChanged && _image != null) {
                    img = await _uploadFile();
                    await Firestore.instance
                        .collection("user")
                        .document(user.uid)
                        .updateData({
                      "image": img,
                    });
                  }
                  setState(() {
                    uploading = false;
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                  getDetails();
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    _image = null;
                    imageChanged = false;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  Future<String> pickImage() async {
    //Get the file from the image picker and store it
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
      imageChanged = true;
    });
  }

  _pickDate() async {
    if (!_status) {
      DateTime date = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDate: DateTime(int.parse(dob['year']), dob['month'], dob['day']),
      );

      if (date != null) {
        setState(() {
          dob = {
            'year': date.year,
            'month': date.month,
            'day': date.day,
          };
        });
      }
    }
  }

  Future<String> _uploadFile() async {
    try {
      final StorageReference storageRef = FirebaseStorage.instance
          .ref()
          .child(_nameController.text + "-Profileimage");
      final StorageUploadTask task = storageRef.putFile(_image);
      return await (await task.onComplete).ref.getDownloadURL();
    } catch (error) {
//      //print(error.toString());
      throw error.toString();
    }
  }
}
