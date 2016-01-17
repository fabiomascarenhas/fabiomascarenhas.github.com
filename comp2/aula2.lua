function range(a, b, c)
	if a > b then
		return
	else
		return a, range(a+c, b, c)
	end
end

function print_array(a)
	print("{ " .. table.concat(a, ", ") .. " }")
end

function sum_is(a)
    local s = 0
	for i, x in ipairs(a) do
	  print("adding element ", i)
	  s = s + x
	end
	return s
end

function sum(a)
    local s = 0
	for _, x in ipairs(a) do
	  s = s + x
	end
	return s
end

point1 = { x = 10, y = 20 }
point2 = { x = 50, y = 5  }
line   = { from = point1, to = point2, color = "blue" }

set = { [1] = true, [3] = false, [5] = true }

function print_set(s)
	local buf = {}
	for x, b in pairs(s) do
		if b then
			buf[#buf+1] = tostring(x)
		end
	end
	print_array(buf)
end

sunday = "monday"; monday = "sunday"
t = { sunday = "monday", [sunday] = monday }
print(t.sunday, t[sunday], t[t.sunday])

TESTE = [[
"foo\n"3236 100.0 foo _ f12    end if . .. = 
== ++ fora
]] 

-- tokens:
--     { tipo = "string", lexema = '"foo\n"' }
function isDig(byte)
	return byte >= string.byte('0') and
		   byte <= string.byte('9')
end
function tokenString(str) 
	local final = 0
	local indice = 2
	while final == 0 do
		if string.byte(str, indice) ==
		   string.byte('"') then
			final = indice
		end
		indice = indice + 1
	end
	return {tipo="string", lexema=string.sub(str,1, final )}, string.sub(str, final+1)
end 
function token(str)
	local indice, inicio, fim = 1, 1, 1
	while string.byte(str, indice) ==
		  string.byte(" ") do
		indice = indice + 1
	end
	local byte = string.byte(str, indice)
	if byte == string.byte('"') then
		return tokenString(string.sub(str, indice))
	elseif isDig(byte) then
	elseif isIdBegin(byte) then
	elseif byte == string.byte('=') then
	elseif byte == string.byte('~') then
	elseif byte == string.byte('.') then
	else	
	end
end

