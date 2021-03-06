---
title: Batman.js data-foreach getting key value
date: 2014-08-20 22:31 UTC
tags: batman.js
---

Tasked with creating an internal dashboard we decided to go with Shopify's
Dashing framework. However, I ran into a problem when using the `data-foreach`
binding to iterate over a hash where I needed to access both the `key` and the
`value`. Unable to find the solution in the documentation or online I turned
to the batmanjs freenode irc channel.As it turns out the solution is very
simple.

The `data-foreach` binding iterates over the keys. Use the key to
lookup the value [and boom goes the dynamite](http://youtu.be/W45DRy7M1no).

**Hash:**

```
Products = { product1: '$1', product2: '$2' }
```

**View:**

```
<ul>
  <li data-foreach-product="Products">
    <span data-bind="product"></span>
    <span data-bind="Products[product]"></span>
  </li>
</ul>
```

**Output:**

```
<ul>
  <li>
    <span data-bind="product">product1</span>
    <span data-bind="Products[product]">$1</span>
  </li>
  <li>
    <span data-bind="product">product2</span>
    <span data-bind="Products[product]">$2</span>
  </li>
</ul>
```
