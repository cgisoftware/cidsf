class ErrorHandler {
  var result;

  ErrorHandler(this.result);

  Future<Retorno> validaErro() async {
    if (result == 'OK') {
      Retorno r = new Retorno(false, "Não foi encontrado erro");
      return r;
    }

    if (result ==
        'Não foi possivel verificar as permissões de acesso junto aos servidores da CGI. Verifique o código de acesso nas configurações !') {
      Retorno r = new Retorno(true, result);
      return r;
    }

    if (result == '') {
      Retorno r = new Retorno(true, "Nada retornou do servidor");
      return r;
    }

    if (result['retorno'] != null) {
      if (result['retorno'][0]['estatus'] == 'Erro') {
        Retorno r = new Retorno(true, result['retorno'][0]['msgErro']);
        return r;
      }

      if (result['retorno'][0]['estatus'] == 'Imagem - Erro') {
        Retorno r = new Retorno(true, result['retorno'][0]['msgErro']);
        return r;
      }

      if (result['retorno'][0]['msgErro'] != null) {
        Retorno r = new Retorno(false, "Não foi encontrado erro");
        return r;
      }
    }

    if (result['logErroApp'] != null) {
      Retorno r = new Retorno(true, result['logErroApp'][0]['erro']);
      return r;
    }

    if (result['message'] != null) {
      Retorno r = new Retorno(true, result['message']);
      return r;
    }

    if (result['msg'] != null) {
      Retorno r = new Retorno(true, result['msg']);
      return r;
    }

    Retorno r = new Retorno(false, "Não foi encontrado erro");
    return r;
  }
}

class Retorno {
  bool erro;
  String? mensagem;

  Retorno(this.erro, this.mensagem);
}