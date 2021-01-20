import 'package:flutter/material.dart';
import 'package:cids_cgi/cids_cgi.dart';
import './router.dart' as r;

final biometricsHandler = BiometricsHandler();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final temaClaro = ThemeData(
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

  final temaEscuro = ThemeData(
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: temaClaro,
        darkTheme: temaEscuro,
        themeMode: ThemeMode.system,
        home: MyHome(),
        onGenerateRoute: r.Router.generateRoute);
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  void initState() {
    super.initState();

    biometricsHandler(context);
    biometricsHandler.listen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(icon: Icon(Icons.settings), onPressed: () {})],
        title: const Text('CIDS for dev'),
      ),
    );
  }
}
