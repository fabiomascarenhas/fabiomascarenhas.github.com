local Seq = require "seq"
local parser = {}

function parser:__call(...)
    return self[1](...)
end

local function new(f)
    return setmetatable({ f }, parser)
end

-- reconhece um caractere
local function char(c)
    return new(function (input)
                   local byte = input:byte(1)
                   if byte and byte == c:byte(1) then
                       return { { byte, input:sub(2) } }
                   else
                       return { }
                   end
               end)
end

-- reconhece uma classe de caracteres
local function class(p)
    return new(function (input)
                   local byte = input:byte(1)
                   if byte and p(byte) then
                       return { { byte, input:sub(2) } }
                   else
                       return { }
                   end
               end)
end

-- reconhece um tipo de token
local function token(t)
    return new(function (input)
                   local tok = input:byte(1)
                   if tok and tok.type == t then
                       return { { t, input:sub(2) } }
                   else
                       return { }
                   end
               end)
end

-- sequência passando o resultado
local function bind(p, f)
    return new(function (input)
                   local lres = p(input)
                   local out = {}
                   for _, par in ipairs(lres) do
                       local lres = f(par[1])(par[2])
                       for _, par in ipairs(lres) do
                           out[#out+1] = par
                       end
                   end
                   return out
               end)
end

parser.__pow = bind

-- não consome nada, apenas gera um resultado
local function unit(x)
    return new(function (input)
                   return { { x, input } }
               end)
end

-- sequência combinando resultados em um par
local function seq(p1, p2)
    return p1 ^ function (res1)
                     return p2 ^ function (res2)
                                     return unit({ res1, res2 })
                                 end
                 end
end

parser.__mul = seq

-- sequência combinando resultados em uma tupla
local function seqn(p, ...)
    local ps = { ... }
    if #ps == 0 then
       return p ^ function(res)
                    return unit({res})
                  end
    end
    return p ^ function(res1)
                   return seqn(table.unpack(ps)) ^
                          function(res2)
                              table.insert(res2, 1, res1)
                              return unit(res2)
                          end
               end
end

-- escolha não-determinística
local function choice(p1, p2)
    return new(function (input)
                   local out = {}
                   local lres1 = p1(input)
                   for _, par in ipairs(lres1) do
                       out[#out+1] = par
                   end
                   local lres2 = p2(input)
                   for _, par in ipairs(lres2) do
                       out[#out+1] = par
                   end
                   return out
               end)
end

parser.__add = choice

-- escolha ordenada
local function ochoice(p1, p2)
    return new(function (input)
                   local lres1 = p1(input)
                   if #lres1 > 0 then
                       return { lres1[1] }
                   else
                       local lres2 = p2(input)
                       return { lres2[1] }
                   end
               end)
end

parser.__div = ochoice

-- repetição gulosa não-determinística
local function many(p)
    return (p ^ function (res1)
                    return many(p) ^ function (res2)
                                         table.insert(res2, 1, res1)
                                         return unit(res2)
                                     end
                end) + unit({})
end

-- repetição possessiva
local function poss(p)
    return (p ^ function (res1)
                    return poss(p) ^ function (res2)
                                         table.insert(res2, 1, res1)
                                         return unit(res2)
                                     end
                end) / unit({})
end

-- repetição gulosa determinística
local function greedy(p, next)
    return (p ^ function (res1)
                    return greedy(p, next) ^ function (res2)
                                                 table.insert(res2, 1, res1)
                                                 return unit(res2)
                                             end
                end) / (next ^ function (res) return unit({res}) end)
end

-- repetição preguiçosa determinística
local function lazy(p, next)
    return (next ^ function (res) return unit({res}) end) /
           (p ^ function (res1)
                    return lazy(p, next) ^ function (res2)
                                                  table.insert(res2, 1, res1)
                                                  return unit(res2)
                                              end
                end)
end

-- joga fora todos os resultados exceto o primeiro
local function first(p)
    return new(function (input)
                   local lres = p(input)
                   return { lres[1] }
               end)
end

return { new = new, class = class, token = token, char = char,
    bind = bind, unit = unit, seq = seqn, choice = choice,
    ochoice = ochoice, many = many, poss = poss, lazy = lazy,
    greedy = greedy, first = first }
