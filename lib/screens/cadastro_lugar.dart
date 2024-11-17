// screens/cadastro_lugar.dart
import 'package:f05_lugares_app/components/drawer.dart';
import 'package:f05_lugares_app/components/lugar_form.dart';
import 'package:f05_lugares_app/model/lugar.dart';
import 'package:f05_lugares_app/model/lugares_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CadastroLugarScreen extends StatefulWidget {
  const CadastroLugarScreen({super.key});

  @override
  State<CadastroLugarScreen> createState() => _CadastroLugarScreenState();
}

class _CadastroLugarScreenState extends State<CadastroLugarScreen> {
  @override
  Widget build(BuildContext context) {
    void salvarLugar(Lugar lugar) {
      context.read<LugaresModel>().add(lugar);
      Navigator.of(context).pushReplacementNamed('/');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Novo lugar adicionado!'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeData().primaryColor,
        title: Text(
          "Cadastrar Lugar",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: MeuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LugarForm(onSubmit: salvarLugar),
      ),
    );
  }
}
