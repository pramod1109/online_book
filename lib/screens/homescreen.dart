import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_book/screens/ProfileScreen.dart';
import 'package:online_book/screens/home_first.dart';
import 'package:online_book/screens/library.dart';
import 'package:online_book/screens/notifications.dart';
import 'package:online_book/screens/write_screen.dart';

List<String> _contents = <String>[
  'హోమ్',
  'గ్రంథాలయం',
  'రాయండి',
  'నోటిఫికేషన్స్',
  ' మారిన్ని',
];

class HomeScreen extends StatefulWidget {
  final uid;

  HomeScreen({@required this.uid});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final _auth = FirebaseAuth.instance;

  FirebaseUser loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
//        //print(loggedInUser.email);
      }
    } catch (e) {
//      //print(e);
    }
  }

  _onTapItem(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _myBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: Color(0xff61A4F1),
      unselectedItemColor: Colors.black.withOpacity(0.5),
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 100.0,
      onTap: _onTapItem,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(_contents[0]),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books),
          title: Text(_contents[1]),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mode_edit),
          title: Text(_contents[2]),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          title: Text(_contents[3]),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_vert),
          title: Text(_contents[4]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'భావతరంగిణి',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Image.asset(
              'assets/images/Logo_Bhavatarangini.png',
              fit: BoxFit.contain,
              height: 64,
            ),
            backgroundColor: Color(0xff61A4F1),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 35.0,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
              ),
            ],
          ),
          body: BottomNavContents(
            index: _currentIndex,
            uid: widget.uid,
          ),
          bottomNavigationBar: _myBottomNavBar(),
        ));
  }
}

class BottomNavContents extends StatelessWidget {
  final int index;
  String uid;

  BottomNavContents({this.index, this.uid});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: navBarContents(index, context),
    );
  }

  Widget navBarContents(int index, BuildContext context) {
    switch (index) {
      case 0:
        return HomeFirst(uid);
      case 1:
        return Library();
      case 2:
        return WriteScreen();
      case 3:
        return Notifications(uid: uid,);
      default:
        return Text("Coming soon");
    }
  }
}
