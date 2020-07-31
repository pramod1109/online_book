import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class ListScreen extends StatefulWidget {
  final cat, uid;

  ListScreen({@required this.cat, @required this.uid});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final databaseReference = Firestore.instance;
  String uid;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((res) {
//      //print(res);
      uid = res.uid;
    });
  }

  int check_like() {
    databaseReference.collection(widget.cat).getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/Logo_Bhavatarangini.png',
          fit: BoxFit.contain,
          height: 64,
        ),
        backgroundColor: Color(0xff61A4F1),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('categories').document(widget.cat).collection('books').snapshots(),
        builder: (BuildContext content, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if(snapshot.hasData && snapshot.data.documents.length!=0)
          return new ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.documents[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(22.0, 22.0),
                    child: Container(
                      width: 350.0,
                      height: 125.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color(0xffffffff),
                        boxShadow:  [
                          BoxShadow(
                            color: Colors.grey[800].withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(22.0, 22.0),
                    child: Container(
                      width: 84.0,
                      height: 125.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          image: ds['imageUrl'] == null? AssetImage(
                              'assets/images/1.jpeg'):
                           NetworkImage(ds['imageUrl']),
                          fit: BoxFit.fill,
                        ),
                        color: const Color(0xffffffff),
                        border: Border.all(width: 1.0, color: const Color(0xff707070)),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(265.0, 38.0),
                    child: RaisedButton(
                      elevation: 5.0,
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Story(
                                story: ds,
                              )),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.redAccent,
                      child: Text(
                        'చదవండి',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.0,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(124.0, 38.0),
                    child: FlatButton(
                      onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Story(
                              story: ds,
                            )),
                      );
                    },
                      child: Text(
                        ds['title'],
                      style: TextStyle(
                        fontFamily: 'Book Antiqua',
                        fontSize: 28,
                        color: const Color(0xff707070),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    )
                  ),
                  Transform.translate(
                    offset: Offset(124.0, 76.0),
                    child: Text(
              "రచయిత: " + ds['author'],
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 16,
                        color: const Color(0xff707070),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(124.0, 109.0),
                    child: Text(
                      ds['reads'].toString() + " views",
                      style: TextStyle(
                        fontFamily: 'Book Antiqua',
                        fontSize: 12,
                        color: const Color(0xff707070),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(177.0, 109.0),
                    child: Container(
                      width: 80.0,
                      height: 20.0,
                      child:  Row(
                        children: <Widget>[
                          Icon(
                            Icons.file_download,
                            color: Colors.redAccent,
                          ),
                          Text(
                            "గ్రంధాలయం",
                            style: TextStyle(
                                color: Colors.black, fontSize: 12
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(269.0, 94.0),
                    child: Container(
                      width: 29.0,
                      height: 20.0,
                      child: InkWell(
                        onTap: () async {
                          if (!ds['likes'].contains(uid)) {
                            await Firestore.instance
                                .collection(widget.cat)
                                .document(ds.documentID)
                                .updateData({
                              'likes':
                              FieldValue.arrayUnion(
                                  [uid])
                            });
                          } else {
                            await Firestore.instance
                                .collection(widget.cat)
                                .document(ds.documentID)
                                .updateData({
                              'likes':
                              FieldValue.arrayRemove(
                                  [uid])
                            });
                          }
                        },
                        child: Icon(
                          Icons.thumb_up,
                          color: ds['likes'].contains(uid)
                              ? Colors.redAccent
                              : Colors.black54,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(314.0, 94.0),
                    child: Container(
                      width: 29.0,
                      height: 20.0,
                      child:  InkWell(
                        onTap: () async {
                          await Firestore.instance
                              .runTransaction(
                                  (transaction) async {
                                var predata = await transaction
                                    .get(Firestore.instance
                                    .collection(widget.cat)
                                    .document(
                                    ds.documentID));
                                await transaction.update(
                                    Firestore.instance
                                        .collection(widget.cat)
                                        .document(
                                        ds.documentID),
                                    {
                                      'share': predata
                                          .data['share'] +
                                          1
                                    });
                              });
                        },
                        child: Icon(
                          Icons.share,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(276.0, 117.0),
                    child: Text(
                      ds['likes'].length.toString(),
                      style: TextStyle(
                        fontFamily: 'Book Antiqua',
                        fontSize: 14,
                        color: const Color(0xff707070),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(325.0, 117.0),
                    child: Text(
                      ds['share'].toString(),
                      style: TextStyle(
                        fontFamily: 'Book Antiqua',
                        fontSize: 14,
                        color: const Color(0xff707070),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                )
              );
            },
          );
          return Center(child: Text('No Books'));
        },
      ),
    );
  }
}

class Story extends StatefulWidget {
  final story;
  Story({@required this.story});
  @override
  createState() => new StoryState();
}

class StoryState extends State<Story> {
  var font = 18.0;

  @override
  Widget build(BuildContext context) {
//    //print("read");
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/Logo_Bhavatarangini.png',
            fit: BoxFit.contain,
            height: 64,
          ),
          backgroundColor: Color(0xff61A4F1),
          actions: <Widget>[
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    font = font + 2;
                  });
                },
              ),
            ),
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.minimize),
                onPressed: () {
                  setState(() {
                    font = font - 2;
                  });
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Html(
          data: widget.story['story'],
          style: {
            "body": Style(
              fontSize: FontSize(font),
            ),
          },
        )));
  }
}
