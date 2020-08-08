import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_book/screens/ListScreen.dart';

class Notifications extends StatefulWidget {
  final uid;

  const Notifications({Key key, this.uid}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('user')
          .document(widget.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator();
        } else {
          var snap = snapshot.data.data;
          if (snap['notifications'] == null)
            return Center(child: Text('No Notifications'));
          else {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Notifications',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ] +
                    List<Widget>.generate(
                        snap['notifications'].length,
                        (index) => Container(
                              decoration: BoxDecoration(
                                  border: index ==
                                          snap['notifications'].length - 1
                                      ? Border(
                                          top: BorderSide(color: Colors.black),
                                          bottom:
                                              BorderSide(color: Colors.black))
                                      : Border(
                                          top:
                                              BorderSide(color: Colors.black))),
                              child: ListTile(
                                onTap: () {
                                  if (snap['notifications'][index]['type'] ==
                                      'New Book') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Story(
                                            book_id: snap['notifications']
                                                [index]['book_id'],
                                            cat: snap['notifications'][index]
                                                ['category'],
                                          ),
                                        ));
                                  }
                                },
                                title: Text(
                                    '${snap['notifications'][index]['title']}'),
                                subtitle: Text(
                                    '${snap['notifications'][index]['body']}'),
                              ),
                            )),
              ),
            );
          }
        }
      },
    );
  }
}
