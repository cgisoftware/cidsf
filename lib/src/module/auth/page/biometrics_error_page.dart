import 'package:cids_cgi/cids_cgi.dart';
import 'package:flutter/material.dart';

class BiometricsErrorPage extends StatefulWidget {
  final BiometricsHandler biometricsHandler;
  final Function(BuildContext) context;

  BiometricsErrorPage({Key? key, required this.biometricsHandler, required this.context}) : super(key: key);

  @override
  _BiometricsErrorPageState createState() => _BiometricsErrorPageState();
}

class _BiometricsErrorPageState extends State<BiometricsErrorPage> {
  final _handler = SharedPreferencesHandler();
  bool rh = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((_) async {
      this.rh = (await _handler.get('rh')) == 'true';
      setState(() {});
    });

    widget.context(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: 16,
              right: 16,
              top: 80,
              child: Container(
                  height: 70,
                  child: Theme.of(context).brightness == Brightness.light
                      ? Image.asset(rh ? "images/admrh.png" : "images/consultors.png")
                      : Image.asset(rh ? "images/admrh.png" : "images/consultors_dark.png"))),
          Positioned(
              left: 16,
              right: 16,
              bottom: 50,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * .4,
                  child: OutlinedButton(
                    onPressed: () {
                      _handler.logout();
                      Navigator.of(context).pushNamedAndRemoveUntil('/index', (Route<dynamic> route) => false);
                    },
                    child: Text(
                      "Sair do app",
                      style: TextStyle(color: rh ? Colors.orange : Colors.blue),
                    ),
                  ),
                ),
                SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * .4,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: rh ? Colors.orange : Colors.blue),
                      onPressed: () async {
                        widget.biometricsHandler();
                      },
                      child: Text("Autenticar"),
                    ))
              ]))
        ],
      ),
    );
  }
}
