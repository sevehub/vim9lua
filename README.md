# vim9lua
Experimental Vim9Script plugin allows users to execute the contents of the current buffer as a Lua script using Windows PowerShell. It provides a way to test and run Lua code directly from Vim, enhancing the development workflow for Lua programmers. 

### Requirements
- Vim > 9
- PowerShell Desktop (Windows default PowerShell).
- Vim Lsp Plugin https://github.com/yegappan/lsp
- https://github.com/LuaLS/lua-language-server unzip lua-language-server-3.15.0-win32-x64.zip from https://github.com/LuaLS/lua-language-server/releases and set in .vimrc
   ```g:lualsp_path = "C:\path\to\lua-language-server.exe"```
- Optional debugger.lua in the working dir (from https://github.com/slembcke/debugger.lua)
