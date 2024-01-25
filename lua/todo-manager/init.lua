local M = {}

local Path = require("plenary.path")

local vim = vim

M.setup = function (opts)
    

end

M.add_todo = function ()
    local todo = vim.fn.input("TODO: ")

    local root = vim.fn.getcwd()
    local current_buffer = vim.fn.expand('%')
    current_buffer = string.gsub(current_buffer, root .. '/', '')
    local relative = Path:new(current_buffer):make_relative(root)

end

M.add_todo()


return M
