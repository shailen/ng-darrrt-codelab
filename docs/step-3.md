## Step 3: Add a button and controller

In this step you add a button and a controller that coordinates the button, label, and badge.

_**Keywords**: controller, module, click event_

### Edit piratebadge.dart.

<b>&rarr; Create an empty class named `BadgesController`, and give it a `name` property.</b>

<pre>
...
<b>class BadgesController {
  String name = '';
  BadgesController();
}</b>

void main() {
...</pre>
    
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

<pre>
void main() {
  <b>ngBootstrap(module: new Module()..type(BadgesController));</b>
}
</pre>
    
Key information:
- The Module instance provides all of Angular’s built in services  and directives.
- Your app’s module is added to the list of modules that Angular loads.

<b>&rarr; In the `BadgesController` class, add an `inputIsNotEmpty` getter,
a `label` getter, and a `generateName()` method.</b>

<pre>
class BadgesController {
  String name = '';
  BadgesController();
  
  <b>bool get inputIsNotEmpty => !name.trim().isEmpty;
  String get label => inputIsNotEmpty ? "Arrr! Write yer name!" : "Aye! Gimme a name!";
    
  generateName() {
    name = 'Anne Bonney';
  }</b>
}
</pre>

<!-- PENDING: add key info about getters -->

### Edit piratebadge.html. 

<b>&rarr; Add `badges` to the `<body>` element. </b>

<pre>
&lt;body <b>badges</b>>
</pre>

Key information:

* Thanks to the `badges` selector, a BadgeController now
  controls every element under `<body>`.

<b>&rarr; Add a `button` element under the input field.</b>

<pre>
&lt;div class="widgets">
  &lt;div>
    &lt;input type="text" id="inputName" maxlength="15" ng-model="name">
  &lt;/div>
  <b>&lt;div>
    &lt;button ng-click="ctrl.generateName()">{{ctrl.label}}&lt;/button>
  &lt;/div></b>
&lt;/div>
</pre>

Key information:

* `ng-click` is a built-in Angular directive that
  allows you to specify custom behavior when an element is clicked.
  In our example, it invokes the generateName() method on the controller.
* As `{{ctrl.label}}` shows, an Angular expression can refer to a getter.

<b>&rarr; Update data binding: replace `name` with `ctrl.name`.</b>

<pre>
&lt;input type="text" id="inputName" maxlength="15" ng-model="<b>ctrl.name</b>">
</pre>

<pre>
&lt;span id="badgeName">{{<b>ctrl.name</b>}}</span>
</pre>
    
<b>&rarr; Add a `ng-disabled` directive to the button tag. </b>

<pre>
&lt;button ng-click="ctrl.generateName()" <b>ng-disabled="ctrl.inputIsNotEmpty"</b>>
  {{ctrl.label}}
&lt;/button>
</pre>

Key information:
* `ng-disabled` disables the element whenever the condition is true.
  In this case,
  the button is disabled whenever the input field contains text.

* Like `ng-click`, `ng-disabled` is a built-in AngularDart directive.

### Run the app in Dartium.

Click the button.
"Anne Bonney" appears in the text field and badge,
and the button becomes disabled.

Erase all text from the input field.
The button becomes enabled again.

### Problems?
Check your code against the files in [3-buttonbadge](../web/3-buttonbadge).
- [piratebadge.html](../web/3-buttonbadge/piratebadge.html)
- [piratebadge.dart](../web/3-buttonbadge/piratebadge.dart)

## [Home](../README.md) | [< Previous](step-2.md) | [Next >](step-4.md)
