cal plug#begin('$C/nvim/plugged')
Plug 'dylanaraps/wal.vim'
Plug 'honza/vim-snippets'
Plug 'Chiel92/vim-autoformat'
Plug 'lilydjwg/fcitx.vim', {'on':[]}
Plug 'scrooloose/nerdcommenter'
Plug 'michaeljsmith/vim-indent-object'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'wellle/context.vim'
Plug 'google/vim-searchindex'
Plug 'terryma/vim-expand-region'
Plug 'junegunn/vim-easy-align'
" Plug 'npxbr/glow.nvim', {'do': ':GlowInstall'}
cal plug#end()
nn <space>e :CocCommand explorer<CR>
let g:context_enabled = 1
let g:context_add_mappings=0
let g:context_nvim_no_redraw = 1

" ======== run <Plug> funcation
":execute "normal \<Plug>NiceCenterCursor"

" ===== status bar
"set rulerformat=%60(%=%{get(b:,'coc_current_function','')}\ %t%)
"set statusline=%=%60(%=%{get(b:,'coc_current_function','')}\ %t\ %)
"set rulerformat=%60(%=%t%)
set rulerformat=%=%t
set statusline=%=%=%t\ 
set ls=0

" =========== visual-multi
let g:VM_Mono_hl    = 'TODO'
let g:VM_Extend_hl = 'TODO'
let g:VM_Cursor_hl = 'TODO'
let g:VM_Insert_hl = 'TODO'
let g:VM_maps={}
let g:VM_maps["Add Cursor Down"] = '<c-j>'
let g:VM_maps["Add Cursor Up"] = '<c-k>'
let g:VM_maps["Undo"] = 'u'
let g:VM_maps["Redo"] = '<C-r>'
let g:VM_mouse_mappings = 1
"let g:VM_leader = ','

" ============= color
function! MyHighlights() abort
  hi IncSearch ctermfg=0 ctermbg=3 cterm=None
  highlight StatusLine ctermfg=None ctermbg=0 cterm=None
  highlight StatusLineNC ctermfg=None ctermbg=0 cterm=None
endfunction
augroup MyColors
  autocmd!
  autocmd ColorScheme * call MyHighlights()
augroup END
colorscheme wal

let g:mapleader=","
set shell=/bin/bash
set so=7 ttm=0 mouse=a fencs=ucs-bom,utf-8,gb2312,gb18030,gbk,cp936,default,latin1
set nf+=alpha
set sw=2 ts=2 nu nowrap
set nowb noswf ic scs hls is lz et
set acd
set mousef
set noshowmode
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
fu! Load()
  cal plug#load('fcitx.vim')
endf
fu! Yank(text) abort
  let escape = system('yank', a:text)
  if v:shell_error
    echo 1
    "echoerr escape
  else
    "echo 2
    call writefile([escape], '/dev/tty', 'b')
  endif
endf
nn <leader>t <esc>:set ft=
nn 0 ^
nn <leader>m mmHmt:%s/<c-v><cr>//ge<cr>'tzt'm
nn <silent> <leader>n mz:retab<cr>:%s/\s\+$//e<cr>`z:noh<cr>
nn <silent> <leader>a :set wrap!<cr>
nn <leader>r :so $MYVIMRC<cr>
vn <leader>s :sort
vn <leader>S :!sort
nn <leader>e :e!<cr>
nn <leader>w :w!<cr>
vn <leader>w <esc>w!<cr>
nn <leader>x :x!<cr>
vn <leader>x <esc>:x!<cr>
nn <leader>q :q!<cr>
nn <silent> <leader><space> :call Load()<cr>
vn <leader>q <esc>:q!<cr>
xn p pgvy
nn <leader>d mz"zyy"zp`zj
vn <leader>d mz"zy"zP`z
no <silent> <leader><cr> :noh<cr>
nm <leader>D mz"zyy<leader>cc"zp`zj
vm <leader>D mz"zy`z"zpgv<leader>cc`z
nn <leader>y mzgv"+y`z
nn <silent> <leader>c mzgv"0y`z:call Yank(@0)<cr>
nn <leader>{ i{<esc>la}<esc>h
nn <leader># :g/^\(#\|$\)/d
"remove multi sapce ,remove empty lines ,space end, space start
nm <silent> <leader>z :retab<cr>:%s/ +/ /eg<cr>:g/^\s*$/d<cr><leader>n:%s/^\s\+//e<cr>:v/^\[\d\+\]/norm kJ<cr>:noh<cr>
" ==== this work?
vn <silent> * ms:<c-u>cal VisualSelection('', '')<cr>/<C-R>=@/<CR><CR>
vn <silent> # ms:<c-u>cal VisualSelection('', '')<cr>?<C-R>=@/<CR><CR>
nn <silent> <backspace> :cal DeleteLeft()<cr>
nn <cr> i<cr><esc>
vn <cr> "_s<cr>
vn <backspace> "_d
nn Q @q
vn Q :norm @q<cr>
cno <c-a> <home>
cno <c-e> <end>
cno <c-k> <c-u>
cno <c-p> <up>
cno <c-b> <left>
cno <c-n> <down>
cno <c-f> <right>
nn <silent> <c-c> mzV"0y`z:call Yank(@0)<cr>
vn <silent> <c-c> "0y:call Yank(@0)<cr>
vn <silent> <c-x> "0d:call Yank(@0)<cr>
nn <c-b> mzgg"+yG`z
vn <tab> >gv
vn <S-tab> <gv
nn <expr> j v:count ? 'j' : 'gj'
nn <expr> k v:count ? 'k' : 'gk'
vn <expr> j v:count ? 'j' : 'gj'
vn <expr> k v:count ? 'k' : 'gk'
nn <c-J> mz:m .+1<CR>`z
nn <c-K> mz:m .-2<CR>`z
vn <c-J> :m '>+1<CR>gv=gv
vn <c-K> :m '<-2<CR>gv=gv
nn <c-z> <Nop>
nn <c-q> <Nop>
nn <c-s> <Nop>
nn <F1> <Nop>
nn <c-e> <c-u>
vn <c-e> <c-u>
nn <a-e> <c-u>
nn <a-d> <c-d>

" ===== formatter
let g:formatters_html = ['prettier']
let g:formatdef_lua = '"lua-format -c $HOME/.config/lua-format/config "'
let g:formatters_lua = ['lua']
let g:formatters_python=['black']
let g:formatdef_cpp='"clang-format"'
let g:formatters_cpp=['cpp']
let g:formatdef_fish='"fish_indent"'
let g:formatters_fish=['fish']

let s:current_python_path=$HOME . '/miniconda3/bin/python3.7'
if exists("coc#config")
  call coc#config('python', {'pythonPath': s:current_python_path})
endif
set hidden
set cmdheight=1
set shortmess+=c
set signcolumn=yes
autocmd FileType json syntax match Comment +\/\/.\+$+


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
ino <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      "\ pumvisible() ? coc#_select_confirm() :
      "\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
ino <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
ino <silent><expr> <c-space> coc#refresh()
if exists('*complete_info')
  ino <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  ino <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
nm <silent> g[ <Plug>(coc-diagnostic-prev)
nm <silent> g] <Plug>(coc-diagnostic-next)
nm <silent> gd <Plug>(coc-definition)
nm <silent> gl <Plug>(coc-declaration)
nm <silent> gy <Plug>(coc-type-definition)
nm <silent> gi <Plug>(coc-implementation)
nm <silent> gr <Plug>(coc-references)
nm <silent> gn <Plug>(coc-refactor)
nm <c-f> :Files<cr>
nm <c-g> :Ag<cr>
nn <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nm <leader>rn <Plug>(coc-rename)
augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
xm if <Plug>(coc-funcobj-i)
om if <Plug>(coc-funcobj-i)
xm af <Plug>(coc-funcobj-a)
om af <Plug>(coc-funcobj-a)
xm ic <Plug>(coc-classobj-i)
om ic <Plug>(coc-classobj-i)
xm ac <Plug>(coc-classobj-a)
om ac <Plug>(coc-classobj-a)
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')
cnoreabbrev CC CocConfig
au FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif

let g:tmux_navigator_no_mappings = 1
nn <silent> <a-h> :TmuxNavigateLeft<cr>
nn <silent> <a-j> :TmuxNavigateDown<cr>
nn <silent> <a-k> :TmuxNavigateUp<cr>
nn <silent> <a-l> :TmuxNavigateRight<cr>
nn <silent> <a-\> :TmuxNavigatePrevious<cr>
nn <silent> <a-\> :TmuxNavigatePrevious<cr>

let g:coc_global_extensions = ['coc-pyright','coc-yaml','coc-json','coc-lists','coc-yaml',
      \'coc-snippets','coc-explorer','coc-yank', 'coc-spell-checker',
      \'coc-tsserver','coc-css','coc-project']
let g:mkdp_open_to_the_world = 1
let g:mkdp_echo_preview_url = 1

command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

nn <silent> <space>g :<c-u>CocList grep<cr>
nn <silent> <space>f :<c-u>CocList -S files<cr>
nn <silent> <space>b :<c-u>CocList -S buffers<CR>
nn <silent> <space>m :<c-u>CocList -S mru<CR>
nn <space>r :<c-u>CocSearch<space>
nn <silent> <space>l :<c-u>CocList lines<cr>
nn <silent> <space>a  :<c-u>CocList diagnostics<cr>
nn <silent> <space>c  :<c-u>CocList commands<cr>
nn <silent> <space>o  :<c-u>CocList outline<cr>
nn <silent> <space>s  :<c-u>CocList symbols<cr>
nn <silent> <space>w  :<c-u>CocList windows<cr>
nn <silent> <space>j  :<c-u>CocNext<CR>
nn <silent> <space>k  :<c-u>CocPrev<CR>
nn <silent> <space>p  :<c-u>CocListResume<CR>
nn <space><space> :<c-u>CocList<space>
nn <silent> <space>y  :<c-u>CocList --normal yank<cr>

nn <silent> <space>sa :<c-u>CocCommand cSpell.enableCurrentLanguage<cr>
nn <silent> <space>sd :<c-u>CocCommand cSpell.disableCurrentLanguage<cr>
nn <space>sw :<c-u>CocCommand cSpell.addWordToUserDictionary<cr>
nm <space>se <Plug>(coc-codeaction-selected)
nm <space>a <Plug>(coc-codeaction)
nm <space>q <Plug>(coc-fix-current)
if !exists('g:lasttab')
  let g:lasttab = 1
endif
nm <silent> <s-tab> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
autocmd VimLeavePre * :call coc#rpc#kill()
autocmd VimLeave * if get(g:, 'coc_process_pid', 0) | call system('kill -9 -'.g:coc_process_pid) | endif
nn / ms/
nn ? ms?
nm dj <nop>
nm dk <nop>
nm <silent> <leader>s :if exists("g:syntax_on") <Bar> syntax off <Bar> else <Bar> syntax enable <Bar> endif <CR>
im <C-l> <Plug>(coc-snippets-expand)
autocmd BufEnter *.fish :setlocal filetype=fish
autocmd BufEnter * if &filetype == "" | setlocal ft=conf | endif

let g:NERDCustomDelimiters = { 'text': { 'left': '#' },'systemd': { 'left': '#' },'rc': { 'left': '#' }, 'fish': { 'left': '#' } }
sy off
filet plugin indent on
"nm <expr> <leader>i index(['vim'], &filetype) >= 0 ?  CocActionAsync('format'):":Autoformat<cr>" 
nn <silent><expr> <leader>i ":Autoformat<cr>"
vn <silent><expr> <leader>i ":Autoformat<cr>"
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
"autocmd CursorHold * silent call CocActionAsync('highlight')
nn <silent> H :tabp<cr>
nn <silent> L :tabn<cr>
nn <silent> <leader>S :call CocAction("diagnosticToggle") <CR>
nn <silent> <F5> :wa!<cr>:silent ! tmux send -t {down-of} up enter <cr>
ino <silent> <F5> <esc><F5>
xn <silent> <F5> <esc><F5>
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
let g:formatters_cuda=['cpp']
vn <leader>C :! column -t
