class AcessoApp {
  int? id;
  dynamic usuario;
  dynamic senha;
  String? apiToken;
  int? idProjeto;
  int? idProxy;
  bool? ativo;
  bool? moduloMaisUsados;
  bool? moduloAvaliacaoUsados;
  bool? moduloMaisNegocios;
  bool? moduloMaisPedidos;
  bool? moduloVisitas;
  int? qtdDevices;
  int? qtdDevicesPorUsuario;
  int? versaoMinima;
  int? versaoServico;
  String? proxyUrl;
  String? pacificUrl;
  String? nomeCliente;
  int? idCliente;
  String? nomeProjeto;

  AcessoApp({
    this.id,
    this.usuario,
    this.senha,
    this.apiToken,
    this.idProjeto,
    this.idProxy,
    this.ativo,
    this.moduloMaisUsados,
    this.moduloAvaliacaoUsados,
    this.moduloMaisNegocios,
    this.moduloMaisPedidos,
    this.moduloVisitas,
    this.qtdDevices,
    this.qtdDevicesPorUsuario,
    this.versaoMinima,
    this.versaoServico,
    this.proxyUrl,
    this.pacificUrl,
    this.nomeCliente,
    this.idCliente,
    this.nomeProjeto,
  });

  factory AcessoApp.fromJson(Map<String, dynamic> json) => AcessoApp(
        id: json["id"] == null ? null : json["id"],
        usuario: json["usuario"],
        senha: json["senha"],
        apiToken: json["apiToken"] == null ? null : json["apiToken"],
        idProjeto: json["idProjeto"] == null ? null : json["idProjeto"],
        idProxy: json["idProxy"] == null ? null : json["idProxy"],
        ativo: json["ativo"] == null ? null : json["ativo"],
        moduloMaisUsados: json["moduloMaisUsados"] == null ? null : json["moduloMaisUsados"],
        moduloAvaliacaoUsados: json["moduloAvaliacaoUsados"] == null ? null : json["moduloAvaliacaoUsados"],
        moduloMaisNegocios: json["moduloMaisNegocios"] == null ? null : json["moduloMaisNegocios"],
        moduloMaisPedidos: json["moduloMaisPedidos"] == null ? null : json["moduloMaisPedidos"],
        moduloVisitas: json["moduloVisitas"] == null ? null : json["moduloVisitas"],
        qtdDevices: json["qtdDevices"] == null ? null : json["qtdDevices"],
        qtdDevicesPorUsuario: json["qtdDevicesPorUsuario"] == null ? null : json["qtdDevicesPorUsuario"],
        versaoMinima: json["versaoMinima"] == null ? null : json["versaoMinima"],
        versaoServico: json["versaoServico"] == null ? null : json["versaoServico"],
        proxyUrl: json["proxyURL"] == null ? null : json["proxyURL"],
        pacificUrl: json["pacificURL"] == null ? null : json["pacificURL"],
        nomeCliente: json["nomeCliente"] == null ? null : json["nomeCliente"],
        idCliente: json["idCliente"] == null ? null : json["idCliente"],
        nomeProjeto: json["nomeProjeto"] == null ? null : json["nomeProjeto"],
      );
}
