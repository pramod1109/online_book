import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class ListScreen extends StatefulWidget {
  final cat;

  ListScreen({@required this.cat});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  final databaseReference = Firestore.instance;

  _updateLikes(String doc,int likes) async {
    await databaseReference
        .collection(widget.cat)
        .document(doc)
        .updateData({'likes': likes+1});
  }

  _updateRead(String doc,int reads, DocumentSnapshot index) async {
    await databaseReference
        .collection(widget.cat)
        .document(doc)
        .updateData({'reads': reads+1});
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Story(story: index)));
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('E-book'),
        backgroundColor: Colors.redAccent,
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection(widget.cat).snapshots(),
        builder: (BuildContext content, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
          return new ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context ,index){
              DocumentSnapshot ds = snapshot.data.documents[index];
              return Card(
                      child: Row(
                            children: <Widget>[
                             Container(
                               height: 100.0,
                               width: 80.0,
                                   padding: EdgeInsets.all(17.0),
                                   decoration: new BoxDecoration(
                                     borderRadius: new BorderRadius.all(const  Radius.circular(3.0)),
                                     image: new DecorationImage(
                                       image: new ExactAssetImage('assets/images/1.jpeg'),
                                       fit: BoxFit.cover,
                                     ),
                                   )
                             ),
                              SizedBox(width: 5.0,),
                              Container(
                                width: 180.0,
                                  child:Column(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(ds['title'],style: TextStyle(fontSize: 28.0),textAlign: TextAlign.left,),
                                      ),
                                      SizedBox(height: 5.0,),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("రచయిత: "+ds['author'],style: TextStyle(fontSize: 18.0),textAlign: TextAlign.left,),
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Text(ds['reads'].toString() +" views"),
                                            SizedBox(width: 5.0,),
                                            FlatButton.icon(onPressed: null, icon: Icon(Icons.file_download,color: Colors.redAccent,), label: Text("గ్రంధాలయం",style: TextStyle(color: Colors.black),))
                                          ],
                                        ),
                                      ),
                                    ],
                                )
                              ),
                              Container(
                                width: 80.0,
                                child: Column(
                                  children: <Widget>[
                                    RaisedButton(
                                      elevation: 1.0,
                                      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Story(story: ds,)),);},
                                      padding: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      color: Colors.redAccent,
                                      child: Text(
                                        'చదవండి',
                                        style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 1.5,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'OpenSans',
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 62.0,
                                          width: 30.0,
                                          child: Column(
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.thumb_up),
                                              ),
                                              Text(ds['likes'].toString(),style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w100, fontFamily: 'OpenSans',),)
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Container(
                                          height: 62.0,
                                          width: 30.0,
                                          child: Column(
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.share),
                                              ),
                                              Text(ds['share'].toString(),style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w100, fontFamily: 'OpenSans',),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                      )
              );
            },
          );
        },
      ),
    );
  }



}

class Story extends StatelessWidget {

  final story;

  Story({@required this.story});

  @override
  Widget build(BuildContext context) {
    print("read");
    return Scaffold(
      appBar: AppBar(
        title: Text("Story"),
        backgroundColor: Colors.redAccent,

      ),
      body: SingleChildScrollView(child: Html(
        data: story['story'],
        style: {
          "body": Style(
            backgroundColor: Colors.black12,
            fontSize: FontSize(18.0),
//              color: Colors.white,
          ),
//            "h1": Style(
//              textAlign: TextAlign.center,
//            ),
        },
      )
      )
    );
  }
}

