class Firebase {
  String? ativo;
  String? blackList;
  int? codCli;
  int? diasAutenticacao;
  String? dtValidade;
  String? enderecoPacific;
  String? nomeCli;
  int? versaoMinima;
  int? numDevices;
  int? numDevicesVendedor;
  bool? permiteAlterarQuantidadeEscaneada;
  String? usuario;
  String? senha;
  bool? login;

  Firebase(
      {this.ativo,
      this.blackList,
      this.codCli,
      this.diasAutenticacao,
      this.dtValidade,
      this.enderecoPacific,
      this.nomeCli,
      this.versaoMinima,
      this.numDevices,
      this.numDevicesVendedor,
      this.permiteAlterarQuantidadeEscaneada,
      this.usuario,
      this.senha,
      this.login});

  factory Firebase.fromJson(Map<String, dynamic> json) => Firebase(
      ativo: json["ativo"] == null ? null : json["ativo"],
      blackList: json["black_list"] == null ? null : json["black_list"],
      codCli: json["cod_cli"] == null ? null : json["cod_cli"],
      diasAutenticacao:
          json["dias_autenticacao"] == null ? null : json["dias_autenticacao"],
      dtValidade: json["dt_validade"] == null ? null : json["dt_validade"],
      enderecoPacific:
          json["endereco_pacific"] == null ? null : json["endereco_pacific"],
      nomeCli: json["nome_cli"] == null ? null : json["nome_cli"],
      versaoMinima:
          json["versao_minima"] == null ? null : json["versao_minima"],
      numDevices: json["num_devices"] == null ? null : json["num_devices"],
      numDevicesVendedor: json["num_devices_vendedor"] == null
          ? null
          : json["num_devices_vendedor"],
      usuario: json["usuario"] == null ? null : json["usuario"],
      senha: json["senha"] == null ? null : json["senha"],
      login: json["login"] == null ? null : json["login"],
      permiteAlterarQuantidadeEscaneada:
          json["permite_alterar_quantidade_escaneada"] == null
              ? null
              : json["permite_alterar_quantidade_escaneada"]);
}
