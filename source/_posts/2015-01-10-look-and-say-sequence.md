---
title: Look and Say Sequence
date: 2015-01-10 22:54 UTC
tags: ruby
---

Had some fun recently coming up with a solution to generate any element of the
Look-and-say sequence. The sequence was introduced and analyzed by John
Conway. Here is an example of the sequence:

```ruby
1, 11, 21, 1211, 111221, 312211, 13112221, 1113213211, ...
```

The best way to explain the sequence is through examples:

1 "one one" -> 11 "two ones" -> 21 "one two, one one" -> 1211, etc

This is a sequence used by Google during interviews. They ask for a method
*using recursion* that takes in n, where n represents the n'th element appearing
in the sequence, that returns the entire sequence to that point.

For example:

```ruby
foo(4)
[1, 11, 21, 1211]
```

Here is the solution I came up with:

```ruby
def look_and_say(n, x = "1", to_return = ["1"])
  if n == 1
    return to_return.map{|i| i.to_i}
  end
 
  if n > 1
    x = get_next_element(x)
    to_return << x
    return look_and_say(n-1, x, to_return)
  end
end
 
def get_next_element(x)
  current_digit = x[0]
  count = 0
  to_return = ""

  x.chars.each do |i|
    if i == current_digit
      count += 1
    else
      to_return = "#{to_return + count.to_s + current_digit}"
      current_digit = i
      count = 1
    end
  end
  to_return = "#{to_return + count.to_s + current_digit}"
  return to_return
end

```
