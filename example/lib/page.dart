import 'package:cids_cgi/cids_cgi.dart';
import 'package:cids_cgi_example/main.dart';
import 'package:flutter/material.dart';

final biometricsPage = BiometricsErrorPage(
    biometricsHandler: biometricsHandler,
    context: (context) {
      biometricsContext = context;
    });

final homePage = MyHome(context: (context) {
  biometricsContext = context;
});

final authPage = AuthPage(
  validaLogin: null,
  dropDb: () async {
    //manupula os dados salvos
  },
  frase: 'Todos os indicadores da sua empresa',
  imagePath: "images/index.jpg",
);

final settingsPage = SettingsPage(
  validaLogin: null,
  appBarColor: Colors.red,
  appBarTextColor: Colors.white,
);
