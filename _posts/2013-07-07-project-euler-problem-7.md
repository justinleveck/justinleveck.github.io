---
title: Project Euler - Problem 7
date: 2013-07-07 2:06 +00:00
tags: project-euler, ruby
---

I recently applied to [gSchool](http://www.gschool.it/). The code I submitted was my answer to Problem 7 at [Project Euler](http://projecteuler.net/problem=7):

> By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
> What is the 10,001st prime number?

This was a fun problem to work on. Initially the method I wrote to test if a number (x) is prime involved testing each number that made up x. It resembled something like this:

```ruby
def prime? number
  return false if number == 0 || number == 1
  integers = *(2..number)
  integers.each do |i|
    return false if number % i == 0
  end
  true
end
```

Although this approach worked. It took far too long to compute. So I did some research on Wikipedia and came across an integer factorization called [Trial division](http://en.wikipedia.org/wiki/Trial_division). Incorporating this into the final solution below drastically reduced the time to compute the answer.

```ruby
def prime? number
  return false if number == 0 || number == 1
  integers = *(2..Math.sqrt(number).round)
  integers.each do |i|
    return false if number % i == 0
  end
  true
end

def findPrime order
  count = 0
  number = 0
  while count != order
      number += 1
      count += 1 if prime? number
  end
  number
end
```

