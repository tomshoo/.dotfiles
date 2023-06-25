local nls  = require 'null-ls'
local fmt  = nls.builtins.formatting
local diag = nls.builtins.diagnostics

nls.setup { sources = {
    fmt.autopep8,
    diag.shellcheck,
    diag.fish,
} }
