import 'dart:math';

import 'package:f05_lugares_app/model/pais.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class PaisForm extends StatefulWidget {
  final Pais? pais;
  final void Function(Pais) onSubmit;

  PaisForm({super.key, this.pais, required this.onSubmit});

  @override
  State<StatefulWidget> createState() => _PaisFormState();
}

class _PaisFormState extends State<PaisForm> {
  late Color _cor;
  late final TextEditingController _tituloController;

  @override
  void initState() {
    super.initState();
    _cor = widget.pais?.cor ?? Colors.blue;
    _tituloController = TextEditingController(text: widget.pais?.titulo);
  }

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16,
        left: 16,
        right: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _tituloController,
            decoration: const InputDecoration(labelText: 'Nome do País'),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Cor:'),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () async {
                  final corEscolhida = await showDialog<Color>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Escolha uma cor'),
                      content: SingleChildScrollView(
                        child: BlockPicker(
                          pickerColor: _cor,
                          onColorChanged: (cor) {
                            Navigator.of(ctx).pop(cor);
                          },
                        ),
                      ),
                    ),
                  );
                  if (corEscolhida != null) {
                    setState(() {
                      _cor = corEscolhida;
                    });
                  }
                },
                child: CircleAvatar(
                  backgroundColor: _cor,
                  radius: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final titulo = _tituloController.text;
              if (titulo.isEmpty) {
                _mostrarErro("Preencha o título.");
                return;
              }
              widget.onSubmit(
                Pais(
                  id: widget.pais?.id ?? Random().nextInt(10000).toString(),
                  titulo: titulo,
                  cor: _cor,
                ),
              );
            },
            child: Text(widget.pais == null ? 'Adicionar' : 'Salvar'),
          ),
        ],
      ),
    );
  }
}
