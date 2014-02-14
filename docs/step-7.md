## Step 7: Use a service to get data

This step converts Step 6's example to use a service
(NamesService) to load and provide names.

_**Keywords**: service_

### Create a service

In Step 4, we hard coded data in our controller. In Step 5, we added
functionality to read the data from a JSON file. In this step, we move all
aspects of fetching a pirate name out of the controller and into a service.
This creates a clean separation of logic in our app: the model defines the
shape of our data, the service provides the actual data, and the controller is
the glue that keeps everything together.

In the location that you created the `badge/` directory in Step 4, create a
new directory and call it `service`. In this directory, create a new file,
`names_service.dart`, and copy the following content to it:

    ```Dart
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

      Future _loadData() {
        if (names != null) return new Future.value(true);
        return _http.get('piratenames.json')
          .then((HttpResponse response) {
            names = response.data['names'];
            appellations = response.data['appellations'];
          })
          .catchError((error) {
            print('Could not read data from the JSON file: $error');
          });
      }

      Future<String> randomName() {
        return _loadData().then((_) => _oneRandom(names));
      }

      Future<String> randomAppellation() {
        return _loadData().then((_) => _oneRandom(appellations));
      }

      String _oneRandom(List<String> list) => list[rand.nextInt(list.length)];
    }
    ```

We create a `NamesService` class and move much of the Step 6 controller logic into this class:


* You've moved the `names` and `appellations` lists in here
* You've copied over the _oneRandom()` method over verbatim, and you've
defined the `randomName()` and `randomAppellation()` helper methods to fetch
random data.

The `_loadData()` method introduces an optimization: it checks if the `names` list has already been populated and fetches data only if it hasn't. As a result, you can call the  `randomName()` and `randomAppellation()` methods without
loading up the JSON data every time.

Note the `@NgInjectableService` annotation for the `NamesService` class? This
annotation when applied to a class indicates that the class will be
instantiated by Angular's dependency injector.


### Use the service

Open `piratebadge.dart`.

Add the following import statement along with the other import statements at
the top:


    ```Dart
    library ng_dart_codelab.piratebadge;
    // ...
    import 'service/names_service.dart';
    ```

Add a `NamesService` instance to `BadgesController`:

    ```Dart
    class BadgesController {
      NamesService ns;
      // ...
    }
    ```

Add the `NamesService` type to `ngBootstrap()` to instantiate it using the
dependency injector. Your `main()` now looks like this:

    ```Dart
    void main() {
      ngBootstrap(module: new Module()
        ..type(BadgesController)
        ..type(NamesService)
        ..type(BadgeComponent));
    }
    ```

### Clean up the controller

Much of the Step 6 controller logic relating to fetching data can now be
stripped away. Replace your controller from the previous step with this
version:

    ```Dart
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
    ```

You've changed both the `name` setter and the `generateName()` method to use
`NamesService`. The controller now has no knowledge of how the data is
generated, but can request it from the service when needed.

Save your changes and run your app. You'll see that it functions exactly as
before.


### Problems?
Check your code against the files in [6-service](../web/6-service).
- [piratebadge.html](../web/7-service/piratebadge.html)
- [piratebadge.dart](../web/7-service/piratebadge.dart)
- [piratebadge.json](../web/7-service/piratenames.json)
- [names_service.dart](../web/7-service/service/names_service.dart)

## [Home](../README.md) | [< Previous](step-6.md) | [Next >](step-8.md)


