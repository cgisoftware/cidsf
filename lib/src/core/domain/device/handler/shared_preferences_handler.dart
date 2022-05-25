import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SharedPreferencesHandler {
  Future set(
    String key,
    String value,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<Map<String, dynamic>> getBuildVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return {'b': packageInfo.buildNumber.toString(), 'v': packageInfo.version};
  }

  Future<int> getNumDevices() async {
    int numDevices = int.parse((await this.get('numDevices'))!);
    return numDevices;
  }

  Future<int> getNumDevicesVendedor() async {
    int numDevices = int.parse((await (this.get('numDevicesVendedor')))!);
    return numDevices;
  }

  Future<bool> getLogin() async {
    var login = await this.get('login') == 'true';
    return login;
  }

  Future<bool> useCnpj() async {
    var cnpj = await this.get('useCnpj') == 'true';
    return cnpj;
  }

  Future<String?> getCodigo() async {
    var cod = await this.get('edtCodigo');
    return cod;
  }

  Future<String?> getSenha() async {
    var senha = await this.get('edtSenha');
    return senha;
  }

  Future<String?> getURL() async {
    var url = await this.get('edtServico');
    return url;
  }

  Future<String?> getUsuario() async {
    var usuario = await this.get('edtUsuario');
    return usuario;
  }

  Future<String?> getUsuarioP() async {
    var usuarioP = await this.get('usuarioP');
    return usuarioP;
  }

  Future<String?> getSenhaP() async {
    var senhaP = await this.get('senhaP');
    return senhaP;
  }

  Future<String?> getMotorista() async {
    var motorista = await this.get('edtMotorista');
    return motorista;
  }

  Future<String?> getPlaca() async {
    var placa = await this.get('edtPlaca');
    return placa;
  }

  Future<String?> getToken() async {
    var token = await this.get('token');
    return token;
  }

  Future<String?> getVersaoMinima() async {
    var token = await this.get('versao_minima');
    return token;
  }

  Future getCampoMotorista() async {
    var campoMotorista = await this.get('campo_motorista') == 'true';
    return campoMotorista;
  }

  Future<int> getVersaoProgramaPacific() async {
    var token = await this.get('versaoProgramaPacific');
    return int.parse(token!);
  }

  Future setVersaoProgramaPacific(int version) async {
    await this.set('versaoProgramaPacific', version.toString());
  }

  Future<String?> getNomeAplicativo() async {
    var token = await this.get('aplicativo');
    return token;
  }

  Future<bool> getGateway() async {
    var token = await this.get('gateway');
    return token == "true";
  }

  Future<String?> getPasswordFirebase() async {
    var token = await this.get('senhaFirebase');
    return token;
  }

  Future setNomeAplicativo(String nome) async {
    await this.set('aplicativo', nome);
  }

  Future setGateway(bool gateway) async {
    await this.set('gateway', gateway.toString());
  }

  Future setPasswordFirebase(String password) async {
    await this.set('senhaFirebase', password);
  }

  Future setLogin(bool login) async {
    await this.set('login', login.toString());
  }

  Future setCampoMotorista(bool campoMotorista) async {
    await this.set('campo_motorista', campoMotorista.toString());
  }

  Future setRH(bool rh) async {
    await this.set('rh', rh.toString());
  }

  Future setUseCnpj(bool useCnpj) async {
    await this.set('useCnpj', useCnpj.toString());
  }

  logout() {
    this.remove("edtCodigo");
    this.remove("edtSenha");
    this.remove("edtUsuario");
    this.remove("edtServico");
    this.remove("biometria");
  }

  Future<bool> isAuth() async {
    if ((await this.getURL()) != null && (await this.getURL())!.isNotEmpty) {
      return true;
    }

    return false;
  }

  Future desabilitarBiometria() async {
    await this.set('biometria', "false");
  }

  Future habilitarBiometria() async {
    await this.set('biometria', "true");
  }

  Future getBiometria() async {
    await this.get('biometria');
  }

  Future permiteAlterarQuantidadeEscaneada() async {
    var token = await this.get('permite_alterar_quantidade_escaneada');
    return token == "true";
  }
}
