import 'package:cids_cgi/cids_cgi.dart';
import 'package:dio/dio.dart';

class RefreshGatewayRepository {
  refresh(String aplicativo) async {
    try {
      final dio = new Dio();
      final handler = new SharedPreferencesHandler();

      final String? aplicativo = await handler.getNomeAplicativo();
      final bool loginPersonalizado = await handler.getLogin();
      final String? usuarioP = await handler.getUsuarioP();
      final String? usuario = await handler.getUsuario();
      final String? senhaP = await handler.getSenhaP();
      final String? codigo = await handler.getCodigo();
      final String? senha = await handler.getSenha();
      final String? servico = await handler.getURL();

      final Map<String, dynamic> payload = {
        "usuario": loginPersonalizado ? usuarioP : usuario,
        "senha": loginPersonalizado ? senhaP : senha,
        "pacific": servico,
        "versao": await handler.getVersaoProgramaPacific(),
        "cliente": codigo,
        "aplicativo": aplicativo
      };

      Response response = await dio
          .post("https://gateway.cgisoftware.com.br/sessao", data: payload);

      if (response.data["token"] != null) {
        print(response.data["token"]);
        await handler.set("token", response.data["token"]);
      }
    } catch (e) {
      throw e;
    }
  }
}
