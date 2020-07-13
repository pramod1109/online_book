import 'package:flutter/material.dart';
import 'package:online_book/models/user.dart';

class Constants {
  //Routes
  static final String RootRoute = '/';
  static final String MySimpleDialog = '/MySimpleDialog';
  static final String MyFloatButton = '/MyFloatButton';
  static final String MyBottomNav = '/MyBottomNav';


  static List<User> cat = <User>[
    User(name: 'Horror Story', phoneNo: '033312345678'),
    User(name: 'Romantic Story', phoneNo: '033312345678'),
    User(name: 'Triller Story', phoneNo: '033312345678'),
    User(name: 'Kid Story', phoneNo: '033312345678'),
    User(name: 'Shahid Story', phoneNo: '033312345678'),
    User(name: 'Autobiography ', phoneNo: '033312345678'),
    User(name: 'Salman Haider', phoneNo: '033312345678'),
    User(name: 'Awais Ahmed', phoneNo: '033312345678'),
    User(name: 'Imran Qaiser', phoneNo: '033312345678'),
    User(name: 'Ali Ahmed', phoneNo: '033312345678'),
  ];
}

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);