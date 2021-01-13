import 'package:flutter/material.dart';
import 'package:cids_cgi/cids_cgi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHome());
  }
}

class MyHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => SettingsPage(
                          password: "",
                          appBarColor: Theme.of(context).primaryColor, 
                          filled: true)),
                );
              })
        ],
        title: const Text('CIDS for dev'),
      ),
    );
  }
}
