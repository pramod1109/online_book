import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_book/screens/horror.dart';
import 'package:online_book/utilites/constants.dart';

class GridList extends StatelessWidget{
  final _random = Random();

  @override
  Widget build(BuildContext context) {
            return SingleChildScrollView(
                  child: GridView.count(
                      padding: EdgeInsets.all(10.0),
                      crossAxisCount: 2,
                      controller: new ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      childAspectRatio: (600.0/400.0),
                      mainAxisSpacing: 0.5,
                      crossAxisSpacing: 0.5,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(7.0),
                            child: FlatButton(
                              child:Container(
                                child: Center(
                                  child: Text("కథలు",
                                      style: TextStyle(fontSize: 20.0,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                      )
                                  )
                                ),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(const  Radius.circular(3.0)),
                                  boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[800].withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 5,
                                        offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                  image: new DecorationImage(
                                    image: new ExactAssetImage('assets/images/1.jpeg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HorrorScreen()),
                                );
                              },
                              padding: EdgeInsets.all(0.0),
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(7.0),
                            child: FlatButton(
                              child:Container(
                                child: Center(
                                    child: Text("కవితలు",
                                        style: TextStyle(fontSize: 20.0,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )
                                    )
                                ),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(const  Radius.circular(3.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[800].withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  image: new DecorationImage(
                                    image: new ExactAssetImage('assets/images/2.jpeg'),
                                    fit: BoxFit.cover,
                                  ),

                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HorrorScreen()),
                                );
                              },
                              padding: EdgeInsets.all(0.0),
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(7.0),
                            child: FlatButton(
                              child:Container(
                                child: Center(
                                    child: Text("సంపాదకీయం",
                                        style: TextStyle(fontSize: 20.0,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )
                                    )
                                ),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(const  Radius.circular(3.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[800].withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  image: new DecorationImage(
                                    image: new ExactAssetImage('assets/images/2.jpeg'),
                                    fit: BoxFit.cover,
                                  ),

                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HorrorScreen()),
                                );
                              },
                              padding: EdgeInsets.all(0.0),
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(7.0),
                            child: FlatButton(
                              child:Container(
                                child: Center(
                                    child: Text("భావ స్పందన",
                                        style: TextStyle(fontSize: 20.0,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )
                                    )
                                ),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(const  Radius.circular(3.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[800].withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  image: new DecorationImage(
                                    image: new ExactAssetImage('assets/images/1.jpeg'),
                                    fit: BoxFit.cover,
                                  ),

                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HorrorScreen()),
                                );
                              },
                              padding: EdgeInsets.all(0.0),
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(7.0),
                            child: FlatButton(
                              child:Container(
                                child: Center(
                                    child: Text("గ్రంథ సమీక్ష",
                                        style: TextStyle(fontSize: 20.0,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )
                                    )
                                ),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(const  Radius.circular(3.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[800].withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  image: new DecorationImage(
                                    image: new ExactAssetImage('assets/images/1.jpeg'),
                                    fit: BoxFit.cover,
                                  ),

                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HorrorScreen()),
                                );
                              },
                              padding: EdgeInsets.all(0.0),
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(7.0),
                            child: FlatButton(
                              child:Container(
                                child: Center(
                                    child: Text("బాలతరంగిణి ",
                                        style: TextStyle(fontSize: 20.0,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )
                                    )
                                ),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(const  Radius.circular(3.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[800].withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  image: new DecorationImage(
                                    image: new ExactAssetImage('assets/images/2.jpeg'),
                                    fit: BoxFit.cover,
                                  ),

                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HorrorScreen()),
                                );
                              },
                              padding: EdgeInsets.all(0.0),
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(7.0),
                            child: FlatButton(
                              child:Container(
                                child: Center(
                                    child: Text("హాస్యం",
                                        style: TextStyle(fontSize: 20.0,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )
                                    )
                                ),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(const  Radius.circular(3.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[800].withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  image: new DecorationImage(
                                    image: new ExactAssetImage('assets/images/2.jpeg'),
                                    fit: BoxFit.cover,
                                  ),

                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HorrorScreen()),
                                );
                              },
                              padding: EdgeInsets.all(0.0),
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(7.0),
                            child: FlatButton(
                              child:Container(
                                child: Center(
                                    child: Text("నవలలు ",
                                        style: TextStyle(fontSize: 20.0,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )
                                    )
                                ),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(const  Radius.circular(3.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[800].withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  image: new DecorationImage(
                                    image: new ExactAssetImage('assets/images/1.jpeg'),
                                    fit: BoxFit.cover,
                                  ),

                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HorrorScreen()),
                                );
                              },
                              padding: EdgeInsets.all(0.0),
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(7.0),
                            child: FlatButton(
                              child:Container(
                                child: Center(
                                    child: Text("బాల సాహిత్యం ",
                                        style: TextStyle(fontSize: 20.0,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )
                                    )
                                ),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(const  Radius.circular(3.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[800].withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  image: new DecorationImage(
                                    image: new ExactAssetImage('assets/images/1.jpeg'),
                                    fit: BoxFit.cover,
                                  ),

                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HorrorScreen()),
                                );
                              },
                              padding: EdgeInsets.all(0.0),
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(7.0),
                            child: FlatButton(
                              child:Container(
                                child: Center(
                                    child: Text("బాల వ్యాఖ్య ",
                                        style: TextStyle(fontSize: 20.0,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )
                                    )
                                ),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(const  Radius.circular(3.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[800].withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0,1), // changes position of shadow
                                    ),
                                  ],
                                  image: new DecorationImage(
                                    image: new ExactAssetImage('assets/images/2.jpeg'),
                                    fit: BoxFit.cover,
                                  ),

                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HorrorScreen()),
                                );
                              },
                              padding: EdgeInsets.all(0.0),
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(7.0),
                            child: FlatButton(
                              child:Container(
                                child: Center(
                                    child: Text("నానీలు ",
                                        style: TextStyle(fontSize: 20.0,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )
                                    )
                                ),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(const  Radius.circular(3.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[800].withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0,1), // changes position of shadow
                                    ),
                                  ],
                                  image: new DecorationImage(
                                    image: new ExactAssetImage('assets/images/2.jpeg'),
                                    fit: BoxFit.cover,
                                  ),

                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HorrorScreen()),
                                );
                              },
                              padding: EdgeInsets.all(0.0),
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(7.0),
                            child: FlatButton(
                              child:Container(
                                child: Center(
                                    child: Text("చిత్ర వ్యాఖ్య",
                                        style: TextStyle(fontSize: 20.0,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )
                                    )
                                ),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(const  Radius.circular(3.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[800].withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0,1), // changes position of shadow
                                    ),
                                  ],
                                  image: new DecorationImage(
                                    image: new ExactAssetImage('assets/images/1.jpeg'),
                                    fit: BoxFit.cover,
                                  ),

                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HorrorScreen()),
                                );
                              },
                              padding: EdgeInsets.all(0.0),
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(7.0),
                            child: FlatButton(
                              child:Container(
                                child: Center(
                                    child: Text("చిత్ర కథ ",
                                        style: TextStyle(fontSize: 20.0,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )
                                    )
                                ),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(const  Radius.circular(3.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[800].withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0,1), // changes position of shadow
                                    ),
                                  ],
                                  image: new DecorationImage(
                                    image: new ExactAssetImage('assets/images/1.jpeg'),
                                    fit: BoxFit.cover,
                                  ),

                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HorrorScreen()),
                                );
                              },
                              padding: EdgeInsets.all(0.0),
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(7.0),
                            child: FlatButton(
                              child:Container(
                                child: Center(
                                    child: Text("భావగీతం ",
                                        style: TextStyle(fontSize: 20.0,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )
                                    )
                                ),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(const  Radius.circular(3.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[800].withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0,1), // changes position of shadow
                                    ),
                                  ],
                                  image: new DecorationImage(
                                    image: new ExactAssetImage('assets/images/2.jpeg'),
                                    fit: BoxFit.cover,
                                  ),

                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HorrorScreen()),
                                );
                              },
                              padding: EdgeInsets.all(0.0),
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(7.0),
                            child: FlatButton(
                              child:Container(
                                child: Center(
                                    child: Text("చిత్ర కవిత ",
                                        style: TextStyle(fontSize: 20.0,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )
                                    )
                                ),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(const  Radius.circular(3.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[800].withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0,1), // changes position of shadow
                                    ),
                                  ],
                                  image: new DecorationImage(
                                    image: new ExactAssetImage('assets/images/2.jpeg'),
                                    fit: BoxFit.cover,
                                  ),

                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HorrorScreen()),
                                );
                              },
                              padding: EdgeInsets.all(0.0),
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(7.0),
                            child: FlatButton(
                              child:Container(
                                child: Center(
                                    child: Text("కార్టూన్  వ్యాఖ్య",
                                        style: TextStyle(fontSize: 20.0,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )
                                    )
                                ),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(const  Radius.circular(3.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[800].withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0,1), // changes position of shadow
                                    ),
                                  ],
                                  image: new DecorationImage(
                                    image: new ExactAssetImage('assets/images/1.jpeg'),
                                    fit: BoxFit.cover,
                                  ),

                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HorrorScreen()),
                                );
                              },
                              padding: EdgeInsets.all(0.0),
                            )
                        ),
                      ],
                    )
            );
  }

  int next(int min, int max) => min + _random.nextInt(max - min);
}