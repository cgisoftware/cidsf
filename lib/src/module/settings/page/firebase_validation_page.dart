
import '../../../device/handler/dialog_handler.dart';
import '../../../device/handler/shared_preferences_handler.dart';
import '../../../module/settings/domain/usecase/seguranca_usecase.dart';
import '../../../module/settings/page/politica_privacidade_page.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';

const CPF = '###.###.###-##';
const CNPJ = '###.###.###/####-##';


class SettingsPage extends StatefulWidget {
  final int versaoProgramaPacific;
  final Color appBarTextColor;
  final String aplicativo;
  final Color appBarColor;
  final bool motorista;
  final bool gateway;
  final bool filled;
  final bool placa;
  final bool cpf;
  final String password;

  SettingsPage(
      {this.motorista = false,
      this.placa = false,
      this.filled = false,
      this.cpf = false,
      this.appBarColor = Colors.transparent,
      this.appBarTextColor = Colors.white,
      this.gateway = false,
      this.aplicativo = "",
      @required this.password,
      @required this.versaoProgramaPacific});
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _handler = SharedPreferencesHandler();
  final _dialogMessage = DialogHandler();
  

  final _edtCodigoText = TextEditingController();
  final _edtUsuarioText = TextEditingController();
  final _edtSenhaText = TextEditingController();
  final _edtServicoText = TextEditingController();
  final _edtMotoristaText = TextEditingController();
  final _edtPlacaText = TextEditingController();

  bool _isLoading = false;
  Map<String, dynamic> _version = {};

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final maskFormatter = new MaskTextInputFormatter(mask: CPF);

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    setValues();
  }

  setValues() async {
    this._edtUsuarioText.text = await _handler.get("edtUsuario");
    this._edtCodigoText.text = await _handler.get("edtCodigo");
    this._edtSenhaText.text = await _handler.get("edtSenha");
    this._edtServicoText.text = await _handler.get("edtServico");
    if (this.widget.motorista) {
      this._edtMotoristaText.text = await _handler.get("edtMotorista");
    }
    if (this.widget.placa) {
      this._edtPlacaText.text = await _handler.get("edtPlaca");
    }

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
                                      if (val.isEmpty) {
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
                                          if (val.isEmpty) {
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
                                        if (val.isEmpty) {
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
                                    child: TextFormField(
                                        validator: (val) {
                                          if (val.isEmpty) {
                                            return 'Informe o usuário';
                                          }
                                          return null;
                                        },
                                        controller: _edtUsuarioText,
                                        decoration: InputDecoration(
                                            labelText: "Usuário",
                                            filled: this.widget.filled),
                                        keyboardType: TextInputType.text)),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'Informe a senha';
                                      }
                                      return null;
                                    },
                                    controller: _edtSenhaText,
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
                                          if (val.isEmpty) {
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
                                            "Versão atual do aplicativo: ${_version['v']}")
                                        : Container(),
                                    _version != null
                                        ? Text(
                                            "Versão atual do build: ${_version['b']}")
                                        : Container(),
                                  ],
                                )),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              height: 50,
                              width: double.infinity,
                              child: RaisedButton(
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
                          ],
                        ),
                      )),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            _launchSocial('fb://profile/338379049642068',
                                'https://www.facebook.com/CGISoftware');
                          },
                          child: Icon(
                            FontAwesomeIcons.facebook,
                            color: Color(0xff3A5997),
                            size: 40,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              _launchSocial(
                                  'https://www.instagram.com/cgisoftware/',
                                  'https://www.instagram.com/cgisoftware/');
                            },
                            child: Icon(
                              FontAwesomeIcons.instagram,
                              color: Color(0xff3E729A),
                              size: 40,
                            )),
                        InkWell(
                            onTap: () {
                              _launchSocial(
                                  'linkedin://company/cgisoftware/about/',
                                  'https://www.linkedin.com/company/cgisoftware/about/');
                            },
                            child: Icon(
                              FontAwesomeIcons.linkedin,
                              color: Color(0xff027BB6),
                              size: 40,
                            )),
                        InkWell(
                            onTap: () {
                              _launchSocial(
                                  'twitter://user?screen_name=CgiSoftware',
                                  'https://twitter.com/CgiSoftware');
                            },
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.twitter,
                                color: Color(0xff2995E8),
                                size: 40,
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  void _launchSocial(String url, String fallbackUrl) async {
    // Don't use canLaunch because of fbProtocolUrl (fb://)
    try {
      bool launched =
          await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      print(e);
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

  void _grava() async {
    if (_formKey.currentState.validate()) {
      final seguranca =
          new Seguranca(email: "@cgi.com.br", password: widget.password);
      this._isLoading = true;
      setState(() {});
      await _handler.set("edtCodigo", this._edtCodigoText.text);
      await _handler.set("edtUsuario", this._edtUsuarioText.text);
      await _handler.set("edtSenha", this._edtSenhaText.text);
      await _handler.set("edtServico", this._edtServicoText.text);
      await _handler.set("edtMotorista", this._edtMotoristaText.text);
      await _handler.set("edtPlaca", this._edtPlacaText.text);
      await _handler.set("versaoProgramaPacific", this.widget.versaoProgramaPacific.toString());
      var r = await seguranca.execute();
      if (r != "") {
        _dialogMessage.show(r, context);
        this._isLoading = false;
        setState(() {});
      } else {
        this._edtServicoText.text = await _handler.get("edtServico");
        if (widget.gateway) {
          try {
            Dio dio = new Dio();

            Response response = await dio
                .post("https://gateway.cgisoftware.com.br/sessao", data: {
              "usuario": this._edtUsuarioText.text,
              "senha": this._edtSenhaText.text,
              "pacific": this._edtServicoText.text,
              "versao": this.widget.versaoProgramaPacific,
              "cliente": this._edtCodigoText.text,
              "aplicativo": widget.aplicativo
            });

            if (response.data["token"] != null) {
              print(response.data["token"]);
              await _handler.set("token", response.data["token"]);

              this._isLoading = false;
              setState(() {});

              final snackBar = SnackBar(
                content: Text('Configurações salvas com sucesso!'),
              );

              _scaffoldKey.currentState.showSnackBar(snackBar);
              await Future.delayed(new Duration(milliseconds: 2000));
              Navigator.pop(context);
            }
          } catch (e) {
            _dialogMessage.show(e.toString(), context);
          }
        } else {
          this._isLoading = false;
          setState(() {});

          final snackBar = SnackBar(
            content: Text('Configurações salvas com sucesso!'),
          );

          _scaffoldKey.currentState.showSnackBar(snackBar);
          await Future.delayed(new Duration(milliseconds: 2000));
          Navigator.pop(context);
        }
      }
    }
  }
}
