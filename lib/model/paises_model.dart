import 'dart:collection';

import 'package:f05_lugares_app/model/pais.dart';
import 'package:flutter/material.dart';

class PaisesModel extends ChangeNotifier {
  final List<Pais> _paises = [
    Pais(
      id: 'c1',
      titulo: 'Estados Unidos',
      cor: Colors.purple,
    ),
    Pais(
      id: 'c2',
      titulo: 'Canada',
      cor: Colors.red,
    ),
    Pais(
      id: 'c3',
      titulo: 'Suiça',
      cor: Colors.orange,
    ),
    Pais(
      id: 'c4',
      titulo: 'Chile',
      cor: Colors.amber,
    ),
    Pais(
      id: 'c5',
      titulo: 'Espanha',
      cor: Colors.amber,
    ),
    Pais(
      id: 'c6',
      titulo: 'Peru',
      cor: Colors.lightBlue,
    ),
    Pais(
      id: 'c7',
      titulo: 'Brasil',
      cor: Colors.lightGreen,
    ),
    Pais(
      id: 'c8',
      titulo: 'Egito',
      cor: Colors.teal,
    ),
  ];

  UnmodifiableListView<Pais> get paises => UnmodifiableListView(_paises);

  void add(Pais pais) {
    _paises.add(pais);
    notifyListeners();
  }

  void remove(Pais pais) {
    _paises.removeWhere((item) => item.id == pais.id);
    notifyListeners();
  }

  void edit(Pais pais) {
    int index = _paises.indexWhere((item) => item.id == pais.id);

    _paises[index] = pais;

    notifyListeners();
  }
}
