import 'package:cids_cgi/src/core/page/widget/rounded_password_field.dart';
import 'package:cids_cgi/src/module/auth/controller/auth_controller.dart';
import 'package:cids_cgi/src/core/page/widget/redes_sociais_widget.dart';
import 'package:cids_cgi/src/core/page/widget/rounded_input_field.dart';
import 'package:cids_cgi/src/core/page/widget/rounded_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authController = AuthController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero)
        .then((value) => authController.initState(this));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              Column(
                children: [
                  RoundedInputField(
                    controller: authController.codigo,
                    icon: Icons.lock_open,
                    hintText: "Código de acesso",
                  ),
                  RoundedInputField(
                    controller: authController.usuario,
                    hintText: "Usuário",
                  ),
                  RoundedPasswordField(
                    controller: authController.senha,
                  )
                ],
              ),
              SizedBox(height: size.height * 0.08),
              RoundedButton(
                loading: authController.loading,
                text: "ENTRAR",
                press: () {
                  authController.login();
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Habilitar autenticação por biometria"),
                  Switch(
                    activeColor: Colors.blue,
                    value: authController.biometria,
                    onChanged: (val) {
                      authController.changeBiometria(val);
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
