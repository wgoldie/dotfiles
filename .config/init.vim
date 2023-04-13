let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

call plug#begin()
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  "Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'AckslD/nvim-neoclip.lua'
  Plug 'tami5/sqlite.lua'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
  Plug 'RRethy/nvim-base16'
  Plug 'gaborvecsei/memento.nvim'
  Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'sunjon/Shade.nvim'
  Plug 'SmiteshP/nvim-navic'
  Plug 'utilyre/barbecue.nvim'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'f-person/git-blame.nvim'
  Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
  " Plug 'romgrk/barbar.nvim'
  Plug 'neovim/nvim-lspconfig'
  " Plug 'jose-elias-alvarez/typescript.nvim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'dense-analysis/ale'
call plug#end()
let g:deoplete#enable_at_startup = 1


let mapleader=","
nnoremap <leader>ll <cmd>CocDiagnostics<CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fy <cmd>Telescope command_history<cr>
nnoremap <leader>fu <cmd>Telescope search_history<cr>
nnoremap <leader>mh <cmd>lua require('memento').toggle()<CR>
colorscheme base16-3024

filetype plugin indent on    " indent file based on type

set background=dark
colorscheme base16-bright

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

if has("termguicolors")
    set termguicolors
endif

set shiftwidth=2 tabstop=2 softtabstop=2
set expandtab
set number
set showcmd     

set lazyredraw " reduce visual noise and speed up macros
set showmatch " brace match anim

set incsearch " highlight while typing
set hlsearch " highlight matches


nnoremap j gj
nnoremap k gk

let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#quickfix_enabled = 0



let g:ale_enabled = 1

" Use MyPy for Python files
let g:ale_linters = {
\   'python': ['mypy', 'black'],
\}


" Set the location of the Black executable
let g:ale_python_black_executable = '/opt/homebrew/bin/black'
let g:ale_fix_on_save = 1
" Enable formatting on save
let g:ale_fixers = {
\   'python': ['black'],
\}

" Set the location of the Black executable for formatting
let g:ale_fixer_python_black_executable = '/opt/homebrew/bin/black'


" Set the location of the MyPy executable
let g:ale_python_mypy_executable = '/opt/homebrew/bin/mypy'

" Enable error highlighting
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
highlight ALEErrorSign ctermbg=red guibg=red
highlight ALEWarningSign ctermbg=yellow guibg=yellow

" note: need to do more LSP setup
"
lua << EOF
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  vim.opt.termguicolors = true
  require("nvim-tree").setup {
  }
  local function open_nvim_tree(data)

	  -- buffer is a directory
	  local directory = vim.fn.isdirectory(data.file) == 1

	  if not directory then
	    return
	  end

	  -- change to the directory
	  vim.cmd.cd(data.file)

	  -- open the tree
	  require("nvim-tree.api").tree.open()
	end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
  require("telescope").load_extension "neoclip"
  require("neoclip").setup {
    history = 1000,
    enable_persistent_history = true,
    preview = true,
  }
  require('telescope').load_extension('fzy_native')
  require('telescope').setup {
    defaults = {
      mappings = {
        i = {
		
		["<C-Down>"] = require('telescope.actions').cycle_history_next,
		["<C-Up>"] = require('telescope.actions').cycle_history_prev,
	    }
	}
    },
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                         -- the default case_mode is "smart_case"
      }
    }
  }
  

require'shade'.setup({
  overlay_opacity = 90,
  opacity_step = 1,
  keys = {
    brightness_up    = '<C-Up>',
    brightness_down  = '<C-Down>',
    toggle           = '<Leader>s',
  }
})

  require('telescope').load_extension('fzf')
  require("barbecue.ui").toggle(true)
  

  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {'mode'},
      
      lualine_b = {
        {
          'diagnostics',

          -- Table of diagnostic sources, available sources are:
          --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
          -- or a function that returns a table as such:
          --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
          sources = { 'nvim_diagnostic', 'coc' },

          -- Displays diagnostics for the defined severity types
          sections = { 'error', 'warn', 'info', 'hint' },

          diagnostics_color = {
            -- Same values as the general color option can be used here.
            error = 'DiagnosticError', -- Changes diagnostics' error color.
            warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
            info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
            hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
          },
          symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
          colored = true,           -- Displays diagnostics status in color if set to true.
          update_in_insert = false, -- Update diagnostics in insert mode.
          always_visible = false,   -- Show diagnostics even if there are none.
        }
      },
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  }
  -- require("typescript").setup({})
EOF
