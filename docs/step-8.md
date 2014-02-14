## Step 8: Use a filter to modify data

In this step, you implement a filter to modify data.

_**Keywords**: filter_

Filters let you change how your model data is displayed in the view without
changing the model data itself. They do things like allow you to show parts of
the model data, or display data in a particular format. You can also use
Angular’s custom filters feature to create your own filters to do anything you
want.

### Create a filter

Create a file `filter/capitalize_filter.dart` in your work directory and
paste the following content:

```Dart
library category_filter;

import 'package:angular/angular.dart';

@NgFilter(name: 'capitalize')
class CapitalizeFilter {
  call(String name) {
    if (name == null || name.isEmpty) return '';
    return name[0].toUpperCase() + name.substring(1);
  }
}
```

To create a custom filter in Angular, just create a simple Dart class that has
a call method with the following signature:

```Dart
call(valueToFilter, optArg1, optArg2);
```

### Use the filter

You need to register the filter in order to use . In `piratebadge.dart`, add
this import:

```Dart
import 'filter/capitalize_filter.dart';
```


Now add the filter to the module definition:

```Dart
ngBootstrap(module: new Module()
  ..type(BadgesController)
  ..type(BadgeComponent)
  ..type(CapitalizeFilter)
  );
```

Now the filter can be used in `piratebadge.html`:

```HTML
<badge name="{{ctrl.pirateName | capitalize}}"
        style='float: left; margin-left: 20px;'></badge>
```

Here, we pipe the `pirateName` through the filter.

Run `piratebadge.html`. Type in content that is all in lowercase, and  see
that the pirate name the is capitalized.

### Learn more about
 - [Introducing Filters](https://github.com/angular/angular.dart.tutorial/wiki/Introducing-filters-and-services#introducing-filters)

### Problems?
Check your code against the files in [8-filter](../web/8-filter).
- [piratebadge.html](../web/8-filter/piratebadge.html)
- [piratebadge.dart](../web/8-filter/piratebadge.dart)

## [Home](../README.md) | [< Previous](step-7.md)
