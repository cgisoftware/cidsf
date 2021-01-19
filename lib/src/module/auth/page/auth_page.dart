import 'package:cids_cgi/src/module/auth/page/login_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  final String frase;
  final String imagePath;
  final String aplicativo;
  final bool gateway;
  final String password;

  const AuthPage(
      {Key key,
      this.frase,
      this.imagePath,
      this.gateway = false,
      this.aplicativo = "",
      @required this.password})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        new Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 0,
          child: Container(
              color: Color(0xff1D2745),
              height: MediaQuery.of(context).size.height,
              child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.fitHeight,
                  ))),
        ),
        new Positioned(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  frase,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0)),
                      child: Center(child: Text('Acessar')),
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginPage(
                                  gateway: gateway,
                                  password: password,
                                  aplicativo: aplicativo,
                                )));
                      },
                    ))
              ],
            ))
      ],
    ));
  }
}
