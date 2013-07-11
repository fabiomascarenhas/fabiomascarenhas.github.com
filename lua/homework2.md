---
layout: default
title: Programming in Lua - Homework 2
relpath: ..
---

Programming in Lua - Homework 2
===============================

1\. The chunk below fails with a syntax error. Fix it:

{% highlight lua %}
code = [[
  foo[bar[0]] = 2
]]
print(code)
{% endhighlight %}

2\. Explain what the following `mistery` function does:

{% highlight lua %}
function mistery(a, ...)
  return ...
end
{% endhighlight %}

3\. Write a function that returns the first `n` numbers in
the Fibonacci sequence:

{% highlight lua %}
> print(fibs(5))
> 1    1    2    3    5	
{% endhighlight %}

Each number in the Fibonacci sequence is the sum of the two
previous numbers. *Hint: use an auxiliary function that uses
the same trick as the `range` function in the lecture notes
for class 3.*

4\. Write a function that takes as arguments the coeficients
of a polynomial, and returns a function that evaluates the polynomial
for some `x`:

{% highlight lua %}
f = poly(3, 0, 1)
print(f(0)) -- 1 = 3*0^2 + 0*0^1 + 1*0^0
print(f(5)) -- 76 = 3*5^2 + 0*5^1 + 1*5^0
{% endhighlight %}

5\. The [*triangular numbers*](http://en.wikipedia.org/wiki/Triangular_number)
are a famous integer sequence. The first triangular number is 1. The nth
triangular number can be found by taking the previous number and adding `n`
(1, 3, 6, 10, 15, ...). Write a *closure iterator* for the triangular numbers:

{% highlight lua %}
for x in triang(5) do
  io.write(x, "\t")
end
io.write("\n")
-- prints    1    3    6    10    15
{% endhighlight %}
 
