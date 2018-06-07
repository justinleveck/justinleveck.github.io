---
title: Detect iframe click events with pointer-events
date: 2015-12-11 07:30 UTC
tags: frontend, javascript, css
---

Today I learned about the CSS attribute `pointer-events`. Used with an iframe
and parent `div` you can detect when a click has been made over an
embedded iframe.

```html
<div class="container">
  <iframe></iframe>
</div>
```

```css
iframe {
  pointer-events: none;
}
```

```javascript
$(document).ready(function () {
  $('.container').on('click', function() {
    $(this).after("<p>click detected!</p>");
  });
});
```

<iframe width="100%" height="300" src="//jsfiddle.net/justinleveck/apLs8p9g/1/embedded/result" allowfullscreen="allowfullscreen" frameborder="0"></iframe>
