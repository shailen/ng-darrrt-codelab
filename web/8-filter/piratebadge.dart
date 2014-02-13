// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library ng_dart_codelab.piratebadge;

import 'service/names_service.dart';
import 'package:angular/angular.dart';
import 'badge/badge_component.dart';
import 'filter/capitalize_filter.dart';

@MirrorsUsed(override:'*')
import 'dart:mirrors';

class PirateName {
  String firstName, appellation;

  PirateName([this.firstName = '', this.appellation = '']);

  String get pirateName => firstName.isEmpty ? '' :
    '$firstName the $appellation';
}

@NgController(
    selector: '[badges]',
    publishAs: 'ctrl')
class BadgesController {
  NamesService ns; // Added.

  bool dataLoaded = false;

  BadgesController(this.ns);

  PirateName pn;

  String _name = '';

  get name => _name;

  set name(newName) {
    _name = newName;
    ns.randomAppellation().then((appellation) {
      pn = new PirateName(name, appellation);
    });
  }

  bool get inputIsNotEmpty => name.trim().isNotEmpty;

  String get label => inputIsNotEmpty ? "Arrr! Write yer name!" :
    "Aye! Gimme a name!";

  generateName() {
    pn = new PirateName();
    return ns.randomAppellation()
        .then((appellation) => pn.appellation = appellation)
        .then((_) => ns.randomName())
        .then((name) => pn.firstName = name);
  }
}

void main() {
  ngBootstrap(module: new Module()
    ..type(BadgesController)
    ..type(NamesService)
    ..type(CapitalizeFilter)
    ..type(BadgeComponent));
}
