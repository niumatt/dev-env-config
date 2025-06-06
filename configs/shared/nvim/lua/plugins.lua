local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    "tanvirtin/monokai.nvim",
{
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets' },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'default' },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = false } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
},
{ 
    "mason-org/mason.nvim", 
    opts = {
        ui = {
            check_outdated_packages_on_open = true,
            border = "rounded",
            width = 0.8,
            height = 0.9,
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        },
        install_root_dir = vim.fn.stdpath("data") .. "/mason",
        pip = {
            upgrade_pip = true,
        },
        log_level = vim.log.levels.INFO,
        max_concurrent_installers = 4,
    }
},
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = { 
                "pylsp",           -- Python
                "rust_analyzer",   -- Rust
                "ts_ls",           -- TypeScript/JavaScript
                "html",            -- HTML
                "cssls",           -- CSS
                "jsonls",          -- JSON
                "clangd",          -- C/C++
                "yamlls",          -- YAML
                "marksman",        -- Markdown
            },
        },
    },
    {
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			-- Python - 增强第三方库支持
			lspconfig.pylsp.setup({
				settings = {
					pylsp = {
						plugins = {
							-- 启用更多插件以支持第三方库
							pycodestyle = { enabled = false }, -- 禁用风格检查以减少干扰
							pyflakes = { enabled = true },
							pylint = { enabled = false },
							jedi_completion = { 
								enabled = true,
								include_params = true, -- 显示函数参数
								include_class_objects = true,
								fuzzy = true, -- 模糊匹配
							},
							jedi_hover = { enabled = true },
							jedi_references = { enabled = true },
							jedi_signature_help = { enabled = true },
							jedi_symbols = { enabled = true },
						},
					},
				},
			})
			
			-- Rust - 优化第三方库支持
			lspconfig.rust_analyzer.setup({
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true, -- 加载构建脚本输出
						},
						procMacro = {
							enable = true, -- 启用过程宏支持
						},
						checkOnSave = {
							command = "clippy",
						},
						completion = {
							addCallArgumentSnippets = true,
							addCallParenthesis = true,
						},
						hover = {
							actions = {
								enable = true,
								references = true,
							},
						},
					},
				},
			})
			
			-- TypeScript/JavaScript - 增强第三方库支持
			lspconfig.ts_ls.setup({
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
						},
					},
				},
			})
			
			-- HTML
			lspconfig.html.setup({
				filetypes = { "html", "htmldjango" },
			})
			
			-- CSS
			lspconfig.cssls.setup({})
			
			-- JSON
			lspconfig.jsonls.setup({})
			
			-- C/C++
			lspconfig.clangd.setup({
				cmd = { "clangd", "--background-index" },
				filetypes = { "c", "cpp", "cc", "cxx", "c++", "objc", "objcpp" },
			})
			
			-- YAML
			lspconfig.yamlls.setup({
				settings = {
					yaml = {
						schemas = {
							["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
						},
					},
				},
			})
			
			-- Markdown
			lspconfig.marksman.setup({})
		end,
	},
    {
    "folke/tokyonight.nvim",
    lazy = false, -- 确保在启动时加载
    priority = 1000, -- 确保首先加载
    config = function()
      vim.cmd[[colorscheme tokyonight-night]]
    end,
  },

  -- 🌳 语法高亮 (Tree-sitter)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
                  ensure_installed = { 
            "lua", "python", "javascript", "typescript", "html", "css", "json", 
            "markdown", "bash", "vim", "yaml", "toml", "rust", "c", "cpp",
            "go", "php", "ruby", "java", "kotlin"
          },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- 💡 自动补全
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- 📁 文件浏览器
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
        },
        filters = {
          dotfiles = false,
        },
      })
      
      -- 快捷键
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "切换文件树" })
    end,
  },

  -- 🔍 模糊查找器
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
      
      -- 快捷键
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "查找文件" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "搜索内容" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "查找缓冲区" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "帮助标签" })
    end,
  },

  -- 📊 状态栏
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
        },
      })
    end,
  },

  -- 🔗 Git 集成
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })
      
      -- Git 快捷键
      vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "Git blame" })
      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "预览更改" })
    end,
  },

  -- 🔤 智能括号
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
      
      -- 与 nvim-cmp 集成
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- 💬 注释插件
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  }
})
