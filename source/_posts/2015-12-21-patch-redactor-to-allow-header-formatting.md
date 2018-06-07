---
title: Patch Redactor to allow header formatting
date: 2015-12-21 21:08 UTC
tags: redactor, front-end
---

For whatever reason Redactor in older versions does not allow formatting to be
applied to headers. After some Googling I was able to find a solution posted by
[Simon](https://stackoverflow.com/users/130526/simon) on
[StackOverflow](https://stackoverflow.com/questions/32088397/can-i-customise-the-header-tagsh1-h2-h3-in-redactor-editor).
It turns out you can comment out one of the lines that guard against this and
it works!

<img src="assets/img/redactor_heading_patch.png">

The following line prevents formatting actions taking affect on headers.

```javascript
if (this.utils.isCurrentOrParent('PRE') || this.utils.isCurrentOrParentHeader()) return;
```

It needs to be changed to:

```javascript
if (this.utils.isCurrentOrParent('PRE')) return;
```

Although we can make these changes directly to the source code there are
downsides to this including maintainability.

Applying the changes via a patch is more preferable.

The below patch will allow formats (e.g. bold, italic, underline,
strikethrough) to be applied to redactor headings.

```javascript
$(document).ready(function() {
  if ($.Redactor) {
    var _inline = $.Redactor.prototype.inline;
    $.Redactor.prototype.inline = function() {
      var obj = _inline();
      obj.format = function(tag, type, value) {
                     if (this.utils.isCurrentOrParent('PRE')) return;
                     //rest of method from source
      return obj;
    }
  }
```
