import 'package:cids_cgi/src/module/settings/domain/infra/busca_acesso_dev_repository.dart';
import 'package:cids_cgi/src/module/settings/domain/infra/login_gateway_repository.dart';
import 'package:cids_cgi/cids_cgi.dart';
import 'dart:async';

import 'package:cids_cgi/src/module/settings/domain/model/token.dart';

class LoginPacificUseCase {
  final LoginGatewayRepository? loginGatewayRepository;
  final SegurancaRepository? segurancaRepository;
  final BuscaAcessoDevRepository? buscaAcessoDevRepository;

  LoginPacificUseCase(this.loginGatewayRepository, this.segurancaRepository, this.buscaAcessoDevRepository);

  Future call(String usuario, String senha, String codigo, bool biometria, String motorista) async {
    try {
      final handler = SharedPreferencesHandler();
      final password = await handler.getPasswordFirebase();

      await handler.set('edtUsuario', usuario);
      await handler.set('edtSenha', senha);
      await handler.set('biometria', biometria.toString());
      await handler.set('edtCodigo', codigo);
      await handler.set('edtMotorista', motorista);
      final useFirebase = await handler.useFirebase();

      final r = useFirebase ? await segurancaRepository!(password!) : await buscaAcessoDevRepository!(codigo);

      if (r != "") {
        throw r;
      }

      final bool usaGateway = await handler.getGateway();
      final String? servico = await handler.getURL();
      final String? aplicativo = await handler.getNomeAplicativo();

      final String? usuarioP = await handler.getUsuarioP();
      final String? senhaP = await handler.getSenhaP();

      final bool loginPersonalizado = await handler.getLogin();

      if (usaGateway) {
        final Map<String, dynamic> payload = {
          "usuario": loginPersonalizado ? usuarioP : usuario,
          "senha": loginPersonalizado ? senhaP : senha,
          "pacific": servico,
          "versao": await handler.getVersaoProgramaPacific(),
          "cliente": codigo,
          "aplicativo": aplicativo
        };

        Token? token = (await loginGatewayRepository!(payload))!;

        await handler.set('token', token.token!);
      }
    } catch (e) {
      throw e;
    }
  }
}
