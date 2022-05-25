import 'package:cids_cgi/src/module/settings/controller/firebase_controller.dart';
import 'package:cids_cgi/src/core/page/widget/redes_sociais_widget.dart';
import 'package:local_auth/local_auth.dart';
import '../../../module/settings/page/politica_privacidade_page.dart';
import 'package:cids_cgi/src/di/di.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SettingsPage extends StatefulWidget {
  final Color appBarTextColor;
  final Color appBarColor;
  final bool motorista;
  final bool filled;
  final bool placa;
  final bool cpf;
  final Function? validaLogin;
  

  SettingsPage(
      {this.appBarColor = Colors.transparent,
      this.appBarTextColor = Colors.white,
      this.motorista = false,
      this.filled = false,
      this.placa = false,
      this.cpf = false,
      this.validaLogin});
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  FirebaseController? controller;
  bool canUseBiometrics = false;
  final localAuth = LocalAuthentication();
  
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero)
        .then((_) async {
          this.controller!.initState(this);
          this.canUseBiometrics = await localAuth.isDeviceSupported();
        });
  }

  @override
  Widget build(BuildContext context) {
    if (this.controller == null) {
      this.controller = firebaseController(context, widget.validaLogin);
    }
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: !controller!.isLoading,
          backgroundColor: widget.appBarColor,
          title: Text(
            "Configurações",
            style: TextStyle(color: widget.appBarTextColor),
          ),
          iconTheme: IconThemeData(color: widget.appBarTextColor),
          actions: <Widget>[
            !controller!.isLoading
                ? IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () async {
                      controller!.login();
                    })
                : Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Center(
                        child: SizedBox(
                            height: 25.0,
                            width: 25.0,
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.blue),
                              backgroundColor: Colors.white,
                            )))),
          ],
        ),
        body: Container(
            padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 20),
            child: Form(
              key: controller!.formKey,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 100,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Informe o código de acesso';
                                      }
                                      return null;
                                    },
                                    controller: controller!.edtCodigoText,
                                    enabled:
                                        controller!.loginBool ? true : false,
                                    decoration: InputDecoration(
                                        labelText: "Código de Acesso",
                                        filled: this.widget.filled),
                                    keyboardType: TextInputType.text)),
                            this.widget.motorista
                                ? Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: TextFormField(
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return 'Informe o código do motorista';
                                          }
                                          return null;
                                        },
                                        controller:
                                            controller!.edtMotoristaText,
                                        decoration: InputDecoration(
                                            labelText: "Código do Motorista",
                                            filled: this.widget.filled),
                                        keyboardType: TextInputType.number))
                                : Container(),
                            this.controller!.loginBool
                                ? Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: TextFormField(
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return controller!.useCnpj
                                              ? " Informe o CNPJ"
                                              : "Informe o CPF";
                                        }

                                        return null;
                                      },
                                      controller: controller!.edtUsuarioText,
                                      decoration: InputDecoration(
                                          labelText: controller!.useCnpj
                                              ? "CNPJ"
                                              : "CPF",
                                          filled: this.widget.filled),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        controller!.maskFormatter
                                      ],
                                    ))
                                : Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: TextFormField(
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return 'Informe o usuário';
                                          }
                                          return null;
                                        },
                                        controller: controller!.edtUsuarioText,
                                        decoration: InputDecoration(
                                            labelText: "Usuário",
                                            filled: this.widget.filled),
                                        keyboardType: TextInputType.text)),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Informe a senha';
                                      }
                                      return null;
                                    },
                                    controller: controller!.edtSenhaText,
                                    decoration: InputDecoration(
                                        labelText: "Senha",
                                        filled: this.widget.filled),
                                    keyboardType: TextInputType.text,
                                    obscureText: true)),
                            this.widget.placa
                                ? Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: TextFormField(
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return 'Informe a placa do veiculo';
                                          }
                                          return null;
                                        },
                                        controller: controller!.edtPlacaText,
                                        decoration: InputDecoration(
                                            labelText: "Placa do veículo",
                                            filled: this.widget.filled),
                                        keyboardType: TextInputType.text))
                                : Container(),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                    enabled: false,
                                    controller: controller!.edtServicoText,
                                    decoration: InputDecoration(
                                        labelText: "Serviço",
                                        filled: this.widget.filled),
                                    keyboardType: TextInputType.url)),
                            Container(
                                padding: EdgeInsets.only(top: 10),
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    controller!.version != null
                                        ? Text(
                                            "Versão atual do aplicativo: ${controller!.version?['v']}")
                                        : Container(),
                                    controller!.version != null
                                        ? Text(
                                            "Versão atual do build: ${controller!.version?['b']}")
                                        : Container(),
                                  ],
                                )),
                            canUseBiometrics ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Habilitar autenticação por biometria"),
                                Switch(
                                  activeColor: Colors.blue,
                                  value: controller!.biometria,
                                  onChanged: (val) {
                                    controller!.biometria = val;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ) : Container(),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.orange),
                                  child: Text(
                                    "Política de Privacidade",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PoliticaPage()));
                                  }),
                            ),
                            GestureDetector(
                                onTap: () {
                                  // handler.logout();
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/index',
                                      (Route<dynamic> route) => false);
                                },
                                child: Text("Sair")),
                          ],
                        ),
                      )),
                  Positioned(
                      bottom: 0, left: 0, right: 0, child: RedesSociaisWidget())
                ],
              ),
            )));
  }

  // _gravaLoginCnpjLigado() async {
  //   this._isLoading = true;
  //   setState(() {});
  //   await _handler.set("biometria", _biometria.toString());

  //   final snackBar = SnackBar(
  //         content: Text('Configurações salvas com sucesso!'),
  //       );

  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //       await Future.delayed(new Duration(milliseconds: 1000));
  //       Navigator.pop(context);

  //   this._edtServicoText.text = (await (_handler.getURL()))!;

  //   this._isLoading = false;
  //   setState(() {});
  // }

  // void _grava() async {
  //   if (_formKey.currentState!.validate()) {
  //     this._isLoading = true;
  //     setState(() {});

  //     String? senha = await _handler.getPasswordFirebase();
  //     String? aplicativo = await _handler.getNomeAplicativo();
  //     bool gateway = await _handler.getGateway();
  //     final bool response = await firebaseUseCase(
  //         senha!,
  //         context,
  //         this._edtCodigoText.text,
  //         this._edtUsuarioText.text,
  //         this._edtSenhaText.text,
  //         this._edtServicoText.text,
  //         this._edtMotoristaText.text,
  //         this._edtPlacaText.text,
  //         aplicativo!,
  //         gateway,
  //         this._biometria);

  //     if (response) {
  //       final snackBar = SnackBar(
  //         content: Text('Configurações salvas com sucesso!'),
  //       );

  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //       await Future.delayed(new Duration(milliseconds: 2000));
  //       Navigator.pop(context);

  //       this._edtServicoText.text = (await (_handler.getURL()))!;
  //     }

  //     this._isLoading = false;
  //     setState(() {});
  //   }
  // }
}
