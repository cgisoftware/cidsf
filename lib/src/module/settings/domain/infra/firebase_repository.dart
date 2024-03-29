import 'package:cids_cgi/src/core/domain/device/handler/date_handler.dart';
import 'package:cids_cgi/src/module/settings/domain/model/firebase.dart';
import 'package:cids_cgi/src/module/settings/error/messages.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cids_cgi/cids_cgi.dart';
import 'dart:async';
import 'dart:io';

class FirebaseRepository {
  final handler = SharedPreferencesHandler();
  final dateHandler = DateHandler();
  final String? codigoAcesso;
  FirebaseRepository({this.codigoAcesso});

  Future<String> auth(String email, String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signOut();
      await _auth.signInWithEmailAndPassword(email: this.codigoAcesso! + email, password: password);

      return await permissions();
    } catch (e) {
      return "$string001|${e.toString()}";
    }
  }

  Future<String> permissions() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("Permissoes").doc(this.codigoAcesso).get();

      Firebase firebase = Firebase.fromJson(snapshot.data()!);

      // verifica se está ativo
      if (firebase.ativo!.toLowerCase() != "sim") {
        return string002;
      }

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      // verifica a validade do app
      List<String> vDtAtual = dateHandler.getData(dateHandler.getDate());
      List<String> vDtValidade = dateHandler.getData(firebase.dtValidade!);
      if (int.tryParse(vDtAtual[4])! > int.tryParse(vDtValidade[4])!) {
        return string003;
      }

      // black_list
      List<String> vLista = firebase.blackList!.split(",");
      for (int i = 0; i <= vLista.length - 1; i++) {
        if (Platform.isIOS) {
          IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
          if (vLista[i].contains(iosInfo.identifierForVendor.toString())) {
            return string004;
          }
        } else {
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          if (vLista[i].contains(androidInfo.id.toString())) {
            return string004;
          }
        }
      }

      // versao_minima
      if (int.tryParse(packageInfo.buildNumber)! < firebase.versaoMinima!) {
        return string005;
      }

      String? sUsuario = await (handler.get("edtUsuario"));
      String? sSenha = await (handler.get("edtSenha"));
      String? sServico = await (handler.get("edtServico"));

      if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        FirebaseFirestore.instance.collection("Permissoes").doc(this.codigoAcesso).collection("Devices").doc(iosInfo.identifierForVendor.toString()).set({
          "identifierForVendor": iosInfo.identifierForVendor.toString(),
          "model": iosInfo.model.toString(),
          "localizedModel": iosInfo.localizedModel.toString(),
          "name": iosInfo.name.toString(),
          "systemName": iosInfo.systemName.toString(),
          "systemVersion": iosInfo.systemVersion.toString(),
          "versao_aplicativo": packageInfo.version.toString(),
          "versao_code": packageInfo.buildNumber.toString(),
          "dt_acesso": dateHandler.getDate(),
          "erp_codigo_acesso": this.codigoAcesso.toString(),
          "erp_usuario_cgi": sUsuario,
          "erp_senha_cgi": sSenha,
          "erp_servico": sServico
        });
      } else {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        FirebaseFirestore.instance.collection("Permissoes").doc(this.codigoAcesso).collection("Devices").doc(androidInfo.id.toString()).set({
          "androidId": androidInfo.id.toString(),
          "device": androidInfo.device.toString(),
          "model": androidInfo.model.toString(),
          "version": androidInfo.version.toString(),
          "board": androidInfo.board.toString(),
          "bootloader": androidInfo.bootloader.toString(),
          "display": androidInfo.display.toString(),
          "fingerprint": androidInfo.fingerprint.toString(),
          "hardware": androidInfo.hardware.toString(),
          "brand": androidInfo.brand.toString(),
          "host": androidInfo.host.toString(),
          "id": androidInfo.id.toString(),
          "manufacturer": androidInfo.manufacturer.toString(),
          "product": androidInfo.product.toString(),
          "type": androidInfo.type.toString(),
          "versao_aplicativo": packageInfo.version.toString(),
          "versao_code": packageInfo.buildNumber.toString(),
          "dt_acesso": dateHandler.getDate(),
          "erp_codigo_acesso": this.codigoAcesso.toString(),
          "erp_usuario_cgi": sUsuario,
          "erp_senha_cgi": sSenha,
          "erp_servico": sServico
        });
      }

      await handler.set("diasAutenticacao", firebase.diasAutenticacao.toString());
      await handler.set("edtServico", firebase.enderecoPacific!);
      await handler.set("dtUltAutenticacao", dateHandler.getData(dateHandler.getDate())[4]);
      await handler.set("versao", packageInfo.version);
      await handler.set("numDevices", firebase.numDevices.toString());
      await handler.set("numDevicesVendedor", firebase.numDevicesVendedor.toString());
      await handler.set("usuarioP", firebase.usuarioP.toString());
      await handler.set("senhaP", firebase.senhaP.toString());
      await handler.set("versao_minima", firebase.versaoMinima.toString());
      await handler.set("permite_alterar_quantidade_escaneada", firebase.permiteAlterarQuantidadeEscaneada.toString());
      return '';
    } catch (e) {
      return e.toString();
    }
  }
}
