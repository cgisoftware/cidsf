import 'package:cids_cgi/cids_cgi.dart';
import 'package:cids_cgi/src/core/page/widget/redes_sociais_widget.dart';
import 'package:cids_cgi/src/module/settings/domain/usecase/firebase_usecase.dart';
import '../../../module/settings/page/politica_privacidade_page.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const CPF = '###.###.###-##';
const CNPJ = '###.###.###/####-##';

class SettingsPage extends StatefulWidget {
  final Color appBarTextColor;
  final Color appBarColor;
  final bool motorista;
  final bool filled;
  final bool placa;
  final bool cpf;

  SettingsPage({
    this.appBarColor = Colors.transparent,
    this.appBarTextColor = Colors.white,
    this.motorista = false,
    this.filled = false,
    this.placa = false,
    this.cpf = false,
  });
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _handler = SharedPreferencesHandler();

  final _edtCodigoText = TextEditingController();
  final _edtUsuarioText = TextEditingController();
  final _edtSenhaText = TextEditingController();
  final _edtServicoText = TextEditingController();
  final _edtMotoristaText = TextEditingController();
  final _edtPlacaText = TextEditingController();
  bool loginBool = true;
  bool _biometria = false;
  bool _isLoading = false;
  Map<String, dynamic>? _version = {};

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final maskFormatter = new MaskTextInputFormatter(mask: CPF);

  final _formKey = GlobalKey<FormState>();

  final firebaseUseCase = FirebaseUseCase();
  @override
  void initState() {
    super.initState();

    setValues();
  }

  setValues() async {
    var login = await _handler.getLogin();

    if (login == null) {
      loginBool = false;
    } else {
      loginBool = login == 'true';
    }
    if (!loginBool) {
      this._edtUsuarioText.text = await (_handler.get("edtUsuario"));
      this._edtCodigoText.text = await (_handler.get("edtCodigo"));
      this._edtSenhaText.text = await (_handler.get("edtSenha"));
      this._edtServicoText.text = await (_handler.get("edtServico"));
      if (this.widget.motorista) {
        this._edtMotoristaText.text = await (_handler.get("edtMotorista"));
      }
      if (this.widget.placa) {
        this._edtPlacaText.text = await (_handler.get("edtPlaca"));
      }
    } else {
       this._edtCodigoText.text = await (_handler.get("edtCodigo"));
       this._edtServicoText.text = await (_handler.get("edtServico"));
    }
    this._biometria = (await _handler.get("biometria")) == "true";

    _version = await _handler.getBuildVersion();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: !_isLoading,
          backgroundColor: widget.appBarColor,
          title: Text(
            "Configurações",
            style: TextStyle(color: widget.appBarTextColor),
          ),
          iconTheme: IconThemeData(color: widget.appBarTextColor),
          actions: <Widget>[
            !_isLoading
                ? IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () {
                      _grava();
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
              key: _formKey,
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
                                    controller: _edtCodigoText,
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
                                        controller: _edtMotoristaText,
                                        decoration: InputDecoration(
                                            labelText: "Código do Motorista",
                                            filled: this.widget.filled),
                                        keyboardType: TextInputType.number))
                                : Container(),
                            this.widget.cpf
                                ? Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: TextFormField(
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return 'Informe o CPF';
                                        }

                                        return null;
                                      },
                                      controller: _edtUsuarioText,
                                      decoration: InputDecoration(
                                          labelText: "CPF",
                                          filled: this.widget.filled),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [maskFormatter],
                                    ))
                                : Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: !loginBool ? TextFormField(
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return 'Informe o usuário';
                                          }
                                          return null;
                                        },
                                        controller: _edtUsuarioText,
                                        decoration: InputDecoration(
                                            labelText: "Usuário",
                                            filled: this.widget.filled),
                                        keyboardType: TextInputType.text) : Container()),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: !loginBool ? TextFormField(
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Informe a senha';
                                      }
                                      return null;
                                    },
                                    controller: _edtSenhaText,
                                    decoration: InputDecoration(
                                        labelText: "Senha",
                                        filled: this.widget.filled),
                                    keyboardType: TextInputType.text,
                                    obscureText: true) : Container()),
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
                                        controller: _edtPlacaText,
                                        decoration: InputDecoration(
                                            labelText: "Placa do veículo",
                                            filled: this.widget.filled),
                                        keyboardType: TextInputType.text))
                                : Container(),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                    enabled: false,
                                    controller: _edtServicoText,
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
                                    _version != null
                                        ? Text(
                                            "Versão atual do aplicativo: ${_version?['v']}")
                                        : Container(),
                                    _version != null
                                        ? Text(
                                            "Versão atual do build: ${_version?['b']}")
                                        : Container(),
                                  ],
                                )),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Habilitar autenticação por biometria"),
                                Switch(
                                  activeColor: Colors.blue,
                                  value: _biometria,
                                  onChanged: (val) {
                                    _biometria = val;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
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
                                  _handler.logout();
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

  void _grava() async {
    if (_formKey.currentState!.validate()) {
      this._isLoading = true;
      setState(() {});

      String? senha = await _handler.getPasswordFirebase();
      String? aplicativo = await _handler.getNomeAplicativo();
      bool gateway = await _handler.getGateway();
      final bool response = await firebaseUseCase(
          senha!,
          context,
          this._edtCodigoText.text,
          this._edtUsuarioText.text,
          this._edtSenhaText.text,
          this._edtServicoText.text,
          this._edtMotoristaText.text,
          this._edtPlacaText.text,
          aplicativo!,
          gateway,
          this._biometria);

      if (response) {
        final snackBar = SnackBar(
          content: Text('Configurações salvas com sucesso!'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        await Future.delayed(new Duration(milliseconds: 2000));
        Navigator.pop(context);

        this._edtServicoText.text = await (_handler.getURL());
      }

      this._isLoading = false;
      setState(() {});
    }
  }
}
