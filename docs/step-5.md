## Step 5: Use a class as a model

In this step, you use define and use a model.

_**Keywords**: class_

### Update imports

First, add the following import to `piratebadge.dart`:

    ```Dart
    import 'dart:math' show Random;
    ```

### Create a PirateName class

Copy and paste the following code in `piratebadge.dart`:

    ```Dart
    class PirateName {
      String firstName, appellation;
      PirateName([this.firstName = '', this.appellation = '']);
    }
    ```

This is the model for this app.

### Update the controller

Add the following `const` lists inside `BadgesController`:

    ```Dart
    class BadgesController {
      // ...
      static const List names = const [
        'Anne', 'Mary', 'Jack', 'Morgan', 'Roger',
        'Bill', 'Ragnar', 'Ed', 'John', 'Jane' ];

      static const List appellations = const [
        'Black','Damned', 'Jackal', 'Red', 'Stalwart', 'Axe',
        'Young', 'Old', 'Angry', 'Brave', 'Crazy', 'Noble'];
      // ...
    }
    ```

We will write code in this step to generate pirate names by obtaining random
values in each list.

Add the following utility function that helps pick random names and
appellations:


    ```Dart
    class BadgesController {
      // ...
      String _oneRandom(List<String> list) {
        return list[new Random().nextInt(list.length)];
      }
      // ...
    }

Inside `BadgesController`, create a new model instance:

    ```Dart
    class BadgesController {
      // ...
      PirateName pn = new PirateName();
      // ...
    }
    ```

Define a `pirateName` field in the controller. This field gets the pirate's
complete name.  We pass this field as an argument to the component that we
created in step 4 later in this step.


    ```Dart
    class BadgesController {
        // ...
        String get pirateName => pn.firstName.isEmpty ? '' :
        '${pn.firstName} the ${pn.appellation}';
        // ...
    }
    ```

In step 4, we defined the following code:

    ```Dart
    String name = '';
    ```

Replace that line with the following code:


    ```Dart
    class BadgesController {
      // ...
      String _name = '';

      get name => _name;

      set name(newName) {
        _name = newName;
        pn..firstName = name
          ..appellation = _oneRandom(appellations);
      }
      // ...
    }
    ```

We've added a private `_name` field that we'll later bind into the UI, and
we've defined a getter and a setter to get and set its value. The
setter also sets the `firstName` and `appelation` fields of the
`PirateBadge` object.

Update `generateName()` to set the fields of the `PirateInstance` instance:

    ```Dart
    class BadgesController {
      // ...
      generateName() {
        var randomName = _oneRandom(names);
        name = randomName;
        pn..firstName = randomName
          ..appellation = _oneRandom(appellations);
      }
      // ...
    }
    ```
### Update data bindings

In `piratebadge.html`, update the data binding in the `badge` tag:

    ```HTML
    <badge name="{{ctrl.pirateName}}"
        style='float: left; margin-left: 20px;'></badge>
    ```

Now run your code. You should be able to enter text into the input box and see
a pirate name in the pirate badge. You should also be able to generate a
random pirate name by clicking on the button.

### Problems?
Check your code against the files in [5-classbadge](../web/5-classbadge).
- [piratebadge.html](../web/5-classbadge/piratebadge.html)
- [piratebadge.dart](../web/5-classbadge/piratebadge.dart)

## [Home](../README.md) | [< Previous](step-4.md) | [Next >](step-6.md)
