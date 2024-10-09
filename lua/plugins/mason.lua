-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        "lua_ls",
        -- add more arguments for adding more language servers
      },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = {
        "stylua",
        -- add more arguments for adding more null-ls sources
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = {
        "python",
        "codelldb",
        -- add more arguments for adding more debuggers
      },
      handlers = {
        codelldb = function(source_name)

          local dap = require "dap"

          dap.configurations.c = {
            {
              name = "Launch file",
              type = "codelldb",
              request = "launch",
              program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
              cwd = "${workspaceFolder}",
              stopOnEntry = false,
            },
            {
              name = "Compile and debug",
              type = "codelldb",
              request = "launch",
              program = function()
                local directory = vim.fn.expand "%:h"
                local filename = vim.fn.expand "%:r"
                vim.fn.system("gcc -fdiagnostics-color=always -g " .. directory .. "/*.c -o " .. filename .. " -lm")
                return vim.fn.input("Path to executable: ", directory .. "/", "file")
              end,
              cwd = "${workspaceFolder}",
              stopOnEntry = false,
            },
          }
        end,
      },
    },
  },
}
