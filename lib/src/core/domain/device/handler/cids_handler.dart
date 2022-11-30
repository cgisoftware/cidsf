import 'package:cids_cgi/src/core/domain/device/handler/shared_preferences_handler.dart';
import 'package:firebase_core/firebase_core.dart';

class CidsHandler {
  final _handler = SharedPreferencesHandler();
  Future initialize(
      {String senha = "",
      required String aplicativo,
      int versaoPacific = 1,
      bool gateway = false,
      bool loginPorCpfCnpj = false,
      bool campoMotorista = false,
      bool useCnpj = false,
      bool rh = false,
      bool useFirebase = true,
      bool usePacificUrl = false,
      String chaveDev = ""}) async {
    await _handler.setUseCnpj(useCnpj);
    await _handler.setVersaoProgramaPacific(versaoPacific);
    await _handler.setNomeAplicativo(aplicativo);
    await _handler.setPasswordFirebase(senha);
    await _handler.setGateway(gateway);
    await _handler.setLogin(loginPorCpfCnpj);
    await _handler.setCampoMotorista(campoMotorista);
    await _handler.setUseFirebase(useFirebase);
    await _handler.setUsePacificUrl(usePacificUrl);
    await _handler.setRH(rh);
    await _handler.setChaveDev(chaveDev);
    if (useFirebase) {
      await Firebase.initializeApp();
    }
  }
}
