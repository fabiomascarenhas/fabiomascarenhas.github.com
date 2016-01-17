-- Classe Seq
-- métodos: len, sub, byte, concat e tostrng
-- metamétodos: __len, __concat, __tostring

local Seq = {}
Seq.__index = Seq

function Seq:new(vector, lbra, rbra, tos, sep)
    lbra = lbra or "{"
    rbra = rbra or "}"
    tos = tos or tostring
    sep = sep or ", "
    local myvec = {}
    for i = 1, #vector do
        myvec[i] = vector[i]
    end
    local seq = { vector = myvec, 
      start = 1, size = #vector, lbra = lbra,
      rbra = rbra, tos = tos, sep = sep }
    return setmetatable(seq, self)
end

function Seq:slice(seq, i, j)
    return setmetatable({ vector = seq.vector,
      start = i, size = j - i + 1, lbra = seq.lbra,
      rbra = seq.rbra, tos = seq.tos, 
      sep = seq.sep }, self)
end

function Seq:len()
    return self.size
end

Seq.__len = Seq.len

function Seq:byte(i, j)
    i = i or 1
    j = j or i
    if i > #self then return end
    if j > #self then j = #self end
    local offset = self.start - 1
    return table.unpack(self.vector, i + offset,
                        j + offset)
end

function Seq:sub(i, j)
    j = j or self:len()
    if j > #self then j = #self end
    local offset = self.start - 1
    return Seq:slice(self, i + offset, j + offset)
end

function Seq:concat(seq)
    local vector = {}
    for k = 1, #self do
        vector[#vector + 1] = self:byte(k)
    end
    for k = 1, #seq do
        vector[#vector + 1] = seq:byte(k)
    end
    return Seq:slice({ vector = vector,
      lbra = self.lbra, rbra = self.rbra,
      tos = self.tos, sep = self.sep }, 1, #vector)
end

Seq.__concat = Seq.concat

function Seq:tostring()
    local out = {}
    for k = 1, #self do
        out[#out+1] = self.tos(self:byte(k))
    end
    return self.lbra .. table.concat(out, self.sep) .. self.rbra
end

Seq.__tostring = Seq.tostring

return Seq
