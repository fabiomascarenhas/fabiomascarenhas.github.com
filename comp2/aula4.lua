function print_array(a)
	print("{ " .. table.concat(a, ", ") .. " }")
end

function print_set(s)
	local buf = {}
	for x, b in pairs(s) do
		if b then
			buf[#buf+1] = tostring(x)
		end
	end
	print_array(buf)
end

function assert(ok, msg, ...)
    if ok then
        return ok, msg, ...
    else
        error(msg)
    end
end

function freq(pkg)
    package.loaded[pkg] = nil
    return require(pkg)
end

function pack(...)
    return { ... }
end

function fromto(a, b)
  return function ()
           if a > b then
             return nil
           else
             a = a + 1
             return a - 1
           end
         end
end

function print_iter(iter)
    local v = {}
    for x in iter do
        v[#v+1] = x
    end
    print_array(v)
end

function sum_fold(iter, z)
    return foldl(function (a, b) return a + b end,
                 z, iter)
end

function sum_foldr(iter, z)
    return foldr(function (a, b) return a + b end,
                 z, iter)
end

function prod_fold(iter)
    return foldl(function (a, b) return a * b end,
                 1, iter)
end
function prod_foldr(iter)
    return foldr(function (a, b) return a * b end,
                 1, iter)
end

function iter_to_array(iter)
    return foldl(function (arr, item)
                     arr[#arr+1] = item
                     return arr
                 end, {}, iter)
end

function values(array)
    local i = 0
    return function ()
             i = i + 1
             return array[i]
           end
end

function reverse(array)
    return foldr(function (item, arr)
                     arr[#arr + 1] = item
                     return arr
                 end, {}, values(array)) 
end

-- produz um iterador modificado por f
-- todos os elementos do iterador serao modificados
--por f
function map(f, iter)
    return function()
              for x in iter do
                  return f(x)
              end
end

--[[
function map(f, iter)
 return function()
            local x = iter()
            if x == nil then 
                return nil
            end
            return f(x)
        end
end
]]

-- produz um iterador modificado iter para os quais
-- p se aplica
function filter(p, iter)
    return function ()
               for x in iter do
                   if p(x) then
                       return x
                   end
               end
           end
end

--[[
function filter(p, iter)
    return function()
        local x = iter()
        while x ~= nil do
            if p(x) then
                return x 
            end
            x = iter()
        end
        return nil
    end
end
]]
-- produz 
--  op(...op(op(z, iter_1), iter_2),...iter_n)
function foldl(op, z, iter)
    for x in iter do
        z = op(z, x)
    end
    return z
end
--[[
-- recursivamente
function foldl(op, z, iter)
    local x = iter()
    if x == nil then 
        return z
    else
        return foldl(op, op(z, x), iter)
    end
end
]]

function foldr(op, z, iter)
    local x = iter()
    if x == nil then 
        return z
    else
        return op(x, foldr(op, z, iter))
    end
end
--[[
-- sem recursão
function foldr(op, z, iter)
    local t = {}
    for x in iter do
        t[#t+1] = x
    end
    for i = #t, 1 do
        z = op(t[i], z)
    end
    return z
end
]]
