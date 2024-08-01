import 'package:coffeestore/componentes/cafecard.dart';
import 'package:flat_list/flat_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:coffeestore/apis/servicos.dart';
import 'package:coffeestore/autenticador.dart';
import 'package:coffeestore/estado.dart';

class Cafes extends StatefulWidget {
  const Cafes({super.key});

  @override
  State<StatefulWidget> createState() => CafesState(); 
}

const TAMANHO_DA_PAGINA = 4;

class CafesState extends State<Cafes> {
  List<dynamic> _cafes = [];
  
  String _filtro = "";
  late TextEditingController _controladorFiltro;

  bool _carregando = false;
  int _ultimoCafe = 0;

  late ServicoCafes _servicoCafes;

  @override
  void initState() {
    _controladorFiltro = TextEditingController();
    _recuperarUsuarioLogado();

    _servicoCafes = ServicoCafes();
    _carregarCafes();

    super.initState();
  }

  void _recuperarUsuarioLogado() {
    Autenticador.recuperarUsuario().then((usuario) {
      if (usuario != null) {
        setState(() {
          estadoApp.onLogin(usuario);
        });
      }
    });
  }

  void _carregarCafes() {
    setState(() {
      _carregando = true;
    });

    if (_filtro.isNotEmpty) {
      _servicoCafes
          .findCafes(_ultimoCafe, TAMANHO_DA_PAGINA, _filtro)
          .then((cafes) {
        setState(() {
          _carregando = false;
          _ultimoCafe = cafes.isNotEmpty
              ? cafes.last["cafe_id"]
              : _ultimoCafe;

          _cafes.addAll(cafes);
        });
      });
    } else {
      _servicoCafes
          .getCafes(_ultimoCafe, TAMANHO_DA_PAGINA)
          .then((cafes) {
        setState(() {
          _carregando = false;
          _ultimoCafe = cafes.isNotEmpty
              ? cafes.last["cafe_id"]
              : _ultimoCafe;

          _cafes.addAll(cafes);
        });
      });
    }
  }

  Future<void> _atualizarCafes() async {
    _cafes = [];
    _ultimoCafe = 0;

    _carregarCafes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const SizedBox.shrink(),
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _controladorFiltro,
                onSubmitted: (texto) {
                  _filtro = texto;
                  _atualizarCafes();
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search)
                )
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: estadoApp.temUsuarioLogado()
            ? GestureDetector(
              onTap: () {
                Autenticador.logout().then((_) {
                  Fluttertoast.showToast(
                      msg: "você não está mais conectado");

                  setState(() {
                    estadoApp.onLogout();
                  });
                });
              },
              child: const Icon(Icons.logout, size: 30)
            )
            : GestureDetector(
                onTap: () {
                  Autenticador.login().then((usuario) {
                    Fluttertoast.showToast(
                        msg: "você foi conectado com sucesso");

                    setState(() {
                      estadoApp.onLogin(usuario);
                    });
                  });
                },
                child: const Icon(Icons.person, size: 30)
              )
          )
        ],
      ),
      body: FlatList(
        data: _cafes,
        loading: _carregando,
        numColumns: 2,
        onRefresh: () {
          _filtro = "";
          _controladorFiltro.clear();

          return _atualizarCafes();
        },
        onEndReached: () {
          _carregarCafes();
        },
        onEndReachedDelta: 100,
        buildItem: (item, int index) {
          print(item);
          return SizedBox(height: 400, child: CardCafe(item));
        },
      )
    );
  }
}
