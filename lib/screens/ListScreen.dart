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
      print(res);
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
        stream: Firestore.instance.collection(widget.cat).snapshots(),
        builder: (BuildContext content, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return new ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.documents[index];
              return Card(
                  color: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 96,
                          child: AspectRatio(
                            aspectRatio: 3 / 4,
                            child: Image(
                              image: AssetImage('assets/images/1.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Container(
                          width: 200.0,
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  ds['title'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  "రచయిత: " + ds['author'],
                                  style: TextStyle(fontSize: 12),
                                  textAlign: TextAlign.left,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(ds['reads'].toString() + " views"),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Icon(
                                      Icons.file_download,
                                      color: Colors.redAccent,
                                    ),
                                    Text(
                                      "గ్రంధాలయం",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.lightBlueAccent[100],
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(8),
                                              topLeft: Radius.circular(8))),
                                      padding: const EdgeInsets.all(4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          InkWell(
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
                                              size: 28,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            'Share (' +
                                                ds['share'].toString() +
                                                ')',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w100,
                                              fontFamily: 'OpenSans',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 1,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.lightGreenAccent,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(8),
                                              topLeft: Radius.circular(8))),
                                      padding: const EdgeInsets.all(4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 3,
                                          ),
                                          InkWell(
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
                                                  ? Colors.white
                                                  : Colors.black54,
                                              size: 28,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            'Like (' +
                                                ds['likes'].length.toString() +
                                                ')',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w100,
                                              fontFamily: 'OpenSans',
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                      Spacer(),
                      Container(
                        width: 36,
                        height: 128,
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'చ\nద\nవం\nడి',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ));
            },
          );
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
    print("read");
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
