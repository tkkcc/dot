local g = vim.g
local o = vim.o
o.dictionary = '/usr/share/dict/words'
g.kommentary_create_default_mappings = false
o.shell = '/bin/bash'
g.mapleader = ','
o.breakindent = true
o.hidden = true
o.cmdheight = 1
-- o.shortmess = vim.o.shortmess .. "c"
o.signcolumn = 'yes'
o.tgc = true
o.rulerformat = '%=%t'
o.statusline = '%=%=%t'
o.ls = 0
o.so = 7
o.ttm = 0
o.mouse = "a"
o.fencs = "ucs-bom,utf-8,gb2312,gb18030,gbk,cp936,default,latin1"
o.nf = vim.o.nf .. ",alpha"
o.sw = 2
o.ts = 2
o.nu = true
o.wrap = false
o.wb = false
o.swf = false
o.ic = true
o.scs = true
o.hls = true
o.is = true
o.lz = true
o.et = true
o.spell = false
o.spelllang = 'en_us,cjk'

local map = function(mode, lhs, rhs, opt)
  opt = opt or {noremap = true, silent = true}
  vim.api.nvim_set_keymap(mode, lhs, rhs, opt)
end

map('v', '<Tab>', '>gv')
map('v', '<S-Tab>', '<gv')
map('v', '>', '>gv')
map('v', '<', '<gv')

map('n', '<leader>d', 'mz"zyy"zp`zj', {noremap = false, silent = true})
map('v', '<leader>d', 'mz"zy"zP`z', {noremap = false, silent = true})
map('n', '<leader>D', 'mz"zyy"zP`zk<leader>cc`z',
    {noremap = false, silent = true})
map('v', '<leader>D', 'mz"zy"zP`[v`]<leader>c`z',
    {noremap = false, silent = true})
map('n', '<leader>s',
    ':set spell!<cr>:if exists("g:syntax_on") <bar> syntax off <bar> else <bar> syntax enable <bar> endif<cr>')
map('n', '<c-l>', ':noh<cr>')

map('n', '<leader>t', '<esc>:set ft=', {noremap = true})
map('n', '0', '^')
map('n', '-', '$')
map('c', '<c-a>', '<home>', {noremap = true})

map('c', '<c-k>', [[<C-\>e(strpart(getcmdline(), 0, getcmdpos() - 1))<cr>]],
    {noremap = true})
map('c', '<c-e>', '<end>', {noremap = true})
map('c', '<c-p>', '<up>', {noremap = true})
map('c', '<c-n>', '<down>', {noremap = true})
map('c', '<c-b>', '<left>', {noremap = true})
map('c', '<c-f>', '<right>', {noremap = true})
map('c', '<c-h>', '<backspace>', {noremap = true})

map('n', '<leader>m', [[mmHmt:%s/<c-v><cr>//ge<cr>'tzt'm]], {noremap = true})
map('n', '<leader>r', ":so $MYVIMRC<cr>", {noremap = true})
map('v', '<leader>s', ":sort", {noremap = true})
map('v', '<leader>S', ":!sort", {noremap = true})
map('n', '<leader>e', ":e!<cr>", {noremap = true})
map('n', '<leader>w', ":w!<cr>", {noremap = true})
map('v', '<leader>w', "<esc>w!<cr>", {noremap = true})
map('n', '<leader>x', ":x!<cr>", {noremap = true})
map('v', '<leader>x', "<esc>:x!<cr>", {noremap = true})
map('n', '<leader>q', ":q!<cr>", {noremap = true})
map('v', '<leader>q', "<esc>:q!<cr>", {noremap = true})
map('v', 'p', "pgvy", {noremap = true})
map('n', '<leader>y', [[mzgv"+y`z]], {noremap = true})
map('n', '<leader>{', [[i{<esc>la}<esc>h]], {noremap = true})
map('n', '<leader>#', [[:g/^\(#\|$\)/d]], {noremap = true})
-- --remove multi sapce ,remove empty lines ,space end, space start
-- -- nm <silent> <leader>z :retab<cr>:%s/ +/ /eg<cr>:g/^\s*$/d<cr><leader>n:%s/^\s\+//e<cr>:v/^\[\d\+\]/norm kJ<cr>:noh<cr>
map('n', '<backspace>', [[:cal DeleteLeft()<cr>]])
map('n', '<cr>', "i<cr><esc>l")
map('v', '<cr>', '"_s<cr>')
map('v', '<backspace>', '"_d')
map('n', 'Q', "@q")
map('v', 'Q', ":norm @q<cr>")
map('n', '<leader>n', [[mz:retab<cr>:%s/\s\+$//e<cr>`z:noh<cr>]])
map('n', '<leader>a', ":set wrap!<cr>")
map('n', '<leader><space>', ":call Load()<cr>")
map('n', '<c-c>', [[mzV"0y`z:call Yank(@0)<cr>]])
map('v', '<c-c>', [["0y:call Yank(@0)<cr>]])
map('v', '<c-x>', [["0d:call Yank(@0)<cr>]])
map('n', '<c-b>', [[mzgg"+yG`z'"']])

map('v', 'n', [[<tab> >gv]], {noremap = true})
map('v', '<S-tab>', [[<gv]], {noremap = true})
map('n', 'j', [[v:count ? 'j' : 'gj']], {noremap = true, expr = true})
map('n', 'k', [[v:count ? 'k' : 'gk']], {noremap = true, expr = true})
map('v', 'j', [[v:count ? 'j' : 'gj']], {noremap = true, expr = true})
map('v', 'k', [[v:count ? 'k' : 'gk']], {noremap = true, expr = true})
map('n', '<c-J>', [[mz:m .+1<CR>`z]], {noremap = true})
map('n', '<c-K>', [[mz:m .-2<CR>`z]], {noremap = true})
map('v', '<c-J>', [[:m '>+1<CR>gv=gv]], {noremap = true})
map('v', '<c-K>', [[:m '<-2<CR>gv=gv]], {noremap = true})
map('n', '<c-z>', [[<Nop>]], {noremap = true})
map('n', '<c-q>', [[<Nop>]], {noremap = true})
map('n', '<c-s>', [[<Nop>]], {noremap = true})
map('n', '<F1>', [[<Nop>]], {noremap = true})
map('n', '<c-e>', [[<c-u>]], {noremap = true})
map('v', '<c-e>', [[<c-u>]], {noremap = true})
map('n', '<a-e>', [[<c-u>]], {noremap = true})
map('n', '<a-d>', [[<c-d>]], {noremap = true})

map('n', '/', [[ms/]], {noremap = true})
map('n', '?', [[ms?]], {noremap = true})
map('n', 'dj', [[<nop>]], {noremap = true})
map('n', 'dk', [[<nop>]], {noremap = true})

map('n', '<leader>i', [[:Autoformat<cr>]])
map('v', '<leader>i', [[:Autoformat<cr>]])
-- map('n', '<space>i', [[:Autoformat<cr>]])
-- map('v', '<space>i', [[:Autoformat<cr>]])

map('n', 'H', [[:tabp<cr>]])
map('n', 'L', [[:tabn<cr>]])

map('n', '<space><space>',
    [[:wa!<cr>:silent ! tmux send -t {down-of} C-c up enter <cr>]])
map('v', '<space><space>',
    [[<esc>:wa!<cr>:silent ! tmux send -t {down-of} C-c up enter <cr>]])
map('n', '<space>1',
    [[:wa!<cr>:silent ! tmux send -t {down-of} C-c up up enter <cr>]])
map('v', '<space>1',
    [[:wa!<cr>:silent ! tmux send -t {down-of} C-c up up enter <cr>]])

map('v', '<leader>C', ':! column -t')

map('n', '*', [[viwms:<c-u>cal VisualSelection('', '')<cr>/<c-r>=@/<cr><cr>]])
map('n', '#', [[viwms:<c-u>cal VisualSelection('', '')<cr>?<c-r>=@/<cr><cr>]])
map('v', '*', [[ms:<c-u>cal VisualSelection('', '')<cr>/<c-r>=@/<cr><cr>]])
map('v', '#', [[ms:<c-u>cal VisualSelection('', '')<cr>?<c-r>=@/<cr><cr>]])

vim.cmd([[
ca w!! w !sudo tee "%"
com! W w !sudo tee % > /dev/null
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
au FocusLost * silent! wa
fu! DeleteLeft()
  if col('.')==1 | exe "normal! kgJ" | else | exe "normal! \"_dh" |endif
endf
fu! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  exe "normal! vgvy"
  let l:pattern = escape(@", "\\/.*'$^~[]")
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'gv'
    cal CmdLine("Ack '" . l:pattern . "' " )
  elseif a:direction == 'replace'
    cal CmdLine("%s" . '/'. l:pattern . '/')
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endf
fu! Yank(text) abort
  let escape = system('yank', a:text)
  if v:shell_error
    echo 1
  else
    call writefile([escape], '/dev/tty', 'b')
  endif
endf

autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd BufEnter */fontconfig/fonts.conf :setlocal filetype=xml
" autocmd BufEnter * if &filetype == "" | setlocal ft=sh | endif
autocmd FileType xdefaults setlocal commentstring=!\ %s
autocmd FileType fish setlocal commentstring=#\ %s

au FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif

if !exists('g:lasttab')
  let g:lasttab = 1
endif
nm <silent> <s-tab> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" filet plugin indent on
]])

local install_path = vim.fn.stdpath 'data' ..
                       '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' ..
                   install_path)
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]])

require('packer').init({max_jobs = 5})
require('packer').startup(function()
  use {
    "akinsho/toggleterm.nvim",
    opt = true,
    tag = 'v1.*',
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<a-v>]],
        shell = vim.env.SHELL,
        terminal_mappings = false,
      })
      function _G.set_terminal_keymaps()
        local opts = {noremap = true}
        -- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
        -- vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<a-q>', [[<C-\><C-n><C-W>w<a-v>]],
                                    {noremap = false})
        vim.api.nvim_buf_set_keymap(0, 't', '<a-h>', [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<a-j>', [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<a-k>', [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<a-l>', [[<C-\><C-n><C-W>l]], opts)
      end

      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

    end,
  }
  -- use {"zbirenbaum/copilot-cmp", after = {"copilot.lua", "nvim-cmp"}}
  -- use {
  --   "zbirenbaum/copilot.lua",
  --   event = {"VimEnter"},
  --   config = function()
  --     vim.defer_fn(function() require("copilot").setup() end, 100)
  --   end,
  -- }
  -- use 'github/copilot.vim'
  --   config = function()
  --     config = function()
  --       -- copilot assume mapped
  --       vim.g.copilot_assume_mapped = true
  --       vim.g.copilot_no_tab_map = true
  --     end
  --   end,
  -- }

  -- use {'lilydjwg/fcitx.vim', branch = 'fcitx5'}
  use 'h-hg/fcitx.nvim'

  use 'wellle/targets.vim'

  use {
    'wbthomason/packer.nvim',
    config = function()

      vim.api.nvim_set_keymap('n', '<leader>pc', ':PackerCompile<cr>',
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<leader>pi', ':PackerInstall<cr>',
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<leader>ps', ':PackerSync<cr>',
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<leader>pl', ':PackerClean<cr>',
                              {noremap = true, silent = true})
    end,
  }
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'

  use {
    'lambdalisue/suda.vim',
    config = function() vim.g.suda_smart_edit = 1 end,
  }

  use {
    'mcchrish/nnn.vim',
    config = function()
      vim.g["nnn#command"] = 'fish -c n'
      vim.g['nnn#set_default_mappings'] = 0
      -- opt = true,
    end,
  }

  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end,
    config = function()
      -- " ==> config for 节点精灵
      -- function! s:IsFirenvimActive(event) abort
      --   if !exists('*nvim_get_chan_info')
      --     return 0
      --   endif
      --   let l:ui = nvim_get_chan_info(a:event.chan)
      --   return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
      --       \ l:ui.client.name =~? 'Firenvim'
      -- endfunction

      -- let g:firenvim_config = {
      --     \ 'globalSettings': {
      --         \ 'alt': 'all',
      --     \  },
      --     \ 'localSettings': {
      --         \ '.*': {
      --             \ 'cmdline': 'neovim',
      --             \ 'content': 'text',
      --             \ 'priority': 0,
      --             \ 'selector': 'textarea',
      --             \ 'takeover': 'never',
      --         \ },
      --         \ '.*192\.168.*': {
      --             \ 'cmdline': 'neovim',
      --             \ 'content': 'text',
      --             \ 'priority': 1,
      --             \ 'selector': '#container textarea',
      --             \ 'takeover': 'always',
      --         \ }
      --     \ }
      -- \ }
      -- if exists('g:started_by_firenvim')
      -- nn <silent> <F5> :Autoformat<cr>:wa<cr>:call firenvim#eval_js('document.querySelector("#save").click();document.querySelector("#run_or_run").click();')<cr>
      -- im <silent> <F5> <esc><F5>
      -- nn <silent> H :w<cr>:call firenvim#eval_js('document.querySelector("#nav > .nav-present").previousElementSibling.click()')<cr>
      -- nn <silent> L :w<cr>:call firenvim#eval_js('document.querySelector("#nav > .nav-present").nextElementSibling.click()')<cr>

      -- "au TextChanged * ++nested write
      -- "au TextChangedI * ++nested write
      -- nn <c-c> "+Y
      -- vn <c-c> "+y
      -- nn <space>v "+p
      -- nn <leader>v "+p
      -- function! OnUIEnter() abort
      -- set guifont=monospace:h20
      -- endfunction
      -- autocmd UIEnter * call OnUIEnter()
      -- endif
    end,
    opt = true,
  }

  use {
    'mg979/vim-visual-multi',
    config = function()
      vim.g.VM_Mono_hl = 'Visual'
      vim.g.VM_Extend_hl = 'Visual'
      vim.g.VM_Cursor_hl = 'Visual'
      vim.g.VM_Insert_hl = 'Visual'
      vim.g.VM_maps = {
        ["Add Cursor Down"] = '<c-j>',
        ["Add Cursor Up"] = '<c-k>',
        ["Undo"] = 'u',
        ["Redo"] = '<C-r>',
      }
      vim.g.VM_mouse_mappings = 1
    end,
  }
  use 'honza/vim-snippets'

  -- use {
  --   'Chiel92/vim-autoformat',
  --   config = function()
  --     vim.g.formatters_html = {'prettier'}
  --     vim.g.formatters_javascript = {'prettier'}
  --     vim.g.formatdef_lua = '"lua-format -c $HOME/.config/lua-format/config "'
  --     vim.g.formatters_lua = {'lua'}
  --     vim.g.formatters_python = {'black'}
  --     vim.g.formatdef_cpp = '"clang-format"'
  --     vim.g.formatters_cpp = {'cpp'}
  --     vim.g.formatters_cuda = {'cpp'}
  --     vim.g.formatdef_fish = '"fish_indent"'
  --     vim.g.formatters_fish = {'fish'}
  --     vim.g.formatters_cuda = {'cpp'}
  --     vim.g.autoformat_autoindent = 0
  --     vim.g.autoformat_retab = 0
  --     vim.g.autoformat_remove_trailing_spaces = 0
  --   end,
  -- }

  use {
    opt = true,
    'theHamsta/nvim-dap-virtual-text',
    config = function()
      require("nvim-dap-virtual-text").setup {
        enabled = true, -- enable this plugin (the default)
        enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true, -- show stop reason when stopped for exceptions
        commented = false, -- prefix virtual text with comment string
      }
    end,
  }
  use {
    opt = true,
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')
      dap.adapters.python = {
        type = 'executable',
        command = 'python',
        args = {'-m', 'debugpy.adapter'},
      }
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = "Launch file",
          program = "${file}",
        }, {
          type = 'python',
          request = 'launch',
          name = "run_val",
          program = "${workspaceFolder}/run_val.py",
          args = {
            '-m', "debug_PC_v7", "-r", "real_frame2frame_perframe_slice",
            "--video-slice-from", "data/Lenovo0906/亚特兰蒂斯酒店",
            "--inter-frame-num", '1', '--frame-slice', '0-100',
          },
        },
      }
      require('dap.ext.vscode').load_launchjs()
      vim.api.nvim_set_keymap('n', '<space>dc',
                              ":lua require'dap'.continue()<CR>",
                              {noremap = true, silent = false})
      vim.api.nvim_set_keymap('n', '<F5>', ":lua require'dap'.continue()<CR>",
                              {noremap = true, silent = false})

      vim.api.nvim_set_keymap('n', '<F4>',
                              ":lua require'dap'.run_to_cursor()<CR>",
                              {noremap = true, silent = false})
      vim.api.nvim_set_keymap('n', '<space>dt',
                              ":lua require'dap'.run_to_cursor()<CR>",
                              {noremap = true, silent = false})

      vim.api.nvim_set_keymap('n', '<space>di',
                              ":lua require'dap'.step_into()<CR>",
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<F11>', ":lua require'dap'.step_into()<CR>",
                              {noremap = true, silent = true})

      vim.api.nvim_set_keymap('n', '<space>do',
                              ":lua require'dap'.step_over()<CR>",
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<F10>', ":lua require'dap'.step_over()<CR>",
                              {noremap = true, silent = true})

      vim.api.nvim_set_keymap('n', '<space>dO',
                              ":lua require'dap'.step_out()<CR>",
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space><F10>',
                              ":lua require'dap'.step_out()<CR>",
                              {noremap = true, silent = true})

      vim.api.nvim_set_keymap('n', '<space>dI',
                              ":lua require'dap'.step_back()<CR>",
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space><F11>',
                              ":lua require'dap'.step_back()<CR>",
                              {noremap = true, silent = true})

      vim.api.nvim_set_keymap('n', '<space>db',
                              ":lua require'dap'.toggle_breakpoint()<CR>",
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<F9>',
                              ":lua require'dap'.toggle_breakpoint()<CR>",
                              {noremap = true, silent = true})

      vim.api.nvim_set_keymap('n', '<space>dB',
                              ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space><F9>',
                              ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
                              {noremap = true, silent = true})

      vim.api.nvim_set_keymap('n', '<space>dp',
                              ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>dr',
                              ":lua require'dap'.repl.open()<CR>",
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<F2>',
                              ":lua require'dap'.repl.toggle()<CR>",
                              {noremap = true, silent = true})

      vim.api.nvim_set_keymap('n', '<space>dl',
                              ":lua require'dap'.run_last()<CR>",
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<F6>', ":lua require'dap'.run_last()<CR>",
                              {noremap = true, silent = true})

      vim.api.nvim_set_keymap('n', '<space>du', ":lua require'dap'.up()<CR>",
                              {noremap = true, silent = false})
      vim.api.nvim_set_keymap('n', '<space>dd', ":lua require'dap'.down()<CR>",
                              {noremap = true, silent = false})
    end,
  }

  use 'michaeljsmith/vim-indent-object'
  use 'jeetsukumaran/vim-indentwise'
  use 'tpope/vim-surround'
  use {
    'numToStr/Navigator.nvim',
    config = function()
      -- Configuration
      require('Navigator').setup()
      vim.api.nvim_set_keymap('n', "<a-h>",
                              "<cmd>lua require('Navigator').left()<cr>",
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', "<a-k>",
                              "<cmd>lua require('Navigator').up()<cr>",
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', "<a-l>",
                              "<cmd>lua require('Navigator').right()<cr>",
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', "<a-j>",
                              "<cmd>lua require('Navigator').down()<cr>",
                              {noremap = true, silent = true})
    end,
  }

  use {'dhruvasagar/vim-table-mode'}

  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app & yarn install',
    config = function()
      vim.g.mkdp_open_to_the_world = 1
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_open_ip = '127.0.0.1'
      vim.g.mkdp_preview_options = {disable_sync_scroll = 0}
    end,
    setup = function() vim.g.mkdp_filetypes = {"markdown"} end,
    ft = {"markdown"},
  }
  use 'google/vim-searchindex'
  use {
    'junegunn/vim-easy-align',
    config = function()
      vim.api.nvim_set_keymap('v', 'ga', '<Plug>(EasyAlign)',
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)',
                              {noremap = true, silent = true})
    end,
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require("null-ls")
      local F = null_ls.builtins.formatting
      null_ls.setup({
        sources = {
          F.shfmt.with({extra_args = {'-i', 2}}), F.lua_format.with({
            extra_args = {'-c', vim.env.HOME .. '/.config/lua-format/config'},
          }), F.prettier, F.fish_indent, F.black,
          -- F.rustfmt.with({extra_args = {"--edition=2021"}}),
        },
      })
      vim.api.nvim_set_keymap('n', '<space>i',
                              '<cmd>lua vim.lsp.buf.format{async=true}<cr>',
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('v', '<space>i',
                              '<cmd>lua vim.lsp.buf.format{async=true}<cr>',
                              {noremap = true, silent = true})
    end,
  }

  use 'nvim-treesitter/playground'
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require'nvim-treesitter.configs'.setup {
        textobjects = {
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
            },
          },
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["ad"] = "@conditional.outer",
              ["id"] = "@conditional.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",

              -- Or you can define your own textobjects like this
              -- ["iF"] = {
              --   python = "(function_definition) @function",
              --   cpp = "(function_definition) @function",
              --   c = "(function_definition) @function",
              --   java = "(method_declaration) @function",
              -- },
            },
          },
        },
      }

    end,
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {},
        highlight = {enable = false},
        indent = {enable = false},
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "=",
            node_incremental = "=",
            scope_incremental = "+",
            node_decremental = "-",
          },
        },
      }
    end,
  }

  use {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require'treesitter-context'.setup {
        enable = true,
        max_lines = 5,
        throttle = true,
      }
    end,
  }

  use {
    'neovim/nvim-lspconfig',

    requires = {'hrsh7th/cmp-nvim-lsp'},
    config = function()

      local nvim_lsp = require('lspconfig')

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)

        -- Enable completion triggered by <c-x><c-o>
        vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
        map = function(mode, lhs, rhs, opt)
          opt = opt or {noremap = true, silent = true}
          vim.api.nvim_set_keymap(mode, lhs, rhs, opt)
        end

        -- Mappings.
        map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
        map('n', '<space>I', '<cmd>lua vim.lsp.buf.implementation()<CR>')
        map('n', '<space>S', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
        map('n', '<space>t', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
        map('n', '<space>n', '<cmd>lua vim.lsp.buf.rename()<CR>')
        map('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
        map('n', '<space>E', '<cmd>lua vim.diagnostic.open_float()<CR>')
        map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
        map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
      end

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      nvim_lsp.tsserver.setup({
        -- Needed for inlayHints. Merge this table with your settings or copy
        -- it from the source if you want to add your own init_options.
        -- init_options = require("nvim-lsp-ts-utils").init_options,
        capabilities = capabilities,
        on_attach = on_attach,
          -- local ts_utils = require("nvim-lsp-ts-utils")
          -- ts_utils.setup({})
          -- ts_utils.setup_client(client)
          -- on_attach(client, bufnr)
          -- client.resolved_capabilities.document_formatting = false
          -- client.resolved_capabilities.document_range_formatting = false
          -- client.server_capabilities.documentFormattingProvider
        -- end,
        flags = {debounce_text_changes = 150},

      })

      nvim_lsp.volar.setup {
        filetypes = { 'vue' },

        capabilities = capabilities,
        on_attach = on_attach,
        flags = {debounce_text_changes = 150},
      }

      nvim_lsp.ccls.setup {
        filetypes = {"c", "cpp", "objc", "objcpp", "cuda"},
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {debounce_text_changes = 150},
      }

      -- nvim_lsp.clangd.setup {
      --   capabilities = capabilities,
      --   on_attach = on_attach,
      --   flags = {debounce_text_changes = 150},
      -- }

      nvim_lsp.jedi_language_server.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {debounce_text_changes = 150},
      }

      local rust_config = {
        checkOnSave = {
          enable = true,
          extraArgs = {"--target-dir", os.getenv('E') .. "/rust_analyzer_check"},
        },
      }
      if vim.fn.getcwd() == "/home/bilabila/bin/eframe_template" then
        rust_config["cargo"] = {target = "wasm32-unknown-unknown"}
      end
      nvim_lsp.rust_analyzer.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {debounce_text_changes = 150},
        settings = {["rust-analyzer"] = rust_config},
      }

      nvim_lsp.bashls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {debounce_text_changes = 150},
      }

      -- require'lspconfig'.lua_ls.setup{}

      -- local sumneko_root_path = "/usr/share/lua-language-server"
      -- local sumneko_binary = "lua-language-server"
      require'lspconfig'.lua_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {debounce_text_changes = 150},
        -- cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
        settings = {
          Lua = {
            completion = {keywordSnippet = "Disable"},

            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              -- version = 'LuaJIT',
              -- Setup your lua path
              -- path = runtime_path,
              unicodeName = true,
            },

            diagnostics = {
              neededFileStatus = {
                ["lowercase-global"] = "None",
                ["undefined-global"] = "None",
              },
              -- Get the language server to recognize the `vim` global
              globals = {'vim'},
            },
            workspace = {
              preloadFileSize = 1000,
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false},
          },
        },
      }
    end,
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp', 'andersevenrud/cmp-tmux', 'dcampos/cmp-snippy',
      'dcampos/nvim-snippy', 'hrsh7th/cmp-calc',
    },
    config = function()
      vim.o.completeopt = "menu,menuone,noselect"
      local snippy = require("snippy")
      local cmp = require 'cmp'
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and
                 vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,
                                                                            col)
                   :match("%s") == nil
      end
      cmp.setup({
        snippet = {
          expand = function(args)
            require'snippy'.expand_snippet(args.body) -- For `snippy` users.
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<c-l>'] = cmp.mapping(function(fallback)
            if snippy.can_expand_or_advance() then
              snippy.expand_or_advance()
            else
              fallback()
            end
          end, {"i", "s"}),
          ['<c-h>'] = cmp.mapping(function(fallback)
            if snippy.snippy.can_jump(-1) then
              snippy.previous()
            else
              fallback()
            end
          end, {"i", "s"}),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif snippy.can_expand_or_advance() then
              snippy.expand_or_advance()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, {"i", "s"}),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif snippy.can_jump(-1) then
              snippy.previous()
            else
              fallback()
            end
          end, {"i", "s"}),
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
          ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
          ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          -- Accept currently selected item. If none selected, `select` first item.
          -- Set `select` to `false` to only confirm explicitly selected items.
          ['<CR>'] = cmp.mapping.confirm({select = false}),
        }),
        sources = cmp.config.sources({
          {name = 'snippy'}, {name = 'nvim_lsp'},
          {name = 'buffer', option = {keyword_pattern = [[\k\+]]}},
          {name = 'path'}, {name = 'tmux'}, {name = 'calc'},
        }),
        -- completion = {keyword_pattern = [[\k\+]]},
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({'/', '?'}, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {{name = 'buffer'}},
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}}),
      })

    end,
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      -- vim.g.nvim_tree_highlight_opened_files = 3
      vim.o.cul = true
      -- vim.g.nvim_tree_show_icons = {
      --   git = 0,
      --   folders = 1,
      --   files = 1,
      --   folder_arrows = 1,
      -- }
      vim.api.nvim_set_keymap('n', '<space>e', ':NvimTreeToggle<cr>',
                              {noremap = true, silent = true})
      local tree_cb = require'nvim-tree.config'.nvim_tree_callback
      require'nvim-tree'.setup({
        git = {enable = false},
        update_focused_file = {enable = true, update_root = false},
        renderer = {
          icons = {
            webdev_colors = false,
            git_placement = "before",
            padding = " ",
            symlink_arrow = "->",
            show = {
              file = false,
              folder = false,
              folder_arrow = false,
              git = false,
            },
          },
        },
        view = {
          mappings = {
            list = {
              {key = "H", cb = ":tabp<cr>"},
              {key = "D", cb = tree_cb("toggle_dotfiles")},

            },
          },
        },
      })
    end,
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end,
  }

  -- use 'JoosepAlviste/nvim-ts-context-commentstring'

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        toggler = {line = '<leader>cc', block = '<leader>bc'},
        opleader = {line = '<leader>c', block = '<leader>b'},
        extra = {above = '<leader>cO', below = '<leader>co', eol = '<leader>cA'},
      })
    end,
  }

  -- use {
  --   'marko-cerovac/material.nvim',
  --   config = function()
  --     vim.g.background = light
  --     vim.g.material_style = 'lighter'
  --     -- vim.g.background = dark
  --     -- vim.g.material_style = 'darker'
  --     require('material').setup({
  --       high_visibility = {lighter = true, darker = true},
  --     })
  --     vim.cmd([[colorscheme material]])
  --
  --   end,
  --   cond = function() return vim.env.TERM ~= 'linux' end,
  -- }

  use {
    "projekt0n/github-nvim-theme",
    config = function()
      require("github-theme").setup({theme_style = "light"})
    end,
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {["<esc>"] = require('telescope.actions').close},
            n = {["<esc>"] = require('telescope.actions').close},
          },
        },
      }

      vim.api.nvim_set_keymap('n', '<space>f',
                              [[<Cmd>lua require('telescope.builtin').find_files()<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>F',
                              [[<Cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>g',
                              [[<Cmd>lua require('telescope.builtin').live_grep()<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>w',
                              [[<Cmd>lua require('telescope.builtin').grep_string()<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>m',
                              [[<Cmd>lua require('telescope.builtin').oldfiles({cwd_only=true})<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>M',
                              [[<Cmd>lua require('telescope.builtin').oldfiles()<cr>]],
                              {noremap = true, silent = true})
      -- vim.api.nvim_set_keymap('n', '<space>a',
      --                         [[<Cmd>lua require('telescope.builtin').help_tags()<cr>]],
      --                         {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>q',
                              [[<Cmd>lua require('telescope.builtin').diagnostics()<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>s',
                              [[<Cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>]],
                              {noremap = true, silent = true})
      -- vim.api.nvim_set_keymap('n', '<space>d',
      --                         [[<Cmd>lua require('telescope.builtin').lsp_definitions()<cr>]],
      --                         {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', 'gd',
                              [[<Cmd>lua require('telescope.builtin').lsp_definitions()<cr>]],
                              {noremap = true, silent = true})
      -- vim.api.nvim_set_keymap('n', '<space>r',
      --                         [[<Cmd>lua require('telescope.builtin').lsp_references()<cr>]],
      --                         {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', 'gr',
                              [[<Cmd>lua require('telescope.builtin').lsp_references()<cr>]],
                              {noremap = true, silent = true})
      -- vim.api.nvim_set_keymap('n', '<space>rg',
      --                         [[<Cmd>lua require('telescope.builtin').registers()<cr>]],
      --                         {noremap = true, silent = true})
      -- vim.api.nvim_set_keymap('n', '<space>n',
      --                         [[<Cmd>lua require('telescope.builtin').file_browser()<cr>]],
      --                         {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>p',
                              [[<Cmd>lua require('telescope.builtin').spell_suggest()<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>k',
                              [[<Cmd>lua require('telescope.builtin').keymaps()<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>x',
                              [[<Cmd>lua require('telescope.builtin').quickfix()<cr>]],
                              {noremap = true, silent = true})
      -- vim.api.nvim_set_keymap('n', '<space>b',
      --                         [[<Cmd>lua require('telescope.builtin').buffers()<cr>]],
      --                         {noremap = true, silent = true})
      -- vim.api.nvim_set_keymap('n', '<space>a',
      --                         [[<Cmd>lua require('telescope.builtin').lsp_code_actions()<cr>]],
      --                         {noremap = true, silent = true})
    end,
  }

  use {
    'svermeulen/vim-yoink',
    config = function()
      vim.api.nvim_set_keymap('n', 'p',
                              "yoink#canSwap() ? '<plug>(YoinkPostPasteSwapBack)' : '<plug>(YoinkPaste_p)'",
                              {expr = true, silent = true})
      vim.api.nvim_set_keymap('n', 'P',
                              "yoink#canSwap() ? '<plug>(YoinkPostPasteSwapForward)' : '<plug>(YoinkPaste_P)'",
                              {expr = true, silent = true})
      vim.g.yoinkIncludeDeleteOperations = 1
      vim.g.yoinkSavePersistently = 1
    end,
  }
end)
