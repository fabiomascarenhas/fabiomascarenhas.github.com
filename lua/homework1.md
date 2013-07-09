---
layout: default
title: Programming in Lua - Homework 1
relpath: ..
---

Programming in Lua - Homework 1
===============================

Feel free to run the following chunks in the interpreter, but it is
better if you try to guess first what the output will be, from what
you have learned in class.

1\. What is the output of the following chunk, and why?

{% highlight lua %}
if nil then print ("true") else print ("false") end
if 0 then print ("true") else print ("false") end
if "" then print ("true") else print ("fakse") end
if false then print ("true") else print ("false") end
{% endhighlight %}

2\. What is the output of the following chunk, and why?

{% highlight lua %}
a = 1
print(type(a))
a = print
print(type(a))
a("hello world!")
{% endhighlight %}

3\. What is the output of the following chunk, and why?

{% highlight lua %}
function f()
  i = 10
end

function g()
  local i = 5
end

print(i)
f()
print(i)
g()
print(i)
{% endhighlight %}

4\. Write a chunk that counts odd numbers backwards from 99 to 1 
(99, 97, 95, ..., 5, 3, 1), printing each number and them printing their sum.
Do it in three ways: with a while loop, with a repeat loop, and using the numeric for.
