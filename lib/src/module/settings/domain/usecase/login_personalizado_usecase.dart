// import 'dart:async';
// import 'dart:developer';
// import 'package:cids_cgi/src/core/domain/device/handler/shared_preferences_handler.dart';
// import 'package:cids_cgi/cids_cgi.dart';
// import 'package:cids_cgi/src/module/settings/domain/infra/login_gateway_repository.dart';
// import 'package:cids_cgi/src/module/settings/domain/model/token.dart';

// class FirebaseUseCase {
//   final SegurancaRepository? segurancaRepository;
//   final LoginGatewayRepository? loginGatewayRepository;

//   FirebaseUseCase(this.segurancaRepository, this.loginGatewayRepository);

//   Future<bool> call(String codigo) async {
//     try {
//       final handler = SharedPreferencesHandler();
//       await handler.set('edtCodigo', codigo);
//       final password = await handler.getPasswordFirebase();

//       var r = await segurancaRepository!(password!);
     
//       if (r != "") {
//         throw r;
//       }

//       final loginPersonalizado = await handler.getLogin();
//       return loginPersonalizado;
//     } catch (e) {
//       throw e;
//     }
//   }
// }



// // final bool usaGateway = await handler.getGateway();
// //       final String? usuario = await handler.getUsuario();
// //       final String? senha = await handler.getSenha();
// //       final String? servico = await handler.getURL();
// //       final String? aplicativo = await handler.getNomeAplicativo();
// //        debugger();
// //       if (loginPersonalizado) {
// //         //TODO

// //         return;
// //       }

// //       if (usaGateway) {
// //         final Map<String, dynamic> payload = {
// //             "usuario": usuario,
// //             "senha": senha,
// //             "pacific": servico,
// //             "versao": await handler.getVersaoProgramaPacific(),
// //             "cliente": codigo,
// //             "aplicativo": aplicativo
// //           };

// //           debugger();

// //         Token? token = (await loginGatewayRepository!(payload))!;

// //         await handler.set('token', token.token!);
// //       }
