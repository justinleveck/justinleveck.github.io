---
title: Batman.js conditionally add dynamic class attributes
date: 2014-08-22 01:17 UTC
tags: batman.js
---

I learned something new today working with Batman.js. I needed to add a
dynamic class attribute conditionally. According to the documentation there are
a couple of data
[bindings](http://batmanjs.org/docs/api/batman.view_bindings.html) to help
achieve this -- `data-addClass` and `data-removeClass`.

I later discovered (on the #batmanjs freenode irc channel) filters can be used to
add conditional logic. As it turns out there are a couple
[filters](http://batmanjs.org/docs/api/batman.view_filters.html) that apply to
this task -- `equals`, `eq`, and `neq`. However the only filter that seems to
work with the above data bindings is `equals`.

Putting this all together, here is an example of how to use a class of `error`
if the key does not equal `'OK'`.

When the key **does not** equal `'OK'` the `error` class is **not** removed:

**Hash**

```
status = { lax: 'ERROR' }
```

**View**

```
<div class="error" data-removeClass-error="status.lax | equals 'OK'"></div>
```

**Output**

```
<div class="error" data-removeclass-error="status.lax | equals 'OK'"></div>
```

<hr />

When the key **equals** `'OK'` the `error` class **is** removed:

**Hash**

```
status = { lax: 'OK' }
```

**View**

```
<div class="error" data-removeClass-error="status.lax | equals 'OK'"></div>
```

**Output**

```
<div class=" " data-removeclass-error="status.lax | equals 'OK'"></div>
```

