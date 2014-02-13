library ng_dart_codelab.names_service;

import 'package:angular/angular.dart';
import 'dart:async';
import 'dart:math';

@NgInjectableService()
class NamesService {
  static final Random rand = new Random();
  final Http _http;
  List<String> names;
  List<String> appellations;

  NamesService(this._http);

  Future _load() {
    if (names != null) return new Future.value(true);
    return _http.get('piratenames.json').then((HttpResponse response) {
      names = response.data['names'];
      appellations = response.data['appellations'];
    });
  }

  Future<String> randomName() {
    return _load().then((_) => _oneRandom(names));
  }

  Future<String> randomAppellation() {
    return _load().then((_) => _oneRandom(appellations));
  }

  String _oneRandom(List<String> list) => list[rand.nextInt(list.length)];
}