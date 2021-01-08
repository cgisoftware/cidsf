import 'package:flutter/material.dart';

class DialogHandler {
  bool _isDialogShowing = false;

  void show(message, BuildContext context) {
    if (!this._isDialogShowing) {
      this._isDialogShowing = true;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(
              "Aviso!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: new Text(message),
            actions: <Widget>[
              new FlatButton(
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
}
