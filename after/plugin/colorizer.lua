local colorizer_enabled = false

-- Colorizer should be disabled by default, can enable it using :EnableColorizer
-- which I have defined in 
function EnableColorizer()
    require'colorizer'.setup()
    colorizer_enabled = true
end

vim.cmd([[command! EnableColorizer lua EnableColorizer()]])
