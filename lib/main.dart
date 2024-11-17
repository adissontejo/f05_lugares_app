import 'package:f05_lugares_app/model/favoritos_model.dart';
import 'package:f05_lugares_app/model/lugares_model.dart';
import 'package:f05_lugares_app/model/paises_model.dart';
import 'package:f05_lugares_app/screens/abas.dart';
import 'package:f05_lugares_app/screens/cadastro_lugar.dart';
import 'package:f05_lugares_app/screens/configuracoes.dart';
import 'package:f05_lugares_app/screens/detalhes_lugar.dart';
import 'package:f05_lugares_app/screens/gerenciar_lugares.dart';
import 'package:f05_lugares_app/screens/gerenciar_paises.dart';
import 'package:f05_lugares_app/screens/lugares_por_pais.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PaisesModel(),
      child: ChangeNotifierProvider(
        create: (context) => LugaresModel(),
        child: ChangeNotifierProvider(
          create: (context) => FavoritosModel(),
          child: const MeuApp(),
        ),
      ),
    ),
  );
}

class MeuApp extends StatefulWidget {
  const MeuApp({super.key});

  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (ctx) => MinhasAbas(),
        '/lugaresPorPais': (ctx) => LugarPorPaisScreen(),
        '/detalheLugar': (ctx) => DetalhesLugarScreen(),
        '/configuracoes': (ctx) => ConfigracoesScreen(),
        '/cadastroLugar': (ctx) => CadastroLugarScreen(),
        '/gerenciarLugares': (ctx) => GerenciarLugaresScreen(),
        '/gerenciarPaises': (ctx) => GerenciarPaisesScreen(),
      },
    );

    /* return MaterialApp.router(
      routerConfig: minhasRotas.getRouter(),
    ); */
  }
}
