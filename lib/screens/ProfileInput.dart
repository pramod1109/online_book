import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:online_book/screens/homescreen.dart';
import 'package:online_book/utilites/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileInputScreen extends StatefulWidget {
  String uid;

  ProfileInputScreen(this.uid);

  @override
  _ProfileInputState createState() => _ProfileInputState();
}

class _ProfileInputState extends State<ProfileInputScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  int month = 1, day = 1;
  String year = '2001';

  int maxday;
  bool uploading = false;

  String gender = 'Male';

  @override
  void initState() {
    super.initState();
  }

  Widget _buildNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _nameController,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.account_box,
                color: Colors.black,
              ),
              hintText: 'Enter your Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone Number',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.number,
            controller: _phoneController,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.black,
              ),
              hintText: 'Enter your Phone Number',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: _submit,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'SUBMIT',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        key: _formKey,
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 30.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(height: 100,child:Image.asset('assets/images/Logo_Bhavatarangini.png')),
                        SizedBox(height: 10.0),
                        _buildNameTF(),
                        SizedBox(height: 30.0),
                        _buildPhoneTF(),
                        SizedBox(height: 30.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: kBoxDecorationStyle,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 70.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'Gender',
                                style: kLabelStyle,
                              ),
                              DropdownButton(
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
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        _buildSubmitBtn(),
                      ],
                    ),
                  ),
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
          ),
        ),
      ),
    );
  }

  void _submit() async {
    setState(() {
      uploading = true;
    });
    try {
      await Firestore.instance.collection("user").document(widget.uid).setData({
        "name": _nameController.text,
        "phone": _phoneController.text,
        'dob': {'day': day, 'month': month, 'year': year},
        'gender': gender,
        'uid': widget.uid,
        "liked": null
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  uid: widget.uid,
                )),
      );
    } catch (e) {
//      //print(e.message);
    }
  }
}
