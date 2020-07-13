import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_html/flutter_html.dart';

class HorrorScreen extends StatefulWidget {
  @override
  _HorrorScreenState createState() => _HorrorScreenState();
}

class _HorrorScreenState extends State<HorrorScreen> {

  DocumentSnapshot _currentDocument;
  final databaseReference = Firestore.instance;

  _updateLikes(String doc,int likes) async {
    await databaseReference
        .collection('horror')
        .document(doc)
        .updateData({'likes': likes+1});
  }

  _updateRead(String doc,int reads, DocumentSnapshot index) async {
    await databaseReference
        .collection('horror')
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
        stream: Firestore.instance.collection('horror').snapshots(),
        builder: (BuildContext content, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData) return new CircularProgressIndicator();
          return new ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context ,index){
              DocumentSnapshot ds = snapshot.data.documents[index];
              return Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.album),
                          title: new Text(ds['title']),
                            subtitle: Column(
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text("Author: "+ds['author'], textAlign: TextAlign.center),
                                    ),
                                    Expanded(
                                      child: Text("Likes: "+ds['likes'].toString(), textAlign: TextAlign.center),
                                    ),
                                    Expanded(
                                      child: Text("Shares: "+ds['share'].toString(), textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    FlatButton(child: Text('Read'), onPressed: () {_updateRead(ds.documentID,ds['reads'],ds);}),
                                    FlatButton(child: Text('Like'), onPressed: () {_updateLikes(ds.documentID, ds['likes']);}),
                                    FlatButton(child: Text('Share'), onPressed: () {}),
                                  ],
                                )
                              ],
                            )
                        ),
                      ],
                    ),
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
      body: SingleChildScrollView(child: Html(data: story['story'],))
    );
  }
}

