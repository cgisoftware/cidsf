import 'package:cids_cgi/src/core/domain/device/handler/shared_preferences_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseHandler {
  final _handler = SharedPreferencesHandler();
  Future initialize(
      {@required String senha,
      @required String aplicativo,
      bool gateway = false}) async {
    await _handler.setPasswordFirebase(senha);
    await _handler.setNomeAplicativo(aplicativo);
    await _handler.setGateway(gateway);
    await Firebase.initializeApp();
  }
}
