local M = {}

M.create_todo__file = function (path)
    local file = io.open(path, "w")
    if file ~= nil then
        file:write("# TODO\n")
        file:close()
    end
end


M.readAll = function (file)
    local f = io.open(file, 'r')

    if f == nil then
        return {}
    end

    local lines = {}
    for line in f:lines() do
        table.insert(lines, line)
    end

    f:close()

    return lines
end

function M.writeLinesToFile(file, lines)
    local f = io.open(file, 'w')

    if f == nil then
        print("Error opening file for writing")
        return
    end

    for _, line in ipairs(lines) do
        f:write(line, "\n")
    end

    f:close()
end

M.append_todo = function(relative_file, todo)
    local lines = M.readAll("TODO.md")

    if lines == {} then
        return
    end

    local file_line_index = -1
    for i, line in ipairs(lines) do
        if line == "## " .. relative_file then
            file_line_index = i
            break
        end
    end

    local file = io.open("TODO.md", "a")
    if file ~= nil then
        if file_line_index < 0 then
            file:write("\n## " .. relative_file)
            file:write("\n")
            file:write("\n")
            file:write("- [ ] " .. todo .. "\n" )
        else
            table.insert(lines, file_line_index + 2, "- [ ] " .. todo)

            M.writeLinesToFile("TODO.md", lines)
        end

        file:close()
    end
end

return M
