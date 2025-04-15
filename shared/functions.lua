function TableToString(tbl, indent)
    indent = indent or 0
    local toStr = string.rep(" ", indent) .. "{\n"
    for key, value in pairs(tbl) do
        local keyStr = type(key) == "string" and string.format("%q", key) or tostring(key)
        if type(value) == "table" then
            toStr = toStr ..
                string.rep(" ", indent + 2) .. "[" .. keyStr .. "] = " .. tostring(value, indent + 2) .. ",\n"
        else
            local valueStr = type(value) == "string" and string.format("%q", value) or tostring(value)
            toStr = toStr .. string.rep(" ", indent + 2) .. "[" .. keyStr .. "] = " .. valueStr .. ",\n"
        end
    end
    toStr = toStr .. string.rep(" ", indent) .. "}"
    return toStr
end

function PrettyPrintJson(data)
    return json.encode(data):gsub(",", ",\n"):gsub("{", "{\n"):gsub("}", "\n}")
end

function Debug(msg)
    if Config.Debug then
        print("^1[DEBUG]^7 " .. msg)
    end
end

function NodeKey(mine, coords)
    return string.format("%s:%s:%s:%s", mine, coords.x, coords.y, coords.z)
end
