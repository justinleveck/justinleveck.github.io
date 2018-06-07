---
title: Working with Frozen Hashes
date: 2015-12-01 18:25 UTC
tags: ruby, hash, deep_dup
---

I discovered a cool method today while working with a frozen hash containing a
frozen array.

`deep_dup`

From the [Rails API Documentation](http://apidock.com/rails/Hash/deep_dup):

> Returns a deep copy of hash.

>  ```ruby
>  hash = { a: { b: 'b' } }
>  dup  = hash.deep_dup
>  dup[:a][:c] = 'c'
>
>  hash[:a][:c] # => nil
>  dup[:a][:c]  # => "c"> 
  ```

Use of this method allowed for a nice refactor:

**Before**

```ruby
SANITIZER = AppConfig.sanitizer.default.dup
SANITIZER[:elements] = SANITIZER[:elements].dup
SANITIZER[:elements].push "iframe"
```

**After**

```ruby
SANITIZER = AppConfig.sanitizer.default.deep_dup
SANITIZER[:elements].push "iframe"
```
