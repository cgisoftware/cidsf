import 'package:flutter/material.dart';

class DialogHandler {
  bool _isDialogShowing = false;

  void show(
      {title = "Aviso!",
      required String message,
      required BuildContext context}) {
    if (!this._isDialogShowing) {
      this._isDialogShowing = true;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: new Text(message),
            actions: <Widget>[
              new TextButton(
                child: new Text(
                  "OK",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  this._isDialogShowing = false;
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<int> confirm({
    String title = "Confirme!",
    required String message,
    required String textBtn1,
    required String textBtn2,
    required BuildContext context,
  }) async {
    int iRetorno = -1;
    AlertDialog dlgConfirmar = AlertDialog(
      title: Text(title),
      content: Container(child: Text(message)),
      actions: <Widget>[
        TextButton(
          child: Text(textBtn1),
          onPressed: () {
            iRetorno = 1;
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(textBtn2),
          onPressed: () {
            iRetorno = 2;
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => dlgConfirmar);
    return iRetorno;
  }
}
