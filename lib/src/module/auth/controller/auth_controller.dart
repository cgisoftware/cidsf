import 'package:cids_cgi/src/module/settings/domain/usecase/login_pacific_usecase.dart';
import 'package:cids_cgi/src/module/settings/controller/firebase_controller.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:cids_cgi/cids_cgi.dart';
import 'package:flutter/widgets.dart';

class AuthController {
  final BuildContext? context;
  final LoginPacificUseCase? loginPacificUseCase;
  final Function? validaLogin;

  AuthController({this.context, this.loginPacificUseCase, this.validaLogin});

  final codigo = TextEditingController();
  final usuario = TextEditingController();
  final senha = TextEditingController();
  final motorista = TextEditingController();
  final handlerDialog = DialogHandler();
  var maskFormatter = new MaskTextInputFormatter(mask: CPF);

  late bool loginBool = false;
  late bool useCnpj = false;
  late bool campoMotorista = false;
  bool biometria = false;
  bool _loading = false;
  bool get loading => this._loading;

  final formKey = GlobalKey<FormState>();

  late var state;

  initState(state) async {
    this.state = state;

    this.loginBool = await SharedPreferencesHandler().getLogin();
    this.useCnpj = await SharedPreferencesHandler().useCnpj();
    this.campoMotorista = await SharedPreferencesHandler().getCampoMotorista();

    if (useCnpj) {
      maskFormatter = new MaskTextInputFormatter(mask: CNPJ);
    }
    this.state.setState(() {});
  }

  login() async {
    if (formKey.currentState!.validate()) {
      this._loading = true;
      this.state.setState(() {});
      try {
        await this.loginPacificUseCase!(this.usuario.text, this.senha.text,
            this.codigo.text, this.biometria, this.motorista.text);

        if (this.loginBool && this.validaLogin != null) {
          await this.validaLogin!();
        }

        Navigator.of(this.state.context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);

        this.state.setState(() {});
      } catch (e) {
        handlerDialog.show(message: e.toString(), context: context!);
      } finally {
        this._loading = false;
        this.state.setState(() {});
      }
    }
  }

  changeBiometria(bool biometria) {
    this.biometria = biometria;
    this.state.setState(() {});
  }
}
