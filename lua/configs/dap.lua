
local dap = require("dap")

local function get_cmake_executable()
  local cwd = vim.fn.getcwd()
  local build_dir = cwd .. "/build"

  -- build the project first
  vim.fn.system({ "cmake", "--build", build_dir })

  -- find executables in build directory
  local handle = io.popen("find " .. build_dir .. " -type f -executable")
  if not handle then
    error("Could not search build directory")
  end

  local result = {}
  for file in handle:lines() do
    table.insert(result, file)
  end
  handle:close()

  if #result == 0 then
    error("No executable found in build directory")
  end

  -- if only one executable, use it
  if #result == 1 then
    return result[1]
  end

  -- if multiple, let user choose
  return vim.fn.inputlist(result)
end

dap.configurations.cpp = {
  {
    name = "CMake: Build & Launch",
    type = "cppdbg",
    request = "launch",
    program = function()
      return get_cmake_executable()
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

dap.configurations.c = dap.configurations.cpp
