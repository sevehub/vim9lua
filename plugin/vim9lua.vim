vim9script
# Define the command to run the Lua script
command! RunLua call RunLuaScript()

# Function to run the current buffer as a Lua script
def RunLuaScript(): void
  # Get the current buffer content
  var buffer_content = getline(1, '$')

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
