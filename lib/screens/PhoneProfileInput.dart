import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:online_book/screens/homescreen.dart';
import 'package:online_book/utilites/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneProfileInputScreen extends StatefulWidget {
  String uid,phone;

  PhoneProfileInputScreen(this.uid,this.phone);

  @override
  _PhoneProfileInputState createState() => _PhoneProfileInputState();
}

class _PhoneProfileInputState extends State<PhoneProfileInputScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.account_box,
                color: Colors.white,
              ),
              hintText: 'Enter your Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              hintText: 'Enter your Email',
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
    if (month == 1 ||
        month == 3 ||
        month == 5 ||
        month == 7 ||
        month == 8 ||
        month == 10 ||
        month == 12) {
      maxday = 31;
    } else if (month == 2) {
      if (int.parse(year) % 4 == 0 &&
          (int.parse(year) % 100 != 0 ||
              (int.parse(year) % 100 == 0 && int.parse(year) % 400 == 0))) {
        maxday = 29;
      } else {
        maxday = 28;
      }
    } else {
      maxday = 30;
    }
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
                        _buildEmailTF(),
                        SizedBox(height: 30.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Date of Birth',
                            style: kLabelStyle,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: kBoxDecorationStyle,
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16),
                              height: 70.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'Month',
                                    style: kLabelStyle,
                                  ),
                                  DropdownButton(
                                    items: List.generate(12, (index) {
                                      return DropdownMenuItem(
                                        child: Text('${index + 1}'),
                                        value: index + 1,
                                      );
                                    }),
                                    value: month,
                                    onChanged: (v) {
                                      setState(() {
                                        month = v;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: kBoxDecorationStyle,
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16),
                              height: 70.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'Day',
                                    style: kLabelStyle,
                                  ),
                                  DropdownButton(
                                    items: List.generate(maxday, (index) {
                                      return DropdownMenuItem(
                                        child: Text('${index + 1}'),
                                        value: index + 1,
                                      );
                                    }),
                                    value: day,
                                    onChanged: (v) {
                                      setState(() {
                                        day = v;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: kBoxDecorationStyle,
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16),
                              height: 70.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'Year',
                                    style: kLabelStyle,
                                  ),
                                  DropdownButton(
                                    items: List.generate(100, (index) {
                                      return DropdownMenuItem(
                                        child: Text('${1920 + index}'),
                                        value: '${1920 + index}',
                                      );
                                    }),
                                    value: year,
                                    onChanged: (v) {
                                      setState(() {
                                        year = v;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
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
        "email": _emailController.text,
        'dob': {'day': day, 'month': month, 'year': year},
        'phone': widget.phone,
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
      print(e.message);
    }
  }
}
