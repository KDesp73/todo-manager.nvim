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

    local TODO = todo or vim.fn.input("TODO: ")

    if todo == '' then
        TODO = vim.fn.input("TODO: ")
    end

    local root = vim.fn.getcwd()
    local current_buffer = vim.fn.expand('%')
    if current_buffer == nil or current_buffer == '' then
        current_buffer = "Uncategorized"
    end

    current_buffer = string.gsub(current_buffer, root .. '/', '')
    local relative = Path:new(current_buffer):make_relative(root)

    if TODO == nil or TODO == '' then
        return
    end

    utils.append_todo(relative, TODO)
end

vim.api.nvim_create_user_command(
    'AddTodo',
    function (args)
        M.add_todo(args.args)
    end,
    { desc = "Add a todo", nargs = '?' }
)

return M
