import 'package:flutter/material.dart';
import 'package:online_book/screens/ListScreen.dart';
import 'package:online_book/services/storage.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          Storage.user['saved'].length,
          (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(Storage.user['saved'][index]['book_name']),
                  subtitle:
                      Text('by ${Storage.user['saved'][index]['book_name']}'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Story(
                            book_id: Storage.user['saved'][index]['book_id'],
                            cat: Storage.user['saved'][index]['category'],
                          ),
                        ));
                  },
                ),
              )),
    );
  }
}
