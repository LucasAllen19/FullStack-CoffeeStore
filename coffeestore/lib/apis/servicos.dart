// ignore_for_file: non_constant_identifier_names, constant_identifier_names
import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:coffeestore/autenticador.dart';

final URL_SERVICOS = Uri.parse("http://10.0.2.2");

final URL_CAFES = "${URL_SERVICOS.toString()}:6001/cafes";
final URL_CAFE = "${URL_SERVICOS.toString()}:6001/cafe";

final URL_COMENTARIOS = "${URL_SERVICOS.toString()}:6002/comentarios";
final URL_ADICIONAR_COMENTARIO = "${URL_SERVICOS.toString()}:6002/adicionar";
final URL_REMOVER_COMENTARIO = "${URL_SERVICOS.toString()}:6002/remover";

final URL_CURTIU = "${URL_SERVICOS.toString()}:6003/curtiu";
final URL_CURTIR = "${URL_SERVICOS.toString()}:6003/curtir";
final URL_DESCURTIR = "${URL_SERVICOS.toString()}:6003/descurtir";

final URL_ARQUIVOS = "${URL_SERVICOS.toString()}:6005";

class ServicoCafes {
  Future<List<dynamic>> getCafes(
      int ultimoCafe, int tamanhoPagina) async {
    final resposta = await http.get(
        Uri.parse("${URL_CAFES.toString()}/$ultimoCafe/$tamanhoPagina"));
    final cafes = jsonDecode(resposta.body);

    return cafes;
  }

  Future<List<dynamic>> findCafes(
      int ultimoCafe, int tamanhoPagina, String nome) async {
    final resposta = await http.get(Uri.parse(
        "${URL_CAFES.toString()}/$ultimoCafe/$tamanhoPagina/$nome"));
    final cafes = jsonDecode(resposta.body);

    return cafes;
  }

  Future<Map<String, dynamic>> findCafe(int idCafe) async {
    final resposta =
        await http.get(Uri.parse("${URL_CAFE.toString()}/$idCafe"));
    final cafes = jsonDecode(resposta.body);

    return cafes;
  }
}

class ServicoCurtidas {
  Future<bool> curtiu(Usuario usuario, int idCafe) async {
    final resposta = await http
        .get(Uri.parse("${URL_CURTIU.toString()}/${usuario.email}/$idCafe"));
    final resultado = jsonDecode(resposta.body);

    return resultado["curtiu"] as bool;
  }

  Future<dynamic> curtir(Usuario usuario, int idCafe) async {
    final resposta = await http.post(
        Uri.parse("${URL_CURTIR.toString()}/${usuario.email}/$idCafe"));

    return jsonDecode(resposta.body);
  }

  Future<dynamic> descurtir(Usuario usuario, int idCafe) async {
    final resposta = await http.post(
        Uri.parse("${URL_DESCURTIR.toString()}/${usuario.email}/$idCafe"));

    return jsonDecode(resposta.body);
  }
}

class ServicoComentarios {
  Future<List<dynamic>> getComentarios(
      int idCafe, int pagina, int tamanhoPagina) async {
    final resposta = await http.get(Uri.parse(
        "${URL_COMENTARIOS.toString()}/$idCafe/$pagina/$tamanhoPagina"));
    final comentarios = jsonDecode(resposta.body);

    return comentarios;
  }

  Future<dynamic> adicionar(
      int idCafe, Usuario usuario, String comentario) async {
    final resposta = await http.post(Uri.parse(
        "${URL_ADICIONAR_COMENTARIO.toString()}/$idCafe/${usuario.nome}/${usuario.email}/$comentario"));

    return jsonDecode(resposta.body);
  }

  Future<dynamic> remover(int idComentario) async {
    final resposta = await http.delete(
        Uri.parse("${URL_REMOVER_COMENTARIO.toString()}/$idComentario"));

    return jsonDecode(resposta.body);
  }
}

String caminhoArquivo(String arquivo) {
  return "${URL_ARQUIVOS.toString()}/$arquivo";
}
