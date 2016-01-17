---
layout: default
title: Programming in Lua - Homework 4 Answers
relpath: ..
---

Programming in Lua - Homework 4 Answers
=======================================

1\. Answer:

{% highlight lua %}
5
"hello"
nil
{% endhighlight %}

2\. Answer:

{% highlight lua %}
lua_getglobal(L, "window");
lua_getfield(L, -1, "title");
strcpy(window_title, lua_tostring(L, -1));
lua_pop(L, 1);
lua_getfield(L, -1, "width");
window_width = lua_tointeger(L, -1);
lua_getglobal(L, "user");
strcpy(user, lua_tostring(L, -1));
{% endhighlight %}

3\. Answer: It returns all the values passed to it, except the first one.

4\. Answer:

{% highlight lua %}
static int sum(lua_State *L) {
  int i; double s = 0;
  int nargs = lua_gettop(L);
  for(i = 1; i <= nargs; i++) {
    s += luaL_checknumber(L, i);
  }
  lua_pushnumber(L, s);
  return 1;
}
{% endhighlight %}

5\. Answer:

{% highlight lua %}
static int clear(lua_State *L) {
  BitVector *bv = (BitVector*)luaL_checkudata(L, 1, "bv.mt");
  bv_clear(bv);
  return 0;
}
{% endhighlight %}
