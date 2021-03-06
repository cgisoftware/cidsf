import 'package:cids_cgi/src/module/settings/domain/usecase/firebase_usecase.dart';
import 'package:cids_cgi/cids_cgi.dart';
import 'package:flutter/widgets.dart';

class AuthController {
  final firebaseUseCase = FirebaseUseCase();
  final _handler = SharedPreferencesHandler();

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

  login() async {
    this._loading = true;
    this.state.setState(() {});

    String senha = await _handler.getPasswordFirebase();
    String aplicativo = await _handler.getNomeAplicativo();
    bool gateway = await _handler.getGateway();

    final bool response = await firebaseUseCase(
        senha,
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
      Navigator.of(this.state.context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    }

    this._loading = false;
    this.state.setState(() {});
  }

  changeBiometria(bool biometria) {
    this.biometria = biometria;
    this.state.setState(() {});
  }
}
