---
title: Max Sub Array Length
date: 2018-05-31 17:23 UTC
tags: code-challenge
---

I recently got a subscription to Leetcode.com. I found this challenge particularly challenging:

## Challenge

Given an array nums and a target value k, find the maximum length of a subarray that sums to k. 
If there isn't one, return 0 instead.

Note:
The sum of the entire nums array is guaranteed to fit within the 32-bit signed integer range.

### Example 1:

```
Input: nums = [1, -1, 5, -2, 3], k = 3
Output: 4 
```

**Explanation:** The subarray [1, -1, 5, -2] sums to 3 and is the longest.

### Example 2:

```
Input: nums = [-2, -1, 2, 1], k = 1
Output: 2 
```

**Explanation:** The subarray [-1, 2] sums to 1 and is the longest.

### Solution:

When solving this challenge I made several mistakes. The challenge is asking us
to determine the maximum sub-array length. Not the maximum sub-sequence length.
A sub-array is contigous. This is a key note to solving the challenge.

#### First Attempt

In my first attempt I used a brute force algorithm. Where I determined every
possible sub-array storing only the ones where the sum was equal to the given
amount.

This strategy proved to be very ineffecient. As it requires several iterations
to determine the output.

1. First iteration determines every possible sub-array
2. Second iteration for every sub-array
3. Third iteration for the array of sub-arrays to determine the one with the longest length

```ruby
def max_sub_array_len(nums, k)    
  sub_arrays = []
  nums.each_with_index do |num, index|    
    slice_length = 0
    while slice_length <= nums.length
      sub_array = nums.slice(index, slice_length)
      sum = sub_array.inject(:+)
      if sum == k
        sub_arrays << sub_array
      end

      slice_length += 1
    end
  end

  sub_arrays.map(&:length).max || 0
end
```

#### Second Attempt

This soluion is far more efficient since we are iterating through the
elements only once.

```ruby
def max_sub_array_len(nums, k)
  sum = 0
  max_length = 0
  history = {0 => -1}

  nums.each_with_index do |num, index|
    sum += num
    history[sum] ||= index

    if history[sum - k]
      max_length = [max_length, index - history[sum - k]].max
    end
  end

  max_length
end
```

With this solution we iterate through `nums` and for every element we store the
current sum and current index.

Let's walk through this solution given the following inputs.

```
nums = [1, 1, 5, -2, 3]
k = 3
```

As we iterate through the `nums` the `sum` and `index` are as follows.

```
1  2  7   5  8  # sums
1, 1, 5, -2, 3  # nums
0  1  2   3  4  # index
```

We are trying to find the longest `sub_array` with a sum of 3. Given the `nums`
input we are given there is only one `sub_array` with the sum of 3.

```
[5, -2]
```

When iterating over the nums it is at index `3` when iterating over `-2` we will
determine the only correct `sub_array`.

**Can you see why?**

At index 3 we know the following:

```
sum = 5
k = 3
```

We need to know if at any point a recorded sum is equal to the difference of sum
and k (3). Let's look at our table again. Ah, okay we can see that at index 1
the sum was 2.

```
1  2  7   5  8  # sums
1, 1, 5, -2, 3  # nums
0  1  2   3  4  # index
```

So we know our `sub_array` must contain all elements to the left of our current
element stopping before index 1.

The correct `sub_array` is then `[5, -2]` with a sum equal to the `k` input of 3.
And the correct `max_length` determined is 2.

