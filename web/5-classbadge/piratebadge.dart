// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library ng_dart_codelab.piratebadge;

import 'package:angular/angular.dart';
import 'badge/badge_component.dart';

@MirrorsUsed(override:'*')
import 'dart:mirrors';

import 'dart:math' show Random;

class PirateName {
  String firstName, appellation;
  PirateName([this.firstName = '', this.appellation = '']);
}

@NgController(
    selector: '[badges]',
    publishAs: 'ctrl')
class BadgesController {
  static const List names = const [
    'Anne', 'Mary', 'Jack', 'Morgan', 'Roger',
    'Bill', 'Ragnar', 'Ed', 'John', 'Jane' ];

  static const List appellations = const [
    'Black','Damned', 'Jackal', 'Red', 'Stalwart', 'Axe',
    'Young', 'Old', 'Angry', 'Brave', 'Crazy', 'Noble'];

  PirateName pn = new PirateName();

  String get pirateName => pn.firstName.isEmpty ? '' :
    '${pn.firstName} the ${pn.appellation}';

  String _name = '';

  get name => _name;

  set name(newName) {
    _name = newName;
    pn..firstName = name
      ..appellation = _oneRandom(appellations);
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
