import 'dart:developer';

import 'package:cids_cgi/src/module/settings/domain/model/token.dart';
import 'package:dio/dio.dart';

class LoginGatewayRepository {
  final Dio dio;
  LoginGatewayRepository(this.dio);

  Future<Token?> call(Map<String, dynamic> payload) async {
    try {
      Response response = await this.dio.post("/sessao", data: payload);

      return Token.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }
}
