import 'package:cids_cgi/src/core/page/widget/rounded_password_field.dart';
import 'package:cids_cgi/src/core/page/widget/redes_sociais_widget.dart';
import 'package:cids_cgi/src/core/page/widget/rounded_input_field.dart';
import 'package:cids_cgi/src/core/page/widget/rounded_button.dart';
import 'package:cids_cgi/src/di/di.dart';
import 'package:cids_cgi/src/module/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function? validaLogin;

  LoginPage({this.validaLogin});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthController? controller;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero)
        .then((_) => {this.controller!.initState(this)});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
  
    if (this.controller == null) {
      this.controller = authController(context, widget.validaLogin);
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 70,
                  child: Theme.of(context).brightness == Brightness.light
                      ? Image.asset("images/consultors.png")
                      : Image.asset("images/consultors_dark.png")),
              SizedBox(height: size.height * 0.09),
              Form(
                key: controller!.formKey,
                child: Column(
                  children: [
                    FocusScope(
                        child: Focus(
                      // onFocusChange: (focus) {
                      //   if (!focus) {
                      //     controller!.login();
                      //   }
                      // },
                      child: RoundedInputField(
                        controller: controller!.codigo,
                        icon: Icons.lock_open,
                        validatorText: "Preencha o código de acesso",
                        hintText: "Código de acesso",
                        readOnly: false,
                      ),
                    )),
                    !controller!.loginBool
                        ? RoundedInputField(
                            controller: controller!.usuario,
                            hintText: "Usuário",
                            readOnly: false,
                            validatorText: "Preencha o usuário"
                          )
                        : RoundedInputField(
                            controller: controller!.usuario,
                            hintText: controller!.useCnpj ? "CNPJ" : "CPF",
                            validatorText: controller!.useCnpj ? "Preencha o CNPJ" :  "Preencha o CPF",
                            readOnly: false,
                            keyboardType: TextInputType.number,
                            inputFormatters: [controller!.maskFormatter],
                          ),
                    RoundedPasswordField(
                      controller: controller!.senha,
                      validatorText: "Preencha o usuário",
                      readOnly: false,
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.08),
              RoundedButton(
                loading: controller!.loading,
                text: "ENTRAR",
                press: () async {
                  controller!.login();
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Habilitar autenticação por biometria"),
                  Switch(
                    activeColor: Colors.blue,
                    value: controller!.biometria,
                    onChanged: (val) {
                      controller!.changeBiometria(val);
                    },
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.07),
              RedesSociaisWidget()
            ],
          ),
        )),
      ),
    );
  }
}
