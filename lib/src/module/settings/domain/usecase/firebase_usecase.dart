import 'package:cids_cgi/cids_cgi.dart';
import 'package:cids_cgi/src/core/domain/device/handler/dialog_handler.dart';
import 'package:cids_cgi/src/core/domain/device/handler/shared_preferences_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class FirebaseUseCase {
  call(
      String password,
      BuildContext context,
      String codigo,
      String usuario,
      String senha,
      String servico,
      String motorista,
      String placa,
      String aplicativo,
      bool gateway,
      bool biometria) async {
    final handler = SharedPreferencesHandler();
    final handlerDialog = DialogHandler();
    final seguranca = new Seguranca(email: "@cgi.com.br", password: password);

    await handler.set("edtCodigo", codigo);
    await handler.set("edtUsuario", usuario);
    await handler.set("edtSenha", senha);
    await handler.set("edtServico", servico);
    await handler.set("edtMotorista", motorista);
    await handler.set("edtPlaca", placa);
    await handler.set("biometria", biometria.toString());
    var r = await seguranca.execute(context);
    if (r != "") {
      handlerDialog.show(message: r, context: context);
      return false;
    } else {
      servico = await (handler.get("edtServico"));
      if (gateway) {
        try {
          Dio dio = new Dio();
          Response response = await dio
              .post("https://gateway.cgisoftware.com.br/sessao", data: {
            "usuario": usuario,
            "senha": senha,
            "pacific": servico,
            "versao": await handler.getVersaoProgramaPacific(),
            "cliente": codigo,
            "aplicativo": aplicativo
          });

          if (response.data["token"] != null) {
            await handler.set("token", response.data["token"]);

            return true;
          }
        } catch (e) {
          handlerDialog.show(message: e.toString(), context: context);
        }
      } else {
        return true;
      }
    }
  }
}
