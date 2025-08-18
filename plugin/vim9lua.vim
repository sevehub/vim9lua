vim9script
if v:version < 900
    finish
endif


# Define the command to run the Lua script
command! RunLua call RunLuaScript()
command! DebugLua call DebugLuaScript()


def DebugLuaScript(): void
  if !filereadable('debugger.lua')
      return
  endif 

  var buffer_content = getline(1, '$')
    
  # Create a temporary file
  var temp_file = tempname() .. '.lua'
  
  # Write the buffer content to the temporary file
  call writefile(buffer_content, temp_file)

  var pscommand = 'powershell -Command "lua.exe ''' .. temp_file .. ''' "'
  call term_start(pscommand, {'term_name': 'Lua Debug', 'vertical': true, 'exit_cb': OnExit })
enddef

def OnExit(job_id: job, status: number)
  if status == 0
    execute 'bdelete!'
  endif
enddef

# Function to run the current buffer as a Lua script
def RunLuaScript(): void
  # Get the current buffer content
  var buffer_content = getline(1, '$')

  try
      for i in range(len(buffer_content))
          buffer_content[i] = substitute(buffer_content[i], 'local dbg = require("debugger")', '', 'g')
          buffer_content[i] = substitute(buffer_content[i], 'dbg()', '', 'g')
      endfor
  catch
  endtry
  # Create a temporary file
  var temp_file = tempname() .. '.lua'
  
  # Write the buffer content to the temporary file
  call writefile(buffer_content, temp_file)

  # Construct the PowerShell command to run the Lua script
  # var command = 'powershell -Command "Start-Process lua.exe -ArgumentList ''' .. temp_file .. '''"'
  var command = 'powershell -Command "lua.exe ''' .. temp_file .. ''' 2>&1"'
  # Execute the command
  var output = system(command)


  # Create a new buffer to display the output
  new
  setlocal buftype=nofile
  setlocal bufhidden=wipe
  setlocal noswapfile
  setlocal nowrap
  setlocal nonumber
  setlocal norelativenumber
  setlocal filetype=lua_output

  # Insert the output into the new buffer
  call append(0, split(output, '\n'))


  # Optionally, delete the temporary file after execution
  call delete(temp_file)
enddef
