-- máximo entre dois números
function max(a, b)
	if a > b then
	    x = a
		return a
	else
	    x = b
		return b
	end
end

function printf(fmt, ...)
	io.write(string.format(fmt, ...))
end
	
function idiv(a, b)
  return math.floor(a/b), a%b
end

local msg = "Olá, Mundo"
print(msg)
local msg = "Hello, World"
print(msg)

function greeting(s)
	s = s or "Hello, "
	print(s .. ", World!")
end
