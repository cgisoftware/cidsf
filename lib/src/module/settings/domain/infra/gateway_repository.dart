import 'package:cids_cgi/cids_cgi.dart';
import 'package:dio/dio.dart';

class GatewayRepository {
  refresh(String aplicativo) async {
    try {
      final dio = new Dio();
      final handler = new SharedPreferencesHandler();

      Response response =
          await dio.post("https://gateway.cgisoftware.com.br/sessao", data: {
        "usuario": await handler.getUsuario(),
        "senha": await handler.getSenha(),
        "pacific": await handler.getURL(),
        "versao": await handler.getVersaoProgramaPacific(),
        "cliente": await handler.getCodigo(),
        "aplicativo": aplicativo
      });

      if (response.data["token"] != null) {
        print(response.data["token"]);
        await handler.set("token", response.data["token"]);
      }
    } catch (e) {
      throw e;
    }
  }
}
