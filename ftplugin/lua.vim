vim9script
# Plugin:  lua9vim  
# Description:  Simple vim9 plugin running lua script via powershell
# Maintainer:  S. Tessarin https://tessarinseve.pythonanywhere.com/nws/index.html
# License: GPL3
# Copyright (c) 2024-2025 Seve Tessarin

if v:version < 900
    finish
endif


setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
highlight AirlineStatus guibg=#012456 guifg=#012456
# Highlight the exact string dbg()
syntax match Vim9LuaDbg /\<dbg()\>/

# Link it to a highlight group (or define your own)
# highlight default link Vim9LuaDbg Debug
highlight Vim9LuaDbg ctermfg=Magenta guifg=#FF00FF



var lualsp_path = ''   
if exists('g:lualsp_path')
    lualsp_path = g:lualsp_path
endif

if executable('lua-language-server.exe')

    call LspAddServer([{
        name: 'lua-language-server',
        filetype: ['lua'],
        path: 'lua-language-server.exe',
        args: ['']
    }])
else
     var lspexe =  lualsp_path .. '\\' .. 'lua-language-server.exe'

call LspAddServer([{
    name: 'lua-language-server',
    filetype: ['lua'],
    path: lspexe,
    args: ['']
}])

endif


