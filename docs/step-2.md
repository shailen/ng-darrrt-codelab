## Step 2: Add an input field

In this step, you add an input field
that updates the text of the badge.

_**Keywords**: binding, scope, model_

-----------------------------
> **Note**: Throughout this code lab, continue to edit the files in `web/1-blankbadge`.
You can use the files in the other `web` subdirectories to compare to your code or to recover if you get off track.

-----------------------------

### Edit piratebadge.dart.

Add the following imports at the top of the file (below the copyright,
but above main()): 

<pre>
<b>import 'package:angular/angular.dart';

@MirrorsUsed(override: '*')
import 'dart:mirrors';</b>
...
</pre>

Key information:

* An import pulls in a Dart library.
* Importing `dart:mirrors` and annotating it with `@MirrorsUsed` is a temporary
  measure that can help the dart2js compiler to generate smaller code.

---

Add `ngBootstrap();` to the `main`() method:

<pre>
void main() {
<b>  ngBootstrap();</b>
}
</pre>


### Edit piratebadge.html.

Add an `ng-app` attribute to the `<html>` element:

<pre>
&lt;html <b>ng-app</b>>
</pre>

Key information:

* The `ng-app` attribute is a _Angular directive_
  that identifies the root element of the application.
  Anything inside of the root element is part of the page template managed by Angular.
  Unless you have a reason for Angular to manage only part of the app,
  we recommend putting the `ng-app` directive on the `<html>` element because it is the outermost tag.



3. Bind the `input` to the badge content:
 - Set `{{name}}` as content within the `badgeName` `<span>`

    ```HTML
    <span id="badgeName">{{name}}</span>
    ```
 - Add the `<input>` tag to the HTML code within the `widgets` `<div>`

    ```HTML
    <div>
      <input type="text" id="inputName" maxlength="15" ng-model="name">
    </div>
    ```

 > Notice that on the input element, we find a Directive called `ng-model`. The value of the model object is displayed in the view using the Angular expression `{{name}}`. 

4. Run `web/1-blankbadge/piratebadge.html` and try to modify the input content. Notice how the view is updated in real time whenever the model changes. This is called _Two Way Data Binding_. Angular listens for changes to the model and updates the view to reflect those changes.

### Learn more about
 - [How Angular does MVC](https://github.com/angular/angular.dart.tutorial/wiki/Creating-your-first-Angular-app#how-angular-does-mvc)

### Problems?
Check your code against the files in [2-inputnamebadge](../web/2-inputnamebadge).
- [piratebadge.html](../web/2-inputnamebadge/piratebadge.html)
- [piratebadge.dart](../web/2-inputnamebadge/piratebadge.dart)

## [Home](../README.md) | [< Previous](step-1.md) | [Next >](step-3.md)
