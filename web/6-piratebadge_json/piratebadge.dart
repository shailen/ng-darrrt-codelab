// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library ng_dart_codelab.piratebadge;

import 'dart:async' show Future;
import 'dart:math' show Random;
import 'package:angular/angular.dart';
import 'badge/badge_component.dart';

@MirrorsUsed(override:'*')
import 'dart:mirrors';

class PirateName {
  String firstName, appellation;
  PirateName([this.firstName = '', this.appellation = '']);
}

@NgController(
    selector: '[badges]',
    publishAs: 'ctrl')
class BadgesController {
  static List<String> names = [];
  static List<String> appellations = [];

  final Http _http;
  bool dataLoaded = false;

  PirateName pn = new PirateName();

  String get pirateName => pn.firstName.isEmpty ? '' :
    '${pn.firstName} the ${pn.appellation}';

  BadgesController(this._http) {
    _loadData().then((_) {
      dataLoaded = true;
    }, onError: (_) {
      dataLoaded = false;
    });
  }

  Future _loadData() {
    return _http.get('piratenames.json').then((HttpResponse response) {
      names = response.data['names'];
      appellations = response.data['appellations'];
    });
  }

  String _name = '';

  get name => _name;

  set name(newName) {
    _name = newName;
    pn = new PirateName(name,
        appellations[new Random().nextInt(appellations.length)]);
  }

  bool get inputIsNotEmpty => name.trim().isNotEmpty;

  String get label => inputIsNotEmpty ? "Arrr! Write yer name!" :
    "Aye! Gimme a name!";

  generateName() {
    var randomName = _oneRandom(names);
    name = randomName;
    pn..firstName = randomName
      ..appellation = _oneRandom(appellations);
  }

  String _oneRandom(List<String> list) => list[new Random().nextInt(list.length)];
}

void main() {
  ngBootstrap(module: new Module()
    ..type(BadgesController)
    ..type(BadgeComponent));
}
