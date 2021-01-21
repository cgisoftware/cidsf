import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info/package_info.dart';

class SharedPreferencesHandler {
  Future set(
    String key,
    String value,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future get(String key) async {
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
    int numDevices = int.parse(await this.get('numDevices'));
    return numDevices;
  }

  Future<int> getNumDevicesVendedor() async {
    int numDevices = int.parse(await this.get('numDevicesVendedor'));
    return numDevices;
  }

  Future getCodigo() async {
    var cod = await this.get('edtCodigo');
    return cod;
  }

  Future getSenha() async {
    var senha = await this.get('edtSenha');
    return senha;
  }

  Future getURL() async {
    var url = await this.get('edtServico');
    return url;
  }

  Future getUsuario() async {
    var usuario = await this.get('edtUsuario');
    return usuario;
  }

  Future getMotorista() async {
    var motorista = await this.get('edtMotorista');
    return motorista;
  }

  Future getPlaca() async {
    var placa = await this.get('edtPlaca');
    return placa;
  }

  Future getToken() async {
    var token = await this.get('token');
    return token;
  }

  Future getVersaoMinima() async {
    var token = await this.get('versao_minima');
    return token;
  }

  Future<int> getVersaoProgramaPacific() async {
    var token = await this.get('versaoProgramaPacific');
    return int.parse(token);
  }

  Future setVersaoProgramaPacific(int version) async {
    await this.set('versaoProgramaPacific', version.toString());
  }

  Future<String> getNomeAplicativo() async {
    var token = await this.get('aplicativo');
    return token;
  }

  Future<bool> getGateway() async {
    var token = await this.get('gateway');
    return token == "true";
  }

  Future<String> getPasswordFirebase() async {
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


  Future logout() {
    this.remove("edtCodigo");
                                  this.remove("edtSenha");
                                  this
                                      .remove("edtUsuario");
                                  this
                                      .remove("edtServico");
  }
}
