import 'package:flutter/material.dart';
import 'package:cids_cgi/cids_cgi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FirebaseHandler().initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var temaClaro = ThemeData(
      appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          color: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          textTheme: TextTheme(
              headline6: TextStyle(color: Colors.black, fontSize: 18))),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Color(0xff1D2745),
        ),
        headline1: TextStyle(
          color: Color(0xff1D2745),
        ),
      ),
      primaryColor: Color(0xff1D2745),
      backgroundColor: Color(0xff1D2745),
      fontFamily: 'PT_Sans-Narrow-Web',
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      buttonTheme: ButtonThemeData(
          buttonColor: Color(0xffff6600), textTheme: ButtonTextTheme.primary));

  var temaEscuro = ThemeData(
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          color: Colors.transparent,
          textTheme: TextTheme(
              headline6: TextStyle(color: Colors.white, fontSize: 18))),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
        ),
        headline1: TextStyle(
          color: Color(0xff1D2745),
        ),
      ),
      backgroundColor: Colors.white,
      brightness: Brightness.dark,
      fontFamily: 'PT_Sans-Narrow-Web',
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      buttonTheme: ButtonThemeData(
          buttonColor: Color(0xffff6600), textTheme: ButtonTextTheme.primary));


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: temaClaro,
      darkTheme: temaEscuro,
      themeMode: ThemeMode.system,
        home: AuthPage(
      aplicativo: "Teste",
      gateway: true,
      password: "Mariana23",
      frase: "Frase aqui",
      imagePath: "images/index.jpg",
    ));
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
