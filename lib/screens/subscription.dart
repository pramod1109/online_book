import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Subscription extends StatefulWidget {
  String uid;

  Subscription(this.uid);

  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  List<String> categories = [
    'కథలు',
    'కవితలు',
    'సంపాదకీయం',
    'భావ స్పందన',
    'గ్రంథ సమీక్ష',
    'బాలతరంగిణి',
    'హాస్యం',
    'నవలలు',
    'బాల సాహిత్యం',
    'బాల వ్యాఖ్య',
    'నానీలు',
    'చిత్ర వ్యాఖ్య',
    'చిత్ర కథ',
    'భావగీతం',
    'చిత్ర కవిత',
    'కార్టూన్  వ్యాఖ్య'
  ];

  List<dynamic> filterCats;

  @override
  void initState() {
    filterCats = [];
    super.initState();
    Firestore.instance.collection('user').document(widget.uid).get().then((v) {
      print(v['subscription']);
      if(v['subscription']!=null)
      filterCats=v['subscription'];
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ఇష్టాలు'),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              await Firestore.instance.collection('user').document(widget.uid).updateData({
                'subscription':filterCats
              });
              for(int i=0;i<categories.length;i++){
                if(filterCats.contains(categories[i]))
                await Firestore.instance.collection('categories').document(categories[i]).updateData({
                  'subscription':FieldValue.arrayUnion([widget.uid])
                });
                else
                await Firestore.instance.collection('categories').document(categories[i]).updateData({
                  'subscription':FieldValue.arrayRemove([widget.uid])
                });
              }
              Navigator.pop(context);
            },
            child: Text(
              'అయిపోయింది',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
                categories.length,
                (index) {return InkWell(
                      onTap: () {
                        if (!filterCats.contains(categories[index]))
                          filterCats.add(categories[index]);
                        else
                          filterCats.remove(categories[index]);
                        setState(() {});
                      },
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                                value: filterCats.contains(categories[index]),
                                onChanged: (v) {
                                  if (v)
                                    filterCats.add(categories[index]);
                                  else
                                    filterCats.remove(categories[index]);
                                  setState(() {});
                                }),
                            Text(
                              categories[index],
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    );}),
          ),
        ),
      ),
    );
  }
}
