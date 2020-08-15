import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_book/screens/ProfileInput.dart';
import 'package:online_book/screens/homescreen.dart';
import 'package:online_book/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_book/services/notif.dart';
import 'package:online_book/services/storage.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((res) {
//      //print(res);
      if (res != null) {
        final snapShot = Firestore.instance
            .collection("user")
            .document(res.uid)
            .get()
            .then((value) async {
          if (value.data != null) {
            String nt = await NotificationHandler.instance.init(context);
            await Firestore.instance.collection('user').document(res.uid).updateData({'notif_token':nt});
            Storage.user = value.data;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(uid: res.uid)),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileInputScreen(res.uid)),
            );
          }
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage('assets/images/Splash_Screen.png'),fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,);
  }
}
