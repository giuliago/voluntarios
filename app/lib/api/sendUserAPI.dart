import 'dart:convert';

//Enviar os dados para cá e mandar via HTTP para o arquivo recebeUser.php

class SendToBd {
  SendToBd({
    this.nome,
    this.email,
    this.senha,
    this.genero,
    this.regiao,
  });

  String nome;
  String email;
  String senha;
  String genero;
  String regiao;

  factory SendToBd.fromRawJson(String str) =>
      SendToBd.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SendToBd.fromJson(Map<String, dynamic> json) => SendToBd(
        nome: json["nome"],
        email: json["email"],
        senha: json["senha"],
        genero: json["genero"],
        regiao: json["regiao"],
      );

  Map<String, dynamic> toJson() => {
        "nome": nome,
        "email": email,
        "senha": senha,
        "genero": genero,
        "regiao": regiao,
      };
}
