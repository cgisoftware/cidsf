library cids_cgi;

import 'package:cids_cgi/src/core/domain/device/handler/date_handler.dart';
import 'package:package_info/package_info.dart';
import 'package:cids_cgi/cids_cgi.dart';
import 'package:flutter/material.dart';
import 'firebase_repository.dart';
import 'dart:async';
class SegurancaRepository {
  final String? email;
  final handler = SharedPreferencesHandler();
  final dateHandler = DateHandler();

  SegurancaRepository({@required this.email});

  Future<String> call(String password) async {
    try {
      final firebaseRepository =
          FirebaseRepository(codigoAcesso: await (handler.get("edtCodigo")));
      String diasAutenticacao = await (handler.get("diasAutenticacao")) ?? '';
      String dtUltimaAutenticacao =
          await (handler.get("dtUltAutenticacao")) ?? '';
      int? iDataAtual =
          int.tryParse(dateHandler.getData(dateHandler.getDate())[4]);
      int? iDataAutenticacao = int.tryParse(dtUltimaAutenticacao);
      int? iDias = int.tryParse(diasAutenticacao);

      if (iDias == 0 || iDias == null) {
        return await firebaseRepository.auth(email!, password);
      } else {
        
        if (dtUltimaAutenticacao.trim().length == 0) {
          return await firebaseRepository.auth(email!, password);
        } else {
          if (iDataAutenticacao! + iDias <= iDataAtual!) {
            return await firebaseRepository.auth(email!, password);
          } else {
            PackageInfo packageInfo = await PackageInfo.fromPlatform();

            String sVersao = (await (handler.get("versao")))!;

            if (sVersao.toLowerCase() == packageInfo.version.toLowerCase()) {
              return '';
            } else {
              await firebaseRepository.auth(email!, password);
            }
          }

          return '';
        }
      }
      
    } catch (e) {
      throw e;
    }
  }
}
