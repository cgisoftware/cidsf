import 'package:cids_cgi/src/module/settings/domain/usecase/firebase_usecase.dart';
import 'package:flutter/widgets.dart';

class AuthController {
  final firebaseUseCase = FirebaseUseCase();

  final codigo = TextEditingController();
  final usuario = TextEditingController();
  final senha = TextEditingController();
  bool biometria = false;

  bool _loading = false;
  bool get loading => this._loading;

  var state;

  initState(state) {
    this.state = state;
  }

  login(String aplicativo, bool gateway, String password) async {
    this._loading = true;
    this.state.setState(() {});

    final bool response = await firebaseUseCase(
        password,
        this.state.context,
        this.codigo.text,
        this.usuario.text,
        this.senha.text,
        "",
        "",
        "",
        aplicativo,
        gateway,
        this.biometria);

    if (response) {
      Navigator.pop(this.state.context);
      Navigator.pop(this.state.context);
    }
  }

  changeBiometria(bool biometria) {
    this.biometria = biometria;
    this.state.setState(() {});
  }
}
