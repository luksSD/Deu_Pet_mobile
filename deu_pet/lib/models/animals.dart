class Animals {

  Animals({
    this.id,
    this.nome,
    this.tipo,
    this.sexo,
    this.peso,
    this.porte,
    this.raca,
    this.situacao,
    this.temperamento,
    this.pelagemPrimaria,
    this.pelagemSecundaria,
    this.primaryImagePath
  });
  
  int? id;
  String? nome;
  String? tipo;
  String? sexo;
  double? peso;
  String? porte;
  String? raca;
  String? situacao;
  String? temperamento;
  String? pelagemPrimaria;
  String? pelagemSecundaria;
  String? primaryImagePath;

  factory Animals.fromJson(Map<String, dynamic> json) => Animals(
    id: json["id"],
    nome: json["nome"],
    tipo: json["tipo"],
    sexo: json["sexo"],
    peso: json["peso"],
    porte: json["porte"],
    raca: json["raca"],
    situacao: json["situacao"],
    temperamento: json["temperamento"],
    pelagemPrimaria: json["pelagemPrimaria"],
    pelagemSecundaria: json["pelagemSecundaria"],
    primaryImagePath: json["primaryImagePath"],
  );

  Map<String,dynamic> toJson() => {
    "nome": nome,
    "tipo": tipo,
    "sexo": sexo,
    "peso": peso,
    "porte": porte,
    "raca": raca,
    "situacao": situacao,
    "temperamento": temperamento,
    "pelagemPrimaria": pelagemPrimaria,
    "pelagemSecundaria": pelagemSecundaria,
    "primaryImagePath": primaryImagePath
  };
 

}