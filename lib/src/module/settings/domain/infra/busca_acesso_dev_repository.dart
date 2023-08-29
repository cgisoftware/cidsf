import 'package:cids_cgi/cids_cgi.dart';
import 'package:cids_cgi/src/module/settings/domain/model/acesso_app.dart';
import 'package:dio/dio.dart';

class BuscaAcessoDevRepository {
  final Dio dio = new Dio();
  BuscaAcessoDevRepository();

  Future<String> call(String codCliCgi) async {
    try {
      final handler = SharedPreferencesHandler();
      final chave = await handler.getChaveDev();
      final usePacificUrl = await handler.usePacificUrl();
      Response response = await this.dio.get("https://desenvapi.cgisoftware.com.br/acesso-app/chave/$codCliCgi?apiToken=$chave");

      final acessoApp = AcessoApp.fromJson(response.data);

      await handler.set("edtServico", usePacificUrl ? acessoApp.pacificUrl! : acessoApp.proxyUrl!);
      await handler.set("numDevices", acessoApp.qtdDevices.toString());
      await handler.set("numDevicesVendedor", acessoApp.qtdDevicesPorUsuario.toString());
      await handler.set("usuarioP", acessoApp.usuario.toString());
      await handler.set("senhaP", acessoApp.senha.toString());
      await handler.set("versao_minima", acessoApp.versaoMinima.toString());
      return "";
    } on DioException catch (e) {
      return e.response?.data.toString() ?? "Não conseguimos verificar as informações no nosso Proxy!";
    } catch (e) {
      return "Não conseguimos verificar as informações no nosso Proxy!";
    }
  }
}
