from flask import Flask, jsonify
from urllib.request import urlopen
import mysql.connector as mysql
import json

servico = Flask("cafes")

SERVIDOR_BANCO = "banco"
USUARIO_BANCO = "root"
SENHA_BANCO = "admin"
NOME_BANCO = "coffeestore"

def get_conexao_com_bd():
    conexao = mysql.connect(host=SERVIDOR_BANCO, user=USUARIO_BANCO, password=SENHA_BANCO, database=NOME_BANCO)

    return conexao


URL_LIKES = "http://likes:5000/likes_por_feed/"
def get_quantidade_de_curtidas(id_do_feed):
    url = URL_LIKES + str(id_do_feed)
    resposta = urlopen(url)
    resposta = resposta.read()
    resposta = json.loads(resposta)

    return resposta["curtidas"]

@servico.get("/info")
def get_info():
    return jsonify(
        descricao = "gerenciamento de cafes da coffestore",
        versao = "1.0"
    )

@servico.get("/cafes/<int:ultimo_feed>/<int:tamanho_da_pagina>")
def get_cafes(ultimo_feed, tamanho_da_pagina):
    cafes = []

    conexao = get_conexao_com_bd()
    cursor = conexao.cursor(dictionary=True)
    cursor.execute(
        "SELECT feeds.id as cafe_id, DATE_FORMAT(feeds.data, '%Y-%m-%d %H:%i') as data, " +
        "empresas.id as empresa_id, empresas.nome as nome_empresa, empresas.avatar, cafes.nome as nome_cafe, cafes.descricao, FORMAT(cafes.preco, 2) as preco, " +
        "cafes.url, cafes.imagem1, IFNULL(cafes.imagem2, '') as imagem2, IFNULL(cafes.imagem3, '') as imagem3 " +
        "FROM feeds, cafes, empresas " +
        "WHERE cafes.id = feeds.cafe " +
        "AND empresas.id = cafes.empresa " +
        "AND feeds.id > " + str(ultimo_feed) + " ORDER BY cafe_id ASC, data DESC " +
        "LIMIT " + str(tamanho_da_pagina)
    )
    cafes = cursor.fetchall()
    if cafes:
        for cafe in cafes:
            cafe["curtidas"] = get_quantidade_de_curtidas(cafe['cafe_id'])

    conexao.close()

    return jsonify(cafes)

@servico.get("/cafes/<int:ultimo_feed>/<int:tamanho_da_pagina>/<string:nome_do_cafe>")
def find_cafes(ultimo_feed, tamanho_da_pagina, nome_do_cafe):
    cafes = []

    conexao = get_conexao_com_bd()
    cursor = conexao.cursor(dictionary=True)
    cursor.execute(
        "select feeds.id as cafe_id, DATE_FORMAT(feeds.data, '%Y-%m-%d %H:%i') as data, " +
        "empresas.id as empresa_id, empresas.nome as nome_empresa, empresas.avatar, cafes.nome as nome_cafe, cafes.descricao, FORMAT(cafes.preco, 2) as preco, " +
        "cafes.url, cafes.imagem1, IFNULL(cafes.imagem2, '') as imagem2, IFNULL(cafes.imagem3, '') as imagem3 " +
        "FROM feeds, cafes, empresas " +
        "WHERE cafes.id = feeds.cafe " +
        "AND empresas.id = cafes.empresa " +
        "AND cafes.nome LIKE '%" + nome_do_cafe + "%' "  +
        "AND feeds.id > " + str(ultimo_feed) + " ORDER BY cafe_id ASC, data DESC " +
        "LIMIT " + str(tamanho_da_pagina)
    )
    cafes = cursor.fetchall()
    if cafes:
        for cafe in cafes:
            cafes["curtidas"] = get_quantidade_de_curtidas(cafe['cafe_id'])

    conexao.close()

    return jsonify(cafes)

@servico.get("/cafe/<int:feed>")
def find_cafe(feed):
    cafe = {}

    conexao = get_conexao_com_bd()
    cursor = conexao.cursor(dictionary=True)
    cursor.execute(
        "select feeds.id as cafe_id, DATE_FORMAT(feeds.data, '%Y-%m-%d %H:%i') as data, " +
        "empresas.id as empresa_id, empresas.nome as nome_empresa, empresas.avatar, cafes.nome as nome_cafe, cafes.descricao, FORMAT(cafes.preco, 2) as preco, " +
        "cafes.url, cafes.imagem1, IFNULL(cafes.imagem2, '') as imagem2, IFNULL(cafes.imagem3, '') as imagem3 " +
        "FROM feeds, cafes, empresas " +
        "WHERE cafes.id = feeds.cafe " +
        "AND empresas.id = cafes.empresa " +
        "AND feeds.id = " + str(feed)
    )
    cafe = cursor.fetchone()
    if cafe:
        cafe["curtidas"] = get_quantidade_de_curtidas(feed)

    conexao.close()

    return jsonify(cafe)


if __name__ == "__main__":
    servico.run(host="0.0.0.0", debug=True)