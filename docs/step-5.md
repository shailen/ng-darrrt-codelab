## Step 5: Use a class as a model


In this step, you use define and use a model.

_**Keywords**: class_

### Create a PirateName class

 Copy and paste the following code in `piratebadge.dart`:

    ```Dart
    import 'dart:math' show Random;

    class PirateName {
      String firstName, appellation;

      PirateName(this.firstName, this.appellation);

      String get pirateName => firstName.isEmpty ? '' :
        '$firstName the $appellation';
    }
    ```

### Update the controller

In `piratebadge.dart`, add a new private field `PirateName pn` in
`BadgesController`:

    ```Dart
    class BadgesController {
      // ...
      PirateName pn;
      // ...
    }
    ```

Add  a private `_name` field that we'll later bind into the UI:

    ```Dart
    class BadgesController {
      // ...
      String _name = '';
      // ...
    ```

Define a getter and a setter to get and set the value of `_name`. The
setter not only sets the value of `_name`, it also sets the `firstName` and
`appelation` fields of the `PirateBadge` object:

    ```Dart
    class BadgesController {
      // ...
      get name => _name;

      set name(newName) {
        _name = newName;
        pn = new PirateName(name,
            appellations[new Random().nextInt(appellations.length)]);
      }

    ```

Update `generateName()` method to create a new `PirateName` instance.

    ```Dart
    class BadgesController {
      // ...
      generateName() {
        var rand = new Random();
        var randomName = names[rand.nextInt(names.length)];
        name = randomName;
        pn = new PirateName(randomName,
            appellations[new Random().nextInt(appellations.length)]);
      }
      // ...
    }
    ```
### Update data bindings

In `piratebadge.html`, update the data binding in the `badge` tag

    ```HTML
    <badge name="{{ctrl.pn.pirateName}}"
        style='float: left; margin-left: 20px;'></badge>
    ```

### Problems?
Check your code against the files in [5-classbadge](../web/5-classbadge).
- [piratebadge.html](../web/5-classbadge/piratebadge.html)
- [piratebadge.dart](../web/5-classbadge/piratebadge.dart)

## [Home](../README.md) | [< Previous](step-4.md) | [Next >](step-6.md)
