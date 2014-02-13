// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library ng_dart_codelab.piratebadge;

import 'package:angular/angular.dart';
import 'badge/badge_component.dart';

@MirrorsUsed(override:'*')
import 'dart:mirrors';

// 1) add a model
import 'dart:math' show Random;

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

  // 3) define some data
  static const List names = const [
    'Anne', 'Mary', 'Jack', 'Morgan', 'Roger',
    'Bill', 'Ragnar', 'Ed', 'John', 'Jane' ];

  static const List appellations = const [
    'Black','Damned', 'Jackal', 'Red', 'Stalwart', 'Axe',
    'Young', 'Old', 'Angry', 'Brave', 'Crazy', 'Noble'];

  // 2) Create a variable for the model data.
  PirateName pn;


  // 4) Create a variable that binds to the UI and helps us set the
  // firstName and the appellation for the pirate.
  // This is a common pattern. Define a private variable and implement
  // a getter and a setter to get and set the value of that variable.
  String _name = '';

  get name => _name;

  // 4) The setter not only sets the value of _name, it also set the
  // firstName and appelation fields of the PirateBadge object. The
  //
  set name(newName) {
    _name = newName;
    pn = new PirateName(name,
        appellations[new Random().nextInt(appellations.length)]);
  }

  bool get inputIsNotEmpty => name.trim().isNotEmpty;

  String get label => inputIsNotEmpty ? "Arrr! Write yer name!" :
    "Aye! Gimme a name!";


  // 5) Finally, implement code to generate a pirate name with a randomly
  // chosen firstName and appellation.
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
