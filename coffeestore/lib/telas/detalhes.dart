import 'package:flat_list/flat_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_visibility_pro/keyboard_visibility_pro.dart';
import 'package:coffeestore/apis/servicos.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:coffeestore/estado.dart';
import '../estado.dart';

class Detalhes extends StatefulWidget {
  const Detalhes({super.key});

  @override
  State<StatefulWidget> createState() => DetalhesState();
}

// enum _EstadoCafe { naoVerificado, temCafe, semCafe }

const TAMANHO_DA_PAGINA = 5;

class DetalhesState extends State<Detalhes> {
  late PageController _controladorSlides;
  late int _slideSelecionado;

  bool _temCafe = false;
  dynamic _cafe;

  bool _temComentarios = false;
  List<dynamic> _comentarios = [];
  late TextEditingController _controladorNovoComentario;
  bool _carregandoComentarios = false;

  int _ultimoComentario = 0;

  bool _curtiu = false;
  bool _tecladoVisivel = false;

  late ServicoCafes _servicoCafes;
  late ServicoCurtidas _servicoCurtidas;
  late ServicoComentarios _servicoComentarios;

  @override
  void initState() {
    _iniciarSlides();

    _controladorNovoComentario = TextEditingController();

    _servicoCafes = ServicoCafes();
    _servicoCurtidas = ServicoCurtidas();
    _servicoComentarios = ServicoComentarios();

    _carregarCafe();
    _carregarComentarios();

    super.initState();
  }

  void _iniciarSlides() {
    _slideSelecionado = 0;
    _controladorSlides = PageController(initialPage: _slideSelecionado);
  }

  void _carregarCafe() {
    _servicoCafes.findCafe(estadoApp.idCafe).then((cafe) {
      _cafe = cafe;

      if (estadoApp.usuario != null) {
        _servicoCurtidas
            .curtiu(estadoApp.usuario!, estadoApp.idCafe)
            .then((curtiu) {
          setState(() {
            _temCafe = _cafe != null;
            _curtiu = curtiu;

            _carregandoComentarios = false;
          });
        });
      } else {
        setState(() {
          _temCafe = _cafe != null;
          _curtiu = false;

          _carregandoComentarios = false;
        });
      }
    });
  }

  void _carregarComentarios() {
    setState(() {
      _carregandoComentarios = true;
    });

    _servicoComentarios
        .getComentarios(
            estadoApp.idCafe, _ultimoComentario, TAMANHO_DA_PAGINA)
        .then((comentarios) {
      setState(() {
        _comentarios.addAll(comentarios);
        _temComentarios = _comentarios.isNotEmpty;
        _ultimoComentario = comentarios.isNotEmpty
            ? comentarios.last["comentario_id"]
            : _ultimoComentario;

        _carregandoComentarios = false;
      });
    });
  }

  Future<void> _atualizarComentarios() async {
    _comentarios = [];
    _ultimoComentario = 0;

    _carregarComentarios();
  }

  void _adicionarComentario() {
    _servicoComentarios
        .adicionar(estadoApp.idCafe, estadoApp.usuario!,
            _controladorNovoComentario.text)
        .then((resultado) {
      if (resultado["situacao"] == "ok") {
        Fluttertoast.showToast(msg: "comentário adicionado");

        _atualizarComentarios();
      }
    });
  }

  void _removerComentario(int idComentario) {
    _servicoComentarios.remover(idComentario).then((resultado) {
      if (resultado["situacao"] == "ok") {
        Fluttertoast.showToast(msg: "comentário removido com sucesso");

        _atualizarComentarios();
      }
    });
  }

  String _formatarData(String dataHora) {
    DateTime dateTime = DateTime.parse(dataHora);
    DateFormat formatador = DateFormat("dd/MM/yyyy HH:mm");

    return formatador.format(dateTime);
  }

  Widget _exibirMensagemComentariosInexistentes() {
    return const Center(
        child: Padding(
            padding: EdgeInsets.all(14.0),
            child: Text('não existem comentários sobre este café',
                style: TextStyle(color: Colors.black, fontSize: 14))));
  }


  List<Widget> _exibirComentarios() {
    return [
      const Center(
        child: Text(
          "Comentários",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        )
      ),
      estadoApp.temUsuarioLogado()
          ? Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                  controller: _controladorNovoComentario,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintStyle: const TextStyle(fontSize: 14),
                      hintText: 'Digite aqui seu comentário...',
                      suffixIcon: GestureDetector(
                          onTap: () {
                            _adicionarComentario();
                          },
                          child: const Icon(Icons.send)))))
          : const SizedBox.shrink(),
      _temComentarios
          ? Expanded(
              child: FlatList(
              data: _comentarios,
              loading: _carregandoComentarios,
              numColumns: 1,
              onRefresh: () {
                _controladorNovoComentario.clear();

                return _atualizarComentarios();
              },
              onEndReached: () {
                _carregarComentarios();
              },
              onEndReachedDelta: 200,
              buildItem: (item, int index) {
                bool usuarioLogadoComentou = estadoApp.temUsuarioLogado() &&
                    item["conta"] == estadoApp.usuario!.email;

                return Dismissible(
                    key: UniqueKey(),
                    direction: usuarioLogadoComentou
                        ? DismissDirection.endToStart
                        : DismissDirection.none,
                    background: Container(
                        color: Colors.red,
                        child: const Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: Icon(Icons.delete)))),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        showDialog(
                            context: context,
                            builder: (BuildContext contexto) {
                              return AlertDialog(
                                title: const Text("deseja apagar o comentário?",
                                    style: TextStyle(fontSize: 14)),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _carregarComentarios();
                                        });

                                        Navigator.of(contexto).pop();
                                      },
                                      child: const Text("não")),
                                  TextButton(
                                      onPressed: () {
                                        _removerComentario(
                                            item["comentario_id"]);

                                        Navigator.of(contexto).pop();
                                      },
                                      child: const Text("sim"))
                                ],
                              );
                            });
                      }
                    },
                    child: Card(
                        color: usuarioLogadoComentou
                            ? Colors.white
                            : Colors.black12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  item["comentario"],
                                  style: const TextStyle(fontSize: 12),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Row(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 6.0),
                                        child: Text(
                                          item["nome"],
                                          style: const TextStyle(fontSize: 12),
                                        )),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Text(
                                          _formatarData(item["data"]),
                                          style: const TextStyle(fontSize: 12),
                                        )),
                                  ],
                                )),
                          ],
                        )));
              },
              listEmptyWidget: Container(
                  alignment: Alignment.center,
                  child: const Text("Não existem cafés para exibir :(")),
            ))
          : _exibirMensagemComentariosInexistentes()
    ];
  }

  List<String> _imagensDoSlide() {
    List<String> imagens = [];

    imagens.add(_cafe["imagem1"]);
    if ((_cafe["imagem2"] as String).isNotEmpty) {
      imagens.add(_cafe["imagem2"]);
    }
    if ((_cafe["imagem3"] as String).isNotEmpty) {
      imagens.add(_cafe["imagem3"]);
    }

    return imagens;
  }

  Widget _exibirCafe() {
    List<Widget> widgets = [];
    final slides = _imagensDoSlide();

    if (!_tecladoVisivel) {
      widgets.addAll([
        SizedBox(
          height: 230,
          child: Stack(children: [
            PageView.builder(
              itemCount: slides.length,
              controller: _controladorSlides,
              onPageChanged: (slide) {
                setState(() {
                  _slideSelecionado = slide;
                });
              },
              itemBuilder: (context, pagePosition) {
                return Image.network(
                  caminhoArquivo(slides[pagePosition]),
                  fit: BoxFit.cover,
                );
              },
            ),
            Align(
                alignment: Alignment.topRight,
                child: Column(children: [
                  estadoApp.temUsuarioLogado()
                      ? IconButton(
                          onPressed: () {
                            if (_curtiu) {
                              _servicoCurtidas
                                  .descurtir(
                                      estadoApp.usuario!, estadoApp.idCafe)
                                  .then((resultado) {
                                if (resultado["situacao"] == "ok") {
                                  Fluttertoast.showToast(
                                      msg: "avaliação removida");

                                  setState(() {
                                    _carregarCafe();
                                  });
                                }
                              });
                            } else {
                              _servicoCurtidas
                                  .curtir(
                                      estadoApp.usuario!, estadoApp.idCafe)
                                  .then((resultado) {
                                if (resultado["situacao"] == "ok") {
                                  Fluttertoast.showToast(
                                      msg: "obrigado pela sua avaliação");

                                  setState(() {
                                    _carregarCafe();
                                  });
                                }
                              });
                            }
                          },
                          icon: Icon(
                              _curtiu ? Icons.favorite : Icons.favorite_border),
                          color: Colors.red,
                          iconSize: 32)
                      : const SizedBox.shrink(),
                  IconButton(
                      onPressed: () {
                        final texto =
                            '${_cafe["nome_cafe"]} por R\$ ${_cafe["preco"].toString()} disponível na Coffee Store.\n\n\nBaixe o app da Coffee Store na PlayStore!';
                        Share.share(texto);
                      },
                      icon: const Icon(Icons.share),
                      color: Colors.blue,
                      iconSize: 32)
                ]))
          ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: PageViewDotIndicator(
            currentItem: _slideSelecionado,
            count: slides.length,
            unselectedColor: Colors.black26,
            selectedColor: Colors.blue,
            duration: const Duration(milliseconds: 200),
            boxShape: BoxShape.circle,
          ),
        ),
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _temCafe
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(_cafe["descricao"],
                          style: const TextStyle(fontSize: 12)))
                  : const SizedBox.shrink(),
              _temCafe
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 6.0),
                      child: Row(children: [
                        Text(
                          "R\$ ${_cafe["preco"].toString()}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.favorite_rounded,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                  Text(
                                    _cafe["curtidas"].toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ]))
                      ]))
                  : const SizedBox.shrink(),
            ],
          ),
        )
      ]);
    }
    widgets.addAll(_exibirComentarios());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(children: [
          Row(children: [
            Image.network(caminhoArquivo(_cafe["avatar"]), width: 38),
            Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
                child: Text(
                  _cafe["nome_cafe"],
                  style: const TextStyle(fontSize: 15),
                ))
          ]),
          const Spacer(),
          GestureDetector(
            onTap: () {
              estadoApp.mostrarCafes();
            },
            child: const Icon(Icons.arrow_back, size: 30),
          )
        ]),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    );
  }

  Widget _exibirMensagemCafeInexistente() {
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: FloatingActionButton(
              onPressed: () {
                estadoApp.mostrarCafes();
              },
              child: const Icon(Icons.arrow_back))),
      const Material(
          color: Colors.transparent,
          child: Text('O café não existe ou foi removido :-(',
              style: TextStyle(color: Colors.black, fontSize: 14))),
    ])));
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibility(
        onChanged: (bool visivel) {
          setState(() {
            _tecladoVisivel = visivel;
          });
        },
        child: _temCafe
            ? _exibirCafe()
            : _exibirMensagemCafeInexistente());
  }
}
