import 'dart:collection';

import 'package:f05_lugares_app/model/lugar.dart';
import 'package:flutter/material.dart';

class FavoritosModel with ChangeNotifier {
  final List<Lugar> _favoritos = [];

  UnmodifiableListView<Lugar> get favoritos => UnmodifiableListView(_favoritos);

  void add(Lugar lugar) {
    _favoritos.add(lugar);
    notifyListeners();
  }

  void remove(Lugar lugar) {
    _favoritos.removeWhere((item) => item.id == lugar.id);
    notifyListeners();
  }
}
