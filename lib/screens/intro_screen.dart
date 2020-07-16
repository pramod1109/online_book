import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_book/screens/ProfileInput.dart';
import 'package:online_book/screens/homescreen.dart';
import 'package:online_book/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IntroScreen extends StatefulWidget{


  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((res) {
      print(res);
      final snapShot = Firestore.instance
          .collection("user")
          .document(res.uid)
          .get();
      if (res != null) {
            if (snapShot != null) {
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(uid: res.uid)),
                );
            }
            else{
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfileInputScreen()),
              );
            }
      }
      else
      {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
        ),
      ),
    );
  }
}