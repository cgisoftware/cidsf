

import 'package:cids_cgi/cids_cgi.dart';
import 'package:cids_cgi_example/main.dart';

final biometricsPage = BiometricsErrorPage(
  biometricsHandler: biometricsHandler,
  context: (context) {
    biometricsContext = context;
  }
);

final homePage = MyHome(
  context: (context) {
    biometricsContext = context;
  }
);

final authPage = AuthPage(
  dropDb: () async {
    //manupula os dados salvos
  },
  frase: 'Todos os indicadores da sua empresa',
  imagePath: "images/index.jpg",
);