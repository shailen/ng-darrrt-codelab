// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library ng_dart_codelab.piratebadge;

import 'dart:math' show Random;
import 'package:angular/angular.dart';
import 'badge/badge_component.dart';

@MirrorsUsed(override:'*')
import 'dart:mirrors';

class PirateName {
  String firstName, appellation;

  PirateName(this.firstName, this.appellation);

  String get pirateName => firstName.isEmpty ? '' :
    '$firstName the $appellation';
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

  PirateName pn;

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
    var rand = new Random();
    var randomName = names[rand.nextInt(names.length)];
    name = randomName;
    pn = new PirateName(randomName,
        appellations[new Random().nextInt(appellations.length)]);
  }
}

void main() {
  ngBootstrap(module: new Module()
    ..type(BadgesController)
    ..type(BadgeComponent));
}
