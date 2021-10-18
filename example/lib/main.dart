import 'package:cids_cgi_example/page.dart';
import 'package:flutter/material.dart';
import 'package:cids_cgi/cids_cgi.dart';
import './router.dart' as r;

var defaultPage;

BuildContext biometricsContext;
final cidsHandler = CidsHandler();

final biometricsHandler = BiometricsHandler(autenticacaoPage: () {
  Navigator.of(biometricsContext)
      .pushNamedAndRemoveUntil('/auth', (Route<dynamic> route) => false);
}, homePage: () {
  print(biometricsContext);
  Navigator.of(biometricsContext)
      .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  biometricsHandler.listen();
  biometricsHandler();

  await cidsHandler.initialize(
      gateway: false,
      aplicativo: "cidsf",
      senha: "Mariana23",
      versaoPacific: 1,
      campoMotorista: true,
      useCnpj: false);

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
        home: authPage,
        onGenerateRoute: r.Router.generateRoute);
  }
}

class MyHome extends StatefulWidget {
  final Function(BuildContext) context;

  const MyHome({Key key, @required this.context}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  void initState() {
    super.initState();

    widget.context(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.camera),
              onPressed: () async {
                String response =
                    await QRScan().startScan(context, QRScanType.bar);
                print(response);
              }),
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(biometricsContext).push(MaterialPageRoute(
                    builder: (context) => SettingsPage(
                          motorista: true,
                        )));
              })
        ],
        title: const Text('CIDS for dev'),
      ),
    );
  }
}
