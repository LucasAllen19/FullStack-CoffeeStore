import 'package:coffeestore/apis/servicos.dart';
import 'package:coffeestore/estado.dart';
import 'package:flutter/material.dart';

class CardCafe extends StatefulWidget {
  final dynamic cafe;

  const CardCafe(this.cafe, {super.key});
  
  @override
  State<StatefulWidget> createState() {
    return CardCafeState();
  }
}

class CardCafeState extends State<CardCafe>{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Assumindo que estadoApp.mostrarDetalhes é um método válido
        estadoApp.mostrarDetalhes(widget.cafe["cafe_id"]);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  caminhoArquivo(widget.cafe["imagem1"]),
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.network(caminhoArquivo(widget.cafe["avatar"])),
                  ),
                  SizedBox(width: 10),
                  // Expanded(
                  //   child: Text(
                  //     cafe["company"]["name"],
                  //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                widget.cafe["nome_cafe"],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(
                widget.cafe["descricao"],
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 11
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "R\$ ${widget.cafe["preco"].toString()}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite_rounded,
                        color: Colors.red,
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Text(widget.cafe["curtidas"].toString()),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
