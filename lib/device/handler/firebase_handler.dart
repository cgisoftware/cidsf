import 'package:firebase_core/firebase_core.dart';

class FirebaseHandler {
  Future initialize() async {
    await Firebase.initializeApp();
  }
}