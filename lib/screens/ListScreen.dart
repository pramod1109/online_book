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
                padding: const EdgeInsets.all(15.0),
                child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(top:10.0),
                      width: 375.0,
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
                  Positioned(
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
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 7.5,
                    child: RaisedButton(
                      padding: EdgeInsets.only(top: 7.5,right: 7.5),
                      elevation: 5.0,
                      onPressed: ()  async {
                        await Firestore.instance
                            .collection('categories')
                            .document(widget.cat)
                            .collection('books')
                            .document(ds.documentID)
                            .updateData({
                          'reads': ds['reads']+1
                        });
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
                      child: Align(
                        alignment: Alignment.topRight,
                        child:Text(
                          'చదవండి',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.0,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      )
                    ),
                  ),
                  Positioned(
                    left: 80.0,
                     child: Container(
                       padding: EdgeInsets.only(top: 5.0),
                       width: 150.0,
                         height: 60.0 ,
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
                            //"efiwbfiwbfiwebfeib",
                            style: TextStyle(
                            fontFamily: 'Book Antiqua',
                            fontSize: 24,
                            color: const Color(0xff707070),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ))
                  ),
                  Positioned(
                    left: 100.0,
                    top: 62.0,
                    //offset: Offset(124.0, 76.0),
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
                  Positioned(
                    top: 90.0,
                    left: 100.0,
                    //offset: Offset(124.0, 109.0),
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
                  Positioned(
                    top: 90.0,
                    left: 150.0,
                    //offset: Offset(177.0, 109.0),
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
                  Positioned(
                    bottom: 30.0,
                    right: 55.0,
                    //offset: Offset(269.0, 94.0),
                    child: Container(
                      width: 29.0,
                      height: 20.0,
                      child: InkWell(
                        onTap: () async {
                          if (!ds['likes'].contains(uid)) {
                            await Firestore.instance
                                .collection('categories')
                                .document(widget.cat)
                                .collection('books')
                                .document(ds.documentID)
                                .updateData({
                              'likes':
                              FieldValue.arrayUnion(
                                  [uid])
                            });
                          } else {
                            await Firestore.instance
                                .collection('categories')
                                .document(widget.cat)
                                .collection('books')
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
                  Positioned(
                    bottom:30.0,
                     right: 10.0,
                    //offset: Offset(314.0, 94.0),
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
                                    .collection('categories')
                                    .document(widget.cat)
                                    .collection('books')
                                    .document(ds.documentID));
                                await transaction.update(
                                    Firestore.instance
                                        .collection('categories')
                                        .document(widget.cat)
                                        .collection('books')
                                        .document(ds.documentID),
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
                  Positioned(
                    bottom:10.0,
                    right: 65.0,
                    //offset: Offset(276.0, 117.0),
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
                  Positioned(
                    bottom:10,
                    right: 20,
                    //offset: Offset(325.0, 117.0),
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
          return Center(child: Text("no "+widget.cat));
        },
      ),
    );
  }
}

class Story extends StatefulWidget {
  var story;
  String cat,book_id;
  Story({this.story,this.cat,this.book_id});
  @override
  createState() => new StoryState();
}

class StoryState extends State<Story> {
  var font = 34.0;
  var book = null;

  @override
  void initState() {
    super.initState();
    if(widget.cat!=null){
      getBook();
    }
  }

  getBook()async{
    await Firestore.instance.collection('categories').document(widget.cat).collection('books').document(widget.book_id).get().then((value) {
      setState(() {
        book = value.data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
//    //print("read");
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.cat!=null?book!=null?book['title']:'':widget.story['title']),
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
            child: widget.cat!=null?book!=null?Html(
              data: book['story'],
              style: {
                "body": Style(
                  fontSize: FontSize(font),
                ),
              },
            ):LinearProgressIndicator():Html(
          data: widget.story['story'],
          style: {
            "body": Style(
              fontSize: FontSize(font),
            ),
          },
        )));
  }
}
