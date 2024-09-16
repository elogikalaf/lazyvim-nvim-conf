-- return {
--   {
--     "neovim/nvim-lspconfig",
--     opts = {
--       servers = {
--         ansiblels = {
--           settings = {
--             -- Disable ansible-lint
--             ansible = {
--               validation = {
--                 lint = {
--                   enabled = false,
--                 },
--               },
--             },
--           },
--           filetypes = {
--             "ansible",
--           },
--         },
--       },
--     },
--   },
-- }
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ansiblels = {
          settings = {
            -- Disable ansible-lint
            ansible = {
              validation = {
                lint = {
                  enabled = false,
                },
              },
            },
          },
          filetypes = {
            "ansible",
          },
        },
        yamlls = {
          -- Have to add this for yamlls to understand that we support line folding
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.yaml.schemas = vim.tbl_deep_extend(
              "force",
              new_config.settings.yaml.schemas or {},
              require("schemastore").yaml.schemas()
            )
          end,
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              keyOrdering = false,
              format = {
                enable = true,
              },
              validate = true,
              schemaStore = {
                -- Must disable built-in schemaStore support to use
                -- schemas from SchemaStore.nvim plugin
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
              },
            },
          },
          filetypes = {
            "yaml",
            "ansible",
            "yml",
          },
        },
      },
    },
  },
}
