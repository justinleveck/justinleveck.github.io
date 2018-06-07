---
title: Optimize Rails Database Queries with Bullet and RSpec
date: 2015-11-17 21:32 UTC
tags: rails, performance, bullet
---

[Bullet](https://github.com/flyerhzm/bullet) is a gem that helps increase your
application's performance by reducing the number of queries it makes.

The README describes how to use the gem in Development but makes no special
mention of how to use it in test with RSpec.

Searching through the gem's issues I discovered that you can use the following
settings before calling `visit` to have Bullet raise an exception if an
infraction is detected.

```ruby
  Bullet.enable = true
  Bullet.raise = true
```

You could go a step further and update the `rails_helper` to allow for easier usage


```ruby
  # spec/rails_helper.rb

  config.before :each, bullet: true do
    Bullet.enable = true
    Bullet.raise = true
  end

  config.after :each, bullet: true do
    Bullet.enable = false
    Bullet.raise = false
  end
```
