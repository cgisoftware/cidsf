import 'package:cids_cgi/src/module/settings/domain/controller/firebase_controller.dart';
import 'package:cids_cgi/src/module/settings/domain/infra/login_gateway_repository.dart';
import 'package:cids_cgi/src/module/settings/domain/usecase/login_pacific_usecase.dart';
import 'package:cids_cgi/src/module/auth/controller/auth_controller.dart';
import 'package:cids_cgi/cids_cgi.dart';
import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';

final dioOptions = BaseOptions(baseUrl: "https://gateway.cgisoftware.com.br");
final dio = Dio(dioOptions);

final segurancaRepository = new SegurancaRepository(email: "@cgi.com.br");

final loginGatewayRepository = new LoginGatewayRepository(dio);


final loginPacificUseCase = LoginPacificUseCase(loginGatewayRepository, segurancaRepository);

final authController = (BuildContext context, Function? validaLogin) => new AuthController(
    context: context,
    loginPacificUseCase: loginPacificUseCase, validaLogin: validaLogin);

final firebaseController =
    (BuildContext context, Function? validaLogin) => FirebaseController(context: context, loginPacificUseCase: loginPacificUseCase, validaLogin: validaLogin);
