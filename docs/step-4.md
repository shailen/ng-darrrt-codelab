## Step 4: Create a custom component

In the step, you create a component
that lets you use a `<badge>` tag anywhere in your app.

_**Keywords**: component, Shadow DOM_

### Create a directory for the component.

Name the directory `badge`,
and put it under `web/1-blankbadge` (or wherever you've been working).

The `badge` directory will contain all of the files for the new component.

### Create an HTML file for the component.

Under the `badge` directory,
create a file named `badge_component.html`
with the following contents:

```HTML
<div class="badge">
  <div class="greeting">
    Arrr! Me name is
  </div>
  <div class="name">
    <span id="badgeName">{{cmp.name}}</span>
  </div>
</div>
```

### Create a CSS file for the component.

Under the `badge` directory,
create a file named `badge_component.css`
with the following contents:

```CSS
.badge {
  border: 2px solid brown;
  border-radius: 1em;
  background: red;
  font-size: 14pt;
  width: 14em;
  height: 7em;
  text-align: center;
  white-space: nowrap;
  overflow: hidden;
}
.greeting {
  color: white;
  font-family: sans-serif;
  padding: 0.5em;
}
.name {
  color: black;
  background: white;
  font-family: "Marker Felt", cursive;
  font-size: 25pt;
  padding-top: 1.0em;
  padding-bottom: 0.7em;
  height: 16px;
}
```

### Create a Dart file for the component

Under the `badge` directory,
create a file named `badge_component.dart`
with the following contents:

```Dart
library badge;

import 'package:angular/angular.dart';

@NgComponent(
    selector: 'badge',
    templateUrl: 'badge/badge_component.html',
    cssUrl: 'badge/badge_component.css',
    publishAs: 'cmp'
)
class BadgeComponent {
  @NgAttr('name')
  String name;
}
```

Key information:

* The NgComponent annotation tells Angular that BadgeComponent
  is an Angular component.
* The required `selector` argument defines the CSS selector
  that specifies the component.
  Setting it to just plain `badge` associates it with all `<badge>` tags.
* The `templateUrl` and `cssUrl` arguments tell Angular
  which HTML and CSS files to use for badges.
* The NgAttr annotation on the `name` field
  maps the field to a DOM attribute.

### Use the <badge> element in the app.

<b>&rarr; In `piratebadge.html` replace the HTML code of badge with the new `<badge>`.</b>

```HTML
<badge name="{{ctrl.name}}" style='float: left; margin-left: 20px;'></badge>
```

### Register the new component.

In `piratebadge.dart`:
 - Add an import for the component library:

    ```Dart
    import 'badge/badge_component.dart';
    ```
 - Add the component type to the module:

    ```Dart
    void main() {
      ngBootstrap(module: new Module()
        ..type(BadgesController)
        ..type(BadgeComponent));
    }
    ```

### Run the app.

### Bonus: Try adding several badges to your page.

### Learn more
 - [Creating a Custom Component](https://angulardart.org/tutorial/05-ch03-component.html)
 - [Shadow DOM](http://www.w3.org/TR/shadow-dom/)

### Problems?
Check your code against the files in [4-extractcomponent](../web/4-extractcomponent).
- [piratebadge.html](../web/4-extractcomponent/piratebadge.html)
- [piratebadge.dart](../web/4-extractcomponent/piratebadge.dart)

## [Home](../README.md) | [< Previous](step-3.md) | [Next >](step-5.md)
