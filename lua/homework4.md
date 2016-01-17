---
layout: default
title: Programming in Lua - Homework 4
relpath: ..
---

Programming in Lua - Homework 4
===============================

1\. Assume the Lua stack is empty. What will be its contents after the following sequence of calls to the C API?

{% highlight lua %}
lua_pushnil(L);
lua_pushstring(L, "hello");
lua_pushvalue(L, -2);
lua_pushnumber(L, 5);
lua_remove(L, 1);
lua_insert(L, -2);
{% endhighlight %}

2\. An application is using the Lua configuration file below. Assume it has already been loaded.
Write the C code to get the values out of this configuration file and copy them to the
`window_title`, `window_width`, and `user` C variables. There is no need to do error checking:

{% highlight lua %}
window = { title = "Hello Lua", width = 600 }
user = "fabio"
{% endhighlight %}

3\. What does the C function below do, when called from Lua?

{% highlight lua %}
static int mistery(lua_State *L) {
  int nargs = lua_gettop(L);
  if(nargs > 0)
    return nargs - 1;
  else
    return 0;
}
{% endhighlight %}

4\. Write a C function that takes receives an arbitrary number of numeric arguments,
computes their sum, and returns it.

5\. Write a `clear` C function that clears the bit vectors of class 8. The function
should not return anything.
