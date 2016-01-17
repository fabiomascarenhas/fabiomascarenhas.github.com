
local Seq = require "seq"
local classes = require "charclass"

-- tokens:
--     { tipo = "string", lexema = '"foo\n"' }

local function str_to_vec(s)
    local vec = {}
    for i = 1, #s do
        vec[i] = s:byte(i)
    end
    return vec
end

local TESTE_SEQ = Seq:new(str_to_vec([[
"foo\n"3236 100.0 foo _ f12    end if . .. = 
== ++ fora
for while
]]), '', '', string.char, '')

local TESTE_STR = [[
"foo\n"3236 100.0 foo _ f12    end if . .. = 
== ++ fora
for while
]]

local KEYWORDS = {
    ["function"] = true,
    ["end"] = true,
    ["while"] = true,
    ["local"] = true,
    ["true"] = true,
    ["and"] = true,
    ["false"] = true,
    ["else"] = true,
    ["if"] = true,
    ["elseif"] = true,
    ["not"] = true,
    ["nil"] = true,
    ["or"] = true,
    ["return"] = true,
    ["then"] = true,
    ["do"] = true
}

local function token_string(seq) 
	local indice = 1
    repeat
        indice = indice + 1
        local char = seq:byte(indice)
        assert(char, "string nao terminada")
    until char == ('"'):byte()
	return { tipo = "string", 
             lexema = seq:sub(1, indice) }, 
           seq:sub(indice+1)
end

local function skip_digits(seq, indice)
    repeat
        indice = indice + 1
        local char = seq:byte(indice)
    until (not char) or (not classes.is_digit(char))
    return indice
end

local function token_number(seq)
    local char
    local indice = skip_digits(seq, 1)
    if seq:byte(indice) == ('.'):byte() then
        indice = skip_digits(seq, indice)
    end
    return { tipo = "number",
             lexema = seq:sub(1, indice-1) },
           seq:sub(indice)
end

local function token_idorkw(seq)
    local indice = 1
    repeat
        indice = indice + 1
        local char = seq:byte(indice)
    until (not char) or (not classes.is_idrest(char))
    local lexema = seq:sub(1, indice-1)
    local rest = seq:sub(indice)
    if KEYWORDS[tostring(lexema)] then
        return { tipo = tostring(lexema), 
            lexema = lexema }, rest
    else
        return { tipo = "id", lexema = lexema }, rest
    end
end

local function token(seq)
	local indice = 1
	while classes.is_space(seq:byte(indice)) do
		indice = indice + 1
	end
	local char = seq:byte(indice)
    local rest = seq:sub(indice)
    if not char then -- final
        return { tipo = "eof" }, rest
    elseif char == ('"'):byte() then
		return token_string(rest)
	elseif classes.is_digit(char) then
        return token_number(rest)
	elseif classes.is_idbegin(char) then
        return token_idorkw(rest)
	elseif char == ('='):byte() then
        indice = indice + 1
        if seq:byte(indice) == ('='):byte() then
            indice = indice + 1
            return { tipo = "==", lexema =
                     seq:sub(indice-2, indice-1) },
                   seq:sub(indice)
        else
            return { tipo = "=", lexema = 
                     seq:sub(indice-1, indice-1) }, 
                   seq:sub(indice)
        end
	elseif char == ('~'):byte() then
        indice = indice + 1
        if seq:byte(indice) == ('='):byte() then
            indice = indice + 1
            return { tipo = "~=", lexema =
                     seq:sub(indice-2, indice-1) },
                   seq:sub(indice)
        else
            return { tipo = "~", lexema = 
                     seq:sub(indice-1, indice-1) }, 
                   seq:sub(indice)
        end
	elseif char == ('.'):byte() then
        indice = indice + 1
        if seq:byte(indice) == ('.'):byte() then
            indice = indice + 1
            return { tipo = "..", lexema =
                     seq:sub(indice-2, indice-1) },
                   seq:sub(indice)
        else
            return { tipo = ".", lexema =
                     seq:sub(indice-1, indice-1) }, 
                   seq:sub(indice)
        end
	else
        indice = indice + 1
        return { tipo = string.char(char), 
                 lexema = seq:sub(indice-1, indice-1) },
               seq:sub(indice)
	end
end

local function all_tokens(seq)
    local toks = {}
    repeat
        local tok, rest = token(seq)
        toks[#toks+1] = tok
        seq = rest
    until tok.tipo == "eof"
    return toks
end

return { TESTE_SEQ = TESTE_SEQ, TESTE_STR = TESTE_STR,
         token = token, all_tokens = all_tokens }
