import 'dart:math';
import 'package:f05_lugares_app/components/multi_select.dart';
import 'package:f05_lugares_app/model/pais.dart';
import 'package:f05_lugares_app/model/paises_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/lugar.dart';

class LugarForm extends StatefulWidget {
  final Function(Lugar) onSubmit;
  final Lugar? lugar;

  const LugarForm({
    super.key,
    required this.onSubmit,
    this.lugar,
  });

  @override
  State<LugarForm> createState() => _LugarFormState();
}

class _LugarFormState extends State<LugarForm> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _imagemUrlController = TextEditingController();
  final TextEditingController _avaliacaoController = TextEditingController();
  final TextEditingController _custoMedioController = TextEditingController();

  List<String> _paises = [];
  List<String> _recomendacoes = [];

  @override
  void initState() {
    super.initState();
    if (widget.lugar != null) {
      final lugar = widget.lugar!;
      _tituloController.text = lugar.titulo;
      _imagemUrlController.text = lugar.imagemUrl;
      _avaliacaoController.text = lugar.avaliacao.toString();
      _custoMedioController.text = lugar.custoMedio.toString();
      _paises = List.from(lugar.paises);
      _recomendacoes = List.from(lugar.recomendacoes);
    }
  }

  void _submitForm() {
    if (_tituloController.text.isEmpty) {
      _mostrarErro('Preencha o título.');
    } else if (_imagemUrlController.text.isEmpty) {
      _mostrarErro("Preencha a URL da imagem.");
    } else if (_avaliacaoController.text.isEmpty) {
      _mostrarErro("Preencha a avaliação.");
    } else if (_custoMedioController.text.isEmpty) {
      _mostrarErro("Preencha o custo médio.");
    } else if (_paises.isEmpty) {
      _mostrarErro("Selecione um ou mais países.");
    } else {
      final titulo = _tituloController.text;
      final imagemUrl = _imagemUrlController.text;
      final avaliacao = double.tryParse(_avaliacaoController.text) ?? 0.0;
      final custoMedio = double.tryParse(_custoMedioController.text) ?? 0.0;

      if (avaliacao < 0 || avaliacao > 5) {
        _mostrarErro("Valor inválido para avaliação.");

        return;
      }

      widget.onSubmit(
        Lugar(
          id: widget.lugar?.id ?? Random().nextInt(10000).toString(),
          titulo: titulo,
          imagemUrl: imagemUrl,
          avaliacao: avaliacao,
          custoMedio: custoMedio,
          paises: _paises,
          recomendacoes: _recomendacoes,
        ),
      );
    }
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
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: _tituloController,
            decoration: InputDecoration(labelText: 'Título'),
          ),
          TextField(
            controller: _imagemUrlController,
            decoration: InputDecoration(labelText: 'URL da Imagem'),
          ),
          TextField(
            controller: _avaliacaoController,
            decoration: InputDecoration(labelText: 'Avaliação (0.0 a 5.0)'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _custoMedioController,
            decoration: InputDecoration(labelText: 'Custo Médio (em \$)'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          _buildPaises(context),
          const SizedBox(height: 16),
          _buildRecomendacoesList(),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text(widget.lugar != null ? 'Salvar' : 'Adicionar'),
          ),
        ],
      ),
    );
  }

  Widget _buildPaises(BuildContext context) {
    final paises = context.watch<PaisesModel>().paises;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Países:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0,
              children: _paises
                  .where(
                      (id) => paises.where((pais) => pais.id == id).isNotEmpty)
                  .map((id) {
                Pais pais = paises.firstWhere((item) => item.id == id);

                return Chip(
                  label: Text(pais.titulo),
                  onDeleted: () {
                    setState(() {
                      _paises.remove(pais.id);
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
        TextButton(
          onPressed: () async {
            final selecionados = await showDialog<List<String>>(
              context: context,
              builder: (_) => MultiSelect(
                items: context
                    .watch<PaisesModel>()
                    .paises
                    .map((pais) =>
                        MultiSelectItem(value: pais.id, label: pais.titulo))
                    .toList(),
                selectedItems: _paises,
              ),
            );
            if (selecionados != null) {
              setState(() {
                _paises = selecionados;
              });
            }
          },
          child: const Text('Selecionar Países'),
        ),
      ],
    );
  }

  Widget _buildRecomendacoesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recomendações:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Column(
          children: _recomendacoes
              .asMap()
              .entries
              .map((entry) => ListTile(
                    key: ValueKey(entry.key),
                    title: Text(entry.value),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _recomendacoes.removeAt(entry.key);
                        });
                      },
                    ),
                  ))
              .toList(),
        ),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Nova recomendação',
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              setState(() {
                _recomendacoes.add(value);
              });
            }
          },
        ),
      ],
    );
  }
}
