import 'package:cids_cgi/src/module/settings/domain/usecase/firebase_usecase.dart';
import 'package:cids_cgi/cids_cgi.dart';
import 'package:flutter/widgets.dart';

class AuthController {
  final firebaseUseCase = FirebaseUseCase();
  final _handler = SharedPreferencesHandler();
  final codigo = TextEditingController();
  final usuario = TextEditingController();
  final senha = TextEditingController();
  final handlerDialog = DialogHandler();
  bool loginBool = true;
  bool biometria = false;
  bool _loading = false;
  bool get loading => this._loading;
  bool tentouLogarFirebase = false;
  final formKey = GlobalKey<FormState>();

  var state;

  tryCode(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      this._loading = true;
      this.tentouLogarFirebase = false;
      final seguranca = new Seguranca(
          email: "@cgi.com.br", password: await _handler.getPasswordFirebase());
      await _handler.set("edtCodigo", codigo.text);
      var r = await seguranca.execute(context);

      var login = await _handler.get("login");

      this.state = state;

      if (login == null) {
        loginBool = true;
      } else {
        loginBool = login == 'true';
      }
      this._loading = false;

      if (r != "") {
      handlerDialog.show(message: r, context: context);
      return false;
      } else {
        this.tentouLogarFirebase = true;
      }

      this.state.setState(() {});
    }
  }

  initState(state) {
    this.state = state;
  }

  login() async {
    this._loading = true;
    this.state.setState(() {});

    String? senha = await _handler.getPasswordFirebase();
    String? aplicativo = await _handler.getNomeAplicativo();
    bool gateway = await _handler.getGateway();

    final bool response = await firebaseUseCase(
        senha!,
        this.state.context,
        this.codigo.text,
        this.usuario.text,
        this.senha.text,
        "",
        "",
        "",
        aplicativo!,
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
