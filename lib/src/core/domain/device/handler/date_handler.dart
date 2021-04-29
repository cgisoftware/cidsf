import 'package:intl/intl.dart';

class DateHandler {
  String getDate() {
    return new DateFormat("dd/MM/yyyy").format(new DateTime.now());
  }

  List<String> getData(String data) {
    int length = 9;
    List<String> vRetorno = List<String>.filled(length, data);
    int iDia = 0;
    int iMes = 0;
    int iAno = 0;
    String sAno = "";
    String sMes = "";
    String sDia = "";

    if (data.trim().length != 0) {
      iDia = int.tryParse(data.split("/")[0]);
      iMes = int.tryParse(data.split("/")[1]);
      iAno = int.tryParse(data.split("/")[2]);

      sDia = data.split("/")[0];
      sMes = data.split("/")[1];
      sAno = data.split("/")[2];
    }

    vRetorno[0] = data;
    vRetorno[1] = iDia.toString();
    vRetorno[2] = iMes.toString();
    vRetorno[3] = iAno.toString();
    vRetorno[4] = sAno + sMes + sDia;
    vRetorno[5] = sMes + "/" + sAno;
    vRetorno[6] = sDia;
    vRetorno[7] = sMes;
    vRetorno[8] = sAno;

    return vRetorno;
  }
}
