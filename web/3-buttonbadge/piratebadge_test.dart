library piratebadge_test;

import 'package:unittest/unittest.dart';
import 'package:di/di.dart';
import 'package:angular/angular.dart';
import 'package:angular/mock/module.dart';
import 'piratebadge.dart' show PirateModule, BadgesController;

main() {
  setUp(setUpInjector);
  tearDown(tearDownInjector);

  group('pirate badge', () {
    setUp(module((Module m) => m.install(new PirateModule())));

    test('should load recipes', inject((BadgesController ctrl) {
      expect(ctrl.inputIsNotEmpty, isFalse);
      expect(ctrl.label, 'Aye! Gimme a name!');
    }));

    test('generating name', inject((BadgesController ctrl) {
      expect(ctrl.name, isEmpty);
      ctrl.generateName();
      expect(ctrl.name, 'Anne Bonney');
    }));
  });
}