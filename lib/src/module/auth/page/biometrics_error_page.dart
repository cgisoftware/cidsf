import 'package:cids_cgi/cids_cgi.dart';
import 'package:flutter/material.dart';

class BiometricsErrorPage extends StatefulWidget {
  @override
  _BiometricsErrorPageState createState() => _BiometricsErrorPageState();
}

class _BiometricsErrorPageState extends State<BiometricsErrorPage> {
  final biometricsHandler = BiometricsHandler();
  final _handler = SharedPreferencesHandler();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // biometricsHandler(context);
    biometricsHandler.listen(context);
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
                      ? Image.asset("images/consultors.png")
                      : Image.asset("images/consultors_dark.png"))),
          Positioned(
              left: 16,
              right: 16,
              bottom: 50,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * .4,
                      child: OutlineButton(
                        onPressed: () {
                           _handler.logout();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/', (Route<dynamic> route) => false);
                        },
                        child: Text("Sair do app"),
                      ),
                    ),
                    SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .4,
                        child: RaisedButton(
                          onPressed: () async {
                            biometricsHandler(context);
                          },
                          child: Text("Autenticar"),
                        ))
                  ]))
        ],
      ),
    );
  }
}
