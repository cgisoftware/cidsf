import 'package:cids_cgi/module/settings/page/firebase_validation_page.dart';
import 'package:flutter/material.dart';

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
                          password: "Mariana23",
                          appBarColor: Theme.of(context).primaryColor, 
                          filled: true,
                          versaoProgramaPacific: 1)),
                );
              })
        ],
        title: const Text('CIDS for dev'),
      ),
    );
  }
}
