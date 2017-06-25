local Util = Object:extend()

function Util.rprint(s, l, i) -- recursive Print (structure, limit, indent)
    l = (l) or 100; i = i or "";	-- default item limit, indent string
    if (l<1) then print "ERROR: Item limit reached."; return l-1 end;
    local ts = type(s);
    if (ts ~= "table") then print (i,ts,s); return l-1 end
    print (i,ts);           -- print "table"
    for k,v in pairs(s) do  -- print "[KEY] VALUE"
        l = Util.rprint(v, l, i.."\t["..tostring(k).."]");
        if (l < 0) then break end
    end
    return l
end

function Util.deepcopy( Table, Cache ) -- Makes a deep copy of a table.
    if type( Table ) ~= 'table' then
        return Table
    end

    Cache = Cache or {}
    if Cache[Table] then
        return Cache[Table]
    end

    local New = {}
    Cache[Table] = New
    for Key, Value in pairs( Table ) do
        New[Util.deepcopy( Key, Cache)] = Util.deepcopy( Value, Cache )
    end

    return New
end

return Util
