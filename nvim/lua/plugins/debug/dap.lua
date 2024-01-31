local M = {}
local icons = require("comment.nerd_font")
M.opts = {
  active = true,
  on_config_done = nil,
  breakpoint = {
    text = icons.DapBreakpoint,
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = "",
  },
  breakpoint_rejected = {
    text = icons.DapBreakpointRejected,
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = "",
  },
  stopped = {
    text = icons.DapStopped,
    texthl = "DiagnosticSignWarn",
    linehl = "Visual",
    numhl = "DiagnosticSignWarn",
  },
  log = {
    level = "info",
  },
  ui = {
    auto_open = true,
    notify = {
      threshold = vim.log.levels.INFO,
    },
    config = {
      icons = { expanded = "", collapsed = "", circular = "" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      -- Use this to override mappings for specific elements
      element_mappings = {},
      expand_lines = true,
      layouts = {
        {
          elements = {
            { id = "scopes",      size = 0.33 },
            { id = "breakpoints", size = 0.17 },
            { id = "stacks",      size = 0.25 },
            { id = "watches",     size = 0.25 },
          },
          size = 0.33,
          position = "right",
        },
        {
          elements = {
            { id = "repl",    size = 0.45 },
            { id = "console", size = 0.55 },
          },
          size = 0.27,
          position = "bottom",
        },
      },
      controls = {
        enabled = true,
        -- Display controls in this element
        element = "repl",
        icons = {
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "",
          run_last = "",
          terminate = "",
        },
      },
      floating = {
        max_height = 0.9,
        max_width = 0.5,   -- Floats will be treated as percentage of your screen.
        border = "rounded",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil,   -- Can be integer or nil.
        max_value_lines = 100,   -- Can be integer or nil.
      },
    },
  },
}

M.config = function()
  local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
  local function sep_os_replacer(str)
    local result = str
    local path_sep = package.config:sub(1, 1)
    result = result:gsub("/", path_sep)
    return result
  end
  local join_path = require("util").join_paths

  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    return
  end

  vim.fn.sign_define("DapBreakpoint", M.opts.breakpoint)
  vim.fn.sign_define("DapBreakpointRejected", M.opts.breakpoint_rejected)
  vim.fn.sign_define("DapStopped", M.opts.stopped)


  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Neovim attach",
      host = function()
        local value = vim.fn.input "Host [127.0.0.1]: "
        if value ~= "" then
          return value
        end
        return "127.0.0.1"
      end,
      port = function()
        local val = tonumber(vim.fn.input "Port: ")
        assert(val, "Please provide a port number")
        return val
      end,
    },
  }
  dap.adapters.nlua = function(callback, config)
    callback { type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 }
  end

  -- NOTE: if you want to use `dap` instead of `RustDebuggables` you can use the following configuration
  if vim.fn.executable "lldb-vscode" == 1 then
    dap.adapters.lldbrust = {
      type = "executable",
      attach = { pidProperty = "pid", pidSelect = "ask" },
      command = "lldb-vscode",
      env = { LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES" },
    }
    dap.adapters.rust = dap.adapters.lldbrust
    dap.configurations.rust = {
      {
        type = "rust",
        request = "launch",
        name = "lldbrust",
        program = function()
          local metadata_json = vim.fn.system "cargo metadata --format-version 1 --no-deps"
          local metadata = vim.fn.json_decode(metadata_json)
          local target_name = metadata.packages[1].targets[1].name
          local target_dir = metadata.target_directory
          return target_dir .. "/debug/" .. target_name
        end,
        args = function()
          local inputstr = vim.fn.input("Params: ", "")
          local params = {}
          local sep = "%s"
          for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
            table.insert(params, str)
          end
          return params
        end,
      },
    }
  end

  dap.adapters.go = function(callback, _)
    local stdout = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local port = 38697
    local opts = {
      stdio = { nil, stdout },
      args = { "dap", "-l", "127.0.0.1:" .. port },
      detached = true,
    }
    handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
      stdout:close()
      handle:close()
      if code ~= 0 then
        print("dlv exited with code", code)
      end
    end)
    assert(handle, "Error running dlv: " .. tostring(pid_or_err))
    stdout:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(function()
          require("dap.repl").append(chunk)
        end)
      end
    end)
    -- Wait for delve to start
    vim.defer_fn(function()
      callback { type = "server", host = "127.0.0.1", port = port }
    end, 100)
  end
  -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
  dap.configurations.go = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      program = "${file}",
    },
    {
      type = "go",
      name = "Debug with args",
      request = "launch",
      program = "${file}",
      args = function()
        local argument_string = vim.fn.input "Program arg(s): "
        return vim.fn.split(argument_string, " ", true)
      end,
    },
    {
      type = "go",
      name = "Debug test", -- configuration for debugging test files
      request = "launch",
      mode = "test",
      program = "${file}",
    },
    -- works with go.mod packages and sub packages
    {
      type = "go",
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
    },
  }

  dap.configurations.dart = {
    {
      type = "dart",
      request = "launch",
      name = "Launch flutter",
      dartSdkPath = sep_os_replacer(join_path(vim.fn.expand "~/", "/flutter/bin/cache/dart-sdk/")),
      flutterSdkPath = sep_os_replacer(join_path(vim.fn.expand "~/", "/flutter")),
      program = sep_os_replacer "${workspaceFolder}/lib/main.dart",
      cwd = "${workspaceFolder}",
    },
  }
  local firefox_path = mason_path .. "packages/firefox-debug-adapter/"

  dap.adapters.firefox = {
    type = "executable",
    command = "node",
    args = {
      firefox_path .. "dist/adapter.bundle.js",
    },
  }

  local firefoxExecutable = "/usr/bin/firefox"
  if vim.fn.has "mac" == 1 then
    firefoxExecutable = "/Applications/Firefox.app/Contents/MacOS/firefox"
  end
  local custom_adapter = "pwa-node-custom"
  dap.adapters[custom_adapter] = function(cb, config)
    if config.preLaunchTask then
      local async = require "plenary.async"
      local notify = require("notify").async

      async.run(function()
        ---@diagnostic disable-next-line: missing-parameter
        notify("Running [" .. config.preLaunchTask .. "]").events.close()
      end, function()
        vim.fn.system(config.preLaunchTask)
        config.type = "pwa-node"
        dap.run(config)
      end)
    end
  end

  dap.configurations.typescript = {
    {
      type = "node2",
      name = "node attach",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
    },
    {
      type = "chrome",
      name = "Debug with Chrome",
      request = "attach",
      program = "${file}",
      -- cwd = "${workspaceFolder}",
      -- protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}",
      -- sourceMaps = true,
      sourceMapPathOverrides = {
        -- Sourcemap override for nextjs
        ["webpack://_N_E/./*"] = "${webRoot}/*",
        ["webpack:///./*"] = "${webRoot}/*",
      },
    },
    {
      name = "Debug with Firefox",
      type = "firefox",
      request = "launch",
      reAttach = true,
      sourceMaps = true,
      url = "http://localhost:6969",
      webRoot = "${workspaceFolder}",
      firefoxExecutable = firefoxExecutable,
    },
    {
      name = "Launch",
      type = "pwa-node",
      request = "launch",
      program = "${file}",
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles = { "<node_internals>/**" },
      protocol = "inspector",
      console = "integratedTerminal",
    },
    {
      name = "Attach to node process",
      type = "pwa-node",
      request = "attach",
      rootPath = "${workspaceFolder}",
      processId = require("dap.utils").pick_process,
    },
    {
      name = "Debug Main Process (Electron)",
      type = "pwa-node",
      request = "launch",
      program = "${workspaceFolder}/node_modules/.bin/electron",
      args = {
        "${workspaceFolder}/dist/index.js",
      },
      outFiles = {
        "${workspaceFolder}/dist/*.js",
      },
      resolveSourceMapLocations = {
        "${workspaceFolder}/dist/**/*.js",
        "${workspaceFolder}/dist/*.js",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles = { "<node_internals>/**" },
      protocol = "inspector",
      console = "integratedTerminal",
    },
    {
      name = "Compile & Debug Main Process (Electron)",
      type = custom_adapter,
      request = "launch",
      preLaunchTask = "npm run build-ts",
      program = "${workspaceFolder}/node_modules/.bin/electron",
      args = {
        "${workspaceFolder}/dist/index.js",
      },
      outFiles = {
        "${workspaceFolder}/dist/*.js",
      },
      resolveSourceMapLocations = {
        "${workspaceFolder}/dist/**/*.js",
        "${workspaceFolder}/dist/*.js",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles = { "<node_internals>/**" },
      protocol = "inspector",
      console = "integratedTerminal",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
  }

  dap.configurations.typescriptreact = dap.configurations.typescript
  dap.configurations.javascript = dap.configurations.typescript
  dap.configurations.javascriptreact = dap.configurations.typescript

  --Java debugger adapter settings
  dap.configurations.java = {
    {
      name = "Debug (Attach) - Remote",
      type = "java",
      request = "attach",
      hostName = "127.0.0.1",
      port = 5005,
    },
    {
      name = "Debug Non-Project class",
      type = "java",
      request = "launch",
      program = "${file}",
    },
  }

  local path = vim.fn.glob(mason_path .. "packages/codelldb/extension/")
      or vim.fn.expand "~/" .. ".vscode/extensions/vadimcn.vscode-lldb-1.8.1/"
  local lldb_cmd = path .. "adapter/codelldb"

  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      -- CHANGE THIS to your path!
      command = lldb_cmd,
      args = { "--port", "${port}" },

      -- On windows you may have to uncomment this:
      -- detached = false,
    },
  }

  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = true,
      runInTerminal = true,
    },
  }
  dap.configurations.c = dap.configurations.cpp

  dap.configurations.python = dap.configurations.python or {}
  table.insert(dap.configurations.python, {
    type = "python",
    request = "launch",
    name = "launch with options",
    program = "${file}",
    python = function() end,
    pythonPath = function()
      local path
      for _, server in pairs(vim.lsp.get_active_clients()) do
        if server.name == "pyright" or server.name == "pylance" then
          path = vim.tbl_get(server, "config", "settings", "python", "pythonPath")
          break
        end
      end
      path = vim.fn.input("Python path: ", path or "", "file")
      return path ~= "" and vim.fn.expand(path) or nil
    end,
    args = function()
      local args = {}
      local i = 1
      while true do
        local arg = vim.fn.input("Argument [" .. i .. "]: ")
        if arg == "" then
          break
        end
        args[i] = arg
        i = i + 1
      end
      return args
    end,
    justMyCode = function()
      local yn = vim.fn.input "justMyCode? [y/n]: "
      if yn == "y" then
        return true
      end
      return false
    end,
    stopOnEntry = function()
      local yn = vim.fn.input "stopOnEntry? [y/n]: "
      if yn == "y" then
        return true
      end
      return false
    end,
    console = "integratedTerminal",
  })
end

M.setup_ui = function()
  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    return
  end
  local dapui = require "dapui"
  dapui.setup(M.opts.ui.config)

  if M.opts.ui.auto_open then
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    -- dap.listeners.before.event_terminated["dapui_config"] = function()
    --   dapui.close()
    -- end
    -- dap.listeners.before.event_exited["dapui_config"] = function()
    --   dapui.close()
    -- end
  end

  local Log = require "log"

  -- until rcarriga/nvim-dap-ui#164 is fixed
  local function notify_handler(msg, level, opts)
    if level >= M.opts.ui.notify.threshold then
      return vim.notify(msg, level, opts)
    end

    opts = vim.tbl_extend("keep", opts or {}, {
      title = "dap-ui",
      icon = "",
      on_open = function(win)
        vim.api.nvim_buf_set_option(vim.api.nvim_win_get_buf(win), "filetype", "markdown")
      end,
    })

    -- vim_log_level can be omitted
    if level == nil then
      level = Log.levels["INFO"]
    elseif type(level) == "string" then
      level = Log.levels[(level):upper()] or Log.levels["INFO"]
    else
      -- https://github.com/neovim/neovim/blob/685cf398130c61c158401b992a1893c2405cd7d2/runtime/lua/vim/lsp/log.lua#L5
      level = level + 1
    end

    msg = string.format("%s: %s", opts.title, msg)
    Log:add_entry(level, msg)
  end

  local dapui_ok, _ = xpcall(function()
    require("dapui.util").notify = notify_handler
  end, debug.traceback)
  if not dapui_ok then
    Log:debug "Unable to override dap-ui logging level"
  end
end

return M
