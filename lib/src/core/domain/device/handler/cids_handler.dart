import 'package:cids_cgi/src/core/domain/device/handler/shared_preferences_handler.dart';
import 'package:firebase_core/firebase_core.dart';

class CidsHandler {
  final _handler = SharedPreferencesHandler();
  Future initialize(
      {required String senha,
      required String aplicativo,
      required int versaoPacific,
      bool gateway = false,
      bool loginPorCpfCnpj = false,
      bool useCnpj = false}) async {
         await _handler.setUseCnpj(useCnpj);
    await _handler.setVersaoProgramaPacific(versaoPacific);
    await _handler.setNomeAplicativo(aplicativo);
    await _handler.setPasswordFirebase(senha);
    await _handler.setGateway(gateway);
    await _handler.setLogin(loginPorCpfCnpj);
    await Firebase.initializeApp();
  }
}
