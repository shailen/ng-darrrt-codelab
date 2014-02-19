## Step 3: Add a button and controller

In this step you add a button and a controller that coordinates the button, label, and badge.

_**Keywords**: controller, module, click event_

### Edit piratebadge.dart.

<b>&rarr; Create an empty class named `BadgesController`, and give it a `name` property.</b>

<pre><b>class BadgesController {
  String name = '';
  BadgesController();
}</b></pre>
    
<b>&rarr; Add an `NgController` annotation to the class.</b>

<pre><b>@NgController(
  selector: '[badges]',
  publishAs: 'ctrl')</b>
class BadgesController {   
</pre>

Key information:
- The NgController annotation tells Angular that BadgesController is an Angular controller.
- The required `selector` argument defines the CSS selector that triggers the controller.
  It can be any valid CSS selector that does not cross element boundaries.
- The `publishAs` argument specifies that the controller instance should be assigned to
  the current scope under the specified name.

<b>&rarr; Modify the `main()` method to create a new module.</b>

    ```Dart
    void main() {
      ngBootstrap(module: new Module()..type(BadgesController));
    }
    ``` 
    
 > Inside the ngBootstrap method, a new AngularModule is created. The AngularModule provides all of Angular’s built in services  and directives. Your app’s module is added to the list of modules that Angular loads.
 - In class `BadgesController`, add an `inputIsNotEmpty` getter, a `label` getter and a `generateName` method :

    ```Dart
    bool get inputIsNotEmpty => !name.trim().isEmpty;
  	String get label => inputIsNotEmpty ? "Arrr! Write yer name!" : "Aye! Gimme a name!";
      
    generateName() {
      name = 'Anne Bonney';
    }
    ```

### Open `piratebadge.html`. 
 - Add `badges` (the controller selector name) on the `<body>` element:

    ```HTML
    <body badges>
    ```
 - Add the `button` tag below the input field

    ```HTML
    <div class="widgets">
      <div>
        <input type="text" id="inputName" maxlength="15" ng-model="name">
      </div>
      <div>
        <button ng-click="ctrl.generateName()">{{ctrl.label}}</button>
      </div>
    </div>
    ```

 > `ng-click` is a built in Angular Directive that allows you to specify custom behavior when any element is clicked. In our example, it invokes the generateName() method on the controller.
 > `{{ctrl.label}}` show you that a mustache can refer to a getter.
 - Update data binding : replace `name` by `ctrl.name` to use name from controller.

    ```HTML
    <input type="text" id="inputName" maxlength="15" ng-model="ctrl.name">
    ```
    
    ```HTML
    <span id="badgeName">{{ctrl.name}}</span>
    ```
    
 - Add a `ng-disabled` directive on the button tag who disable it when the input field will be not empty.
 
 	```HTML
    <button ng-click="ctrl.generateName()" ng-disabled="ctrl.inputIsNotEmpty">
    	{{ctrl.label}}
    </button>
    ```
    
 > `ng-disabled`, like the `ng-click` directive, is a built-in AngularDart directive. It is used to enable or disable an element according to the value of a boolean expression. In our case we test that the controller's `name` property is not empty after we have trimmed it.

### Run `piratebadge.html` and click on button.

### Problems?
Check your code against the files in [3-buttonbadge](../web/3-buttonbadge).
- [piratebadge.html](../web/3-buttonbadge/piratebadge.html)
- [piratebadge.dart](../web/3-buttonbadge/piratebadge.dart)

## [Home](../README.md) | [< Previous](step-2.md) | [Next >](step-4.md)
