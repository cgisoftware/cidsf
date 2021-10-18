import 'package:cids_cgi/cids_cgi.dart';
import 'package:cids_cgi/src/module/settings/domain/usecase/login_pacific_usecase.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

const CPF = '###.###.###-##';
const CNPJ = '##.###.###/####-##';

class FirebaseController {
  final BuildContext? context;
  final LoginPacificUseCase? loginPacificUseCase;
  final Function? validaLogin;

  FirebaseController(
      {this.context, this.loginPacificUseCase, this.validaLogin});

  final edtCodigoText = TextEditingController();
  final edtUsuarioText = TextEditingController();
  final edtSenhaText = TextEditingController();
  final edtServicoText = TextEditingController();
  final edtMotoristaText = TextEditingController();
  final edtPlacaText = TextEditingController();
  final handlerDialog = DialogHandler();
  final _handler = SharedPreferencesHandler();

  var state;

  bool loginBool = true;
  bool useCnpj = false;
  bool biometria = false;
  bool isLoading = false;
  Map<String, dynamic>? version = {};

  var maskFormatter = new MaskTextInputFormatter(mask: CPF);

  final formKey = GlobalKey<FormState>();

  initState(state) async {
    this.state = state;
    this.loginBool = await _handler.getLogin();
    this.useCnpj = await _handler.useCnpj();

    if (useCnpj) {
      maskFormatter = new MaskTextInputFormatter(mask: CNPJ);
    }

    this.edtUsuarioText.text = (await (_handler.get("edtUsuario"))) ?? '';
    this.edtCodigoText.text = (await (_handler.get("edtCodigo"))) ?? '';
    this.edtSenhaText.text = (await (_handler.get("edtSenha"))) ?? '';
    this.edtServicoText.text = (await (_handler.get("edtServico"))) ?? '';
    this.edtMotoristaText.text = (await _handler.get("edtMotorista")) ?? '';
    this.edtPlacaText.text = (await (_handler.get("edtPlaca"))) ?? '';
    this.edtCodigoText.text = (await (_handler.get("edtCodigo"))) ?? '';
    this.edtServicoText.text = (await (_handler.get("edtServico"))) ?? '';

    this.biometria = (await _handler.get("biometria")) == "true";

    version = await _handler.getBuildVersion();
    this.state.setState(() {});
  }

  login() async {
    if (formKey.currentState!.validate()) {
      this.isLoading = true;
      this.state.setState(() {});
      try {
        await this.loginPacificUseCase!(
            this.edtUsuarioText.text,
            this.edtSenhaText.text,
            this.edtCodigoText.text,
            this.biometria,
            this.edtMotoristaText.text);

        if (edtMotoristaText.text.isNotEmpty) {
          await _handler.set("edtMotorista", edtMotoristaText.text);
        }

        if (this.loginBool && this.validaLogin != null) {
          await this.validaLogin!();
        }

        await Future.delayed(
          Duration(milliseconds: 1500),
        );
        Navigator.of(this.state.context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);

        // this.loginBool =
        //     await this.loginPersonalizadoUseCase!(this.codigo.text);
        this.state.setState(() {});
      } catch (e) {
        handlerDialog.show(message: e.toString(), context: context!);
      } finally {
        this.isLoading = false;
        this.state.setState(() {});
      }
    }
  }
}
