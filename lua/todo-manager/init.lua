local M = {}

local Path = require("plenary.path")
local utils = require("todo-manager.utils")
local vim = vim

M.setup = function (opts)


end

M.add_todo = function (todo)
    if not utils.file_exists("TODO.md") then
        utils.create_todo_file("TODO.md")
    end

    local todo = todo or vim.fn.input("TODO: ")

    local root = vim.fn.getcwd()
    local current_buffer = vim.fn.expand('%')
    current_buffer = string.gsub(current_buffer, root .. '/', '')
    local relative = Path:new(current_buffer):make_relative(root)

    utils.append_todo(relative, todo)
end

vim.api.nvim_create_user_command(
'AddTodo',
function (args)
    local arguments = {}
    for word in args.args:gmatch("%w+") do table.insert(arguments, word) end

    if #arguments == 0 then
        M.add_todo()
    else
        M.add_todo(arguments[1])
    end
end,
{ desc = "Add a todo", nargs = '?' }
)

return M
