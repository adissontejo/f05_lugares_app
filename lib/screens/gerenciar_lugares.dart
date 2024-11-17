import 'package:f05_lugares_app/components/drawer.dart';
import 'package:f05_lugares_app/components/lugar_form.dart';
import 'package:f05_lugares_app/model/lugares_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/lugar.dart';

class GerenciarLugaresScreen extends StatefulWidget {
  const GerenciarLugaresScreen({super.key});

  @override
  State<GerenciarLugaresScreen> createState() => _GerenciarLugaresScreenState();
}

class _GerenciarLugaresScreenState extends State<GerenciarLugaresScreen> {
  void _removerLugar(Lugar lugar) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmação'),
        content: const Text('Tem certeza que deseja remover este lugar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              context.read<LugaresModel>().remove(lugar);
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Lugar removido com sucesso!'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text('Remover'),
          ),
        ],
      ),
    );
  }

  void _editarLugar(Lugar lugar) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          top: 16,
          left: 16,
          right: 16,
        ),
        child: LugarForm(
          lugar: lugar,
          onSubmit: (novoLugar) {
            context.read<LugaresModel>().edit(novoLugar);
            Navigator.of(ctx).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Lugar atualizado com sucesso!'),
                backgroundColor: Colors.green,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lugares = context.watch<LugaresModel>().lugares;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeData().primaryColor,
        title: Text(
          "Gerenciar Lugares",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: MeuDrawer(),
      body: ListView.builder(
        itemCount: lugares.length,
        itemBuilder: (ctx, index) {
          final lugar = lugares[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(lugar.imagemUrl),
            ),
            title: Text(lugar.titulo),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _editarLugar(lugar),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removerLugar(lugar),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
