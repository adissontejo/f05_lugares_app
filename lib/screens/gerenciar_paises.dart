import 'package:f05_lugares_app/components/drawer.dart';
import 'package:f05_lugares_app/components/pais_form.dart';
import 'package:f05_lugares_app/model/paises_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GerenciarPaisesScreen extends StatelessWidget {
  const GerenciarPaisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final paises = context.watch<PaisesModel>().paises;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeData().primaryColor,
        title: Text(
          "Gerenciar Países",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: MeuDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => PaisForm(
              onSubmit: (pais) {
                context.read<PaisesModel>().add(pais);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('País criado com sucesso!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: paises.length,
        itemBuilder: (ctx, index) {
          final pais = paises[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: pais.cor,
              child: Text(
                pais.titulo[0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(pais.titulo),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => PaisForm(
                        pais: pais,
                        onSubmit: (pais) {
                          print(pais.id);
                          context.read<PaisesModel>().edit(pais);
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('País atualizado com sucesso!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Confirmação'),
                        content: const Text(
                            'Tem certeza que deseja remover este país?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<PaisesModel>().remove(pais);
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('País removido com sucesso!'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            },
                            child: const Text('Remover'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
