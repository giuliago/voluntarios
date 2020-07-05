import 'dart:convert';

//Enviar os dados para cá e mandar via HTTP para o arquivo recebeUser.php

class SendToBd {
  SendToBd({
    this.pkIdusuario,
    this.nome,
    this.ukEmail,
    this.senha,
    this.genero,
    this.regiao,
  });

  String pkIdusuario;
  String nome;
  String ukEmail;
  String senha;
  String genero;
  String regiao;

  factory SendToBd.fromRawJson(String str) =>
      SendToBd.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SendToBd.fromJson(Map<String, dynamic> json) => SendToBd(
        pkIdusuario: json["pk_idusuario"],
        nome: json["nome"],
        ukEmail: json["uk_email"],
        senha: json["senha"],
        genero: json["genero"],
        regiao: json["regiao"],
      );

  Map<String, dynamic> toJson() => {
        "pk_idusuario": pkIdusuario,
        "nome": nome,
        "uk_email": ukEmail,
        "senha": senha,
        "genero": genero,
        "regiao": regiao,
      };
}
