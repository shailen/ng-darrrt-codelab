// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library ng_dart_codelab.piratebadge;

import 'service/names_service.dart';
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
  NamesService ns;

  PirateName pn = new PirateName();

  String get pirateName => pn.firstName.isEmpty ? '' :
    '${pn.firstName} the ${pn.appellation}';

  BadgesController(this.ns);

  String _name = '';

  get name => _name;

  set name(newName) {
    _name = newName;
    ns.randomAppellation().then((appellation) {
      pn..firstName = newName
        ..appellation = appellation;
    });
  }

  bool get inputIsNotEmpty => name.trim().isNotEmpty;

  String get label => inputIsNotEmpty ? "Arrr! Write yer name!" :
    "Aye! Gimme a name!";

  generateName() {
    return ns.randomAppellation()
        .then((_appellation) => pn.appellation = _appellation)
        .then((_) => ns.randomName())
        .then((_name) {
          pn.firstName = _name;
          name = pn.firstName;
        });
  }
}

void main() {
  ngBootstrap(module: new Module()
    ..type(BadgesController)
    ..type(NamesService)
    ..type(BadgeComponent));
}
