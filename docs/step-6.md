## Step 6: Read from a JSON-encoded file

In this step, you change the `PirateName` and the `BadgesController` classes to
get the list of names and appellations from a JSON file.

_**Keywords**: HTTP Request, Dependency Injection_

### Create piratenames.json

Create a JSON-encoded file named `piratenames.json` with the following content.
Put the file alongside the `piratenames.dart` and `piratenames.html` files
you've been editing.

    ```JSON
    { "names": [ "Anne", "Bette", "Cate", "Dawn",
            "Elise", "Faye", "Ginger", "Harriot",
            "Izzy", "Jane", "Kaye", "Liz",
            "Maria", "Nell", "Olive", "Pat",
            "Queenie", "Rae", "Sal", "Tam",
            "Uma", "Violet", "Wilma", "Xana",
            "Yvonne", "Zelda",
            "Abe", "Billy", "Caleb", "Davie",
            "Eb", "Frank", "Gabe", "House",
            "Icarus", "Jack", "Kurt", "Larry",
            "Mike", "Nolan", "Oliver", "Pat",
            "Quib", "Roy", "Sal", "Tom",
            "Ube", "Val", "Walt", "Xavier",
            "Yvan", "Zeb"],
      "appellations": [ "Awesome", "Black", "Captain", "Damned",
            "Even", "Fighter", "Great", "Hearty",
            "Irate", "Jackal", "King", "Lord",
            "Mighty", "Noble", "Old", "Powerful",
            "Quick", "Red", "Stalwart", "Tank",
            "Ultimate", "Vicious", "Wily", "aXe",
            "Young", "Zealot",
            "Angry", "Brave", "Crazy", "Damned",
            "Eager", "Fool", "Greedy", "Hated",
            "Idiot", "Jinxed", "Kind", "Lame",
            "Maimed", "Naked", "Old", "Pale",
            "Queasy", "Rat", "Sandy", "Tired",
            "Ugly", "Vile", "Weak", "Xeric",
            "Yellow", "Zesty"]}
    ```
### Edit piratebadge.dart

Add this import to the top of the file.

    ```Dart
    import 'dart:async' show Future;
    ```

The dart:async library provides for asynchronous programming. A Future provides
a way to get a value in the future. For JavaScript developers:
Futures are similar to Promises.

In `PirateName` class, replace the `names` and `appelations` lists with these
static, empty lists:

    ```Dart
    class PirateName {
      // ...
      static List<String> names = [];
      static List<String> appellations = [];
      // ...
    }
    ```

In `BadgesController`, add a private `Http _http` field:

    ```Dart
    class BadgesController {
      // ...
      final Http _http;
      // ...
    }
    ```
The `Http` service facilitates communication with the remote HTTP servers.
Add a constructor to initialize `_http`:

    ```Dart
    class BadgesController {
      // ...
      BadgesController(this._http);
      // ...
    }
    ```
An instance of the `Http` service is automatically injected by Angular.

Add a private function `_loadData`:

    ```Dart
    class BadgesController {
      // ...
      Future _loadData() {
        return _http.get('piratenames.json').then((HttpResponse response) {
          names = response.data['names'];
          appellations = response.data['appellations'];
      });
      // ...
    }
    ```

Here are some things to note about `_loadData`:

* The `get` method is used to make Http GET requests.
* The code uses a Future to perform the GET asynchronously.
* The callback function for `then()` executes when the Future completes
successfully, and the pirate names and appelations are read from the
response  data.

In the `BadgesController` constructor, define a `dataLoaded` boolean and set
it to `false`. When `_loadData()` reads the JSON content, `dataLoaded` becomes
`true`:

    ```Dart
    class BadgesController {
      // ...
      bool dataLoaded = false;

      BadgesController(this._http) {
        _loadData()
            .then((_) => dataLoaded = true)
            .catchError((error) {
              print('Could not read data from the JSON file: $error');
            });
      }
      // ...
    ```

If the Future encounters an error, the `catchError()` method handles it.
Chaining `then()` and `catchError()` when getting the value of Future is a
common pattern in Dart asynchronous programming.


### Edit piratebadge.html

Disable `inputName` and the `button` by default, and enable them only when
the JSON data is loaded:

    ```HTML
    ...
      <div>
        <input type="text" id="inputName" maxlength="15" ng-model="ctrl.name" ng-disabled="!ctrl.dataLoaded">
      </div>
      <div>
        <button ng-click="ctrl.generateName()" ng-disabled="!ctrl.dataLoaded || ctrl.inputIsNotEmpty">{{ctrl.label}}</button>
      </div>
    ...
    ```

If the expression in `ng-disabled` is truthy, then special attribute
"disabled" is set on the element. When `ctrl.dataLoaded` is false, the input
and button elements are disabled.

### Learn more about
 - [Introducing the Http service](https://github.com/angular/angular.dart.tutorial/wiki/Introducing-filters-and-services)

### Problems?
Check your code against the files in [6-piratebadge_json](../web/6-piratebadge_json).
- [piratebadge.html](../web/6-piratebadge_json/piratebadge.html)
- [piratebadge.dart](../web/6-piratebadge_json/piratebadge.dart)

## [Home](../README.md) | [< Previous](step-5.md) | [Next >](step-7.md)
