{
  config,
  pkgs,
  lib,
  username,
  ...
}:
{
  home-manager.users.${username} = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      # LSP and tooling dependencies
      extraPackages = with pkgs; [
        # LSP servers
        lua-language-server
        nil # Nix LSP
        nodePackages.typescript-language-server
        nodePackages.vscode-langservers-extracted # HTML, CSS, JSON, ESLint

        # Formatters
        nixfmt-rfc-style
        prettierd
        stylua

        # Tools
        ripgrep
        fd
      ];

      plugins = with pkgs.vimPlugins; [
        # Theme
        {
          plugin = catppuccin-nvim;
          type = "lua";
          config = ''
            require("catppuccin").setup({
              flavour = "mocha",
              transparent_background = true,
            })
            vim.cmd.colorscheme "catppuccin"
          '';
        }

        # File tree
        {
          plugin = neo-tree-nvim;
          type = "lua";
          config = ''
            require("neo-tree").setup({
              close_if_last_window = true,
              filesystem = {
                follow_current_file = { enabled = true },
              },
            })
            vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file tree" })
          '';
        }
        nvim-web-devicons
        plenary-nvim

        # Fuzzy finder
        {
          plugin = telescope-nvim;
          type = "lua";
          config = ''
            local telescope = require("telescope")
            telescope.setup({})
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
          '';
        }

        # Syntax highlighting
        {
          plugin = nvim-treesitter.withAllGrammars;
          type = "lua";
          config = ''
            require("nvim-treesitter.configs").setup({
              highlight = { enable = true },
              indent = { enable = true },
            })
          '';
        }

        # LSP
        {
          plugin = nvim-lspconfig;
          type = "lua";
          config = ''
            local lspconfig = require("lspconfig")

            -- Keymaps on attach
            vim.api.nvim_create_autocmd("LspAttach", {
              callback = function(args)
                local opts = { buffer = args.buf }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
              end,
            })

            -- LSP servers
            lspconfig.lua_ls.setup({})
            lspconfig.nil_ls.setup({})
            lspconfig.ts_ls.setup({})
          '';
        }

        # Autocompletion
        {
          plugin = nvim-cmp;
          type = "lua";
          config = ''
            local cmp = require("cmp")
            cmp.setup({
              sources = {
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "path" },
              },
              mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
              }),
            })
          '';
        }
        cmp-nvim-lsp
        cmp-buffer
        cmp-path

        # Status line
        {
          plugin = lualine-nvim;
          type = "lua";
          config = ''
            require("lualine").setup({
              options = {
                theme = "catppuccin",
              },
            })
          '';
        }

        # Git integration
        {
          plugin = gitsigns-nvim;
          type = "lua";
          config = ''
            require("gitsigns").setup()
          '';
        }

        # Autopairs
        {
          plugin = nvim-autopairs;
          type = "lua";
          config = ''
            require("nvim-autopairs").setup({})
          '';
        }

        # Comment
        {
          plugin = comment-nvim;
          type = "lua";
          config = ''
            require("Comment").setup()
          '';
        }

        # Which-key
        {
          plugin = which-key-nvim;
          type = "lua";
          config = ''
            require("which-key").setup({})
          '';
        }
      ];

      extraLuaConfig = ''
        -- Leader key
        vim.g.mapleader = " "
        vim.g.maplocalleader = " "

        -- Options
        vim.opt.number = true
        vim.opt.relativenumber = true
        vim.opt.mouse = "a"
        vim.opt.showmode = false
        vim.opt.clipboard = "unnamedplus"
        vim.opt.breakindent = true
        vim.opt.undofile = true
        vim.opt.ignorecase = true
        vim.opt.smartcase = true
        vim.opt.signcolumn = "yes"
        vim.opt.updatetime = 250
        vim.opt.timeoutlen = 300
        vim.opt.splitright = true
        vim.opt.splitbelow = true
        vim.opt.list = true
        vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
        vim.opt.inccommand = "split"
        vim.opt.cursorline = true
        vim.opt.scrolloff = 10
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
        vim.opt.expandtab = true
        vim.opt.termguicolors = true

        -- Keymaps
        vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
        vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to left window" })
        vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to right window" })
        vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to lower window" })
        vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to upper window" })
      '';
    };
  };
}
