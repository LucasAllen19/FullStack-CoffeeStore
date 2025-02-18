from flask import Flask, jsonify
import mysql.connector as mysql

servico = Flask("comentarios")

SERVIDOR_BANCO = "banco"
USUARIO_BANCO = "root"
SENHA_BANCO = "admin"
NOME_BANCO = "coffeestore"

def get_conexao_com_bd():
    conexao = mysql.connect(host=SERVIDOR_BANCO, user=USUARIO_BANCO, password=SENHA_BANCO, database=NOME_BANCO)

    return conexao

@servico.get("/info")
def get_info():
    return jsonify(
        descricao = "gerenciamento de comentarios da coffeestore",
        versao = "1.0"
    )

@servico.get("/comentarios/<int:feed>/<int:ultimo_comentario>/<int:tamanho_pagina>")
def get_comentarios(feed, ultimo_comentario, tamanho_pagina):
    comentarios = []

    conexao = get_conexao_com_bd()
    cursor = conexao.cursor(dictionary=True)
    cursor.execute("SELECT id as comentario_id, feed as cafe_id, comentario, nome, conta, DATE_FORMAT(data, '%Y-%m-%d %H:%i') as data " +
                   "FROM comentarios " +
                   "WHERE feed = " + str(feed) + " AND id > " + str(ultimo_comentario) + " ORDER BY comentario_id ASC, data DESC " +
                   "LIMIT " + str(tamanho_pagina))
    comentarios = cursor.fetchall()
    conexao.close()

    return jsonify(comentarios)


@servico.post("/adicionar/<int:id_do_feed>/<string:nome>/<string:conta>/<string:comentario>")
def add_comentario(id_do_feed, nome, conta, comentario):
    resultado = jsonify(situacao = "ok", erro = "")

    conexao = get_conexao_com_bd()
    cursor = conexao.cursor()
    try:
        cursor.execute(
            f"INSERT INTO comentarios(feed, nome, conta, comentario, data) VALUES({id_do_feed}, '{nome}', '{conta}', '{comentario}', NOW())")
        conexao.commit()
    except:
        conexao.rollback()
        resultado = jsonify(situacao = "erro", erro = "erro adicionando comentário")

    conexao.close()

    return resultado


@servico.delete("/remover/<int:comentario_id>")
def remover_comentario(comentario_id):
    resultado = jsonify(situacao = "ok", erro = "")

    conexao = get_conexao_com_bd()
    cursor = conexao.cursor()
    try:
        cursor.execute(
            f"DELETE FROM comentarios WHERE id = {comentario_id}")
        conexao.commit()
    except:
        conexao.rollback()
        resultado = jsonify(situacao = "erro", erro = "erro removendo o comentário")

    conexao.close()

    return resultado


if __name__ == "__main__":
    servico.run(host="0.0.0.0", debug=True)