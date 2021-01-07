import 'package:cids_cgi/device/handler/date_handler.dart';
import 'package:cids_cgi/device/handler/shared_preferences_handler.dart';
import 'package:cids_cgi/module/settings/domain/infra/firebase_repository.dart';
import 'package:cids_cgi/module/settings/domain/infra/gateway_repository.dart';
import 'package:package_info/package_info.dart';
import 'dart:async';

class Seguranca {
  final String email;
  final String password;
  final handler = SharedPreferencesHandler();
  final dateHandler = DateHandler();

  Seguranca({this.email, this.password});

  Future<String> execute() async {
    final firebaseRepository =
        FirebaseRepository(codigoAcesso: await handler.get("edtCodigo"));
    String diasAutenticacao = await await handler.get("diasAutenticacao");
    String dtUltimaAutenticacao = await await handler.get("dtUltAutenticacao");
    int iDataAtual =
        int.tryParse(dateHandler.getData(dateHandler.getDate())[4]);
    int iDataAutenticacao = int.tryParse(dtUltimaAutenticacao);
    int iDias = int.tryParse(diasAutenticacao);

    if (iDias == 0 || iDias == null) {
      return await firebaseRepository.auth(email, password);
    } else {
      if (dtUltimaAutenticacao.trim().length == 0) {
        return await firebaseRepository.auth(email, password);
      } else {
        if (iDataAutenticacao + iDias <= iDataAtual) {
          return await firebaseRepository.auth(email, password);
        } else {
          PackageInfo packageInfo = await PackageInfo.fromPlatform();

          String sVersao = await await handler.get("versao");

          if (sVersao.toLowerCase() == packageInfo.version.toLowerCase()) {
            return '';
          } else {
            await firebaseRepository.auth(email, password);
          }
        }

        return '';
      }
    }
  }

  refresh(String aplicativo) async {
    try {
      final gatewayRepository = GatewayRepository();

      await gatewayRepository.refresh(aplicativo);
    } catch (e) {
      throw e;
    }
  }
}
