"========================================================
" INSTALL PLUGINS
"
"========================================================
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

filetype off
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'easymotion/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'bruno-/vim-ruby-fold'
Plug 'tpope/vim-rails'
Plug 'flazz/vim-colorschemes'
Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'mbbill/undotree'
Plug 'ryanoasis/vim-devicons'
Plug 'janko-m/vim-test'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'matze/vim-move'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-scripts/git-time-lapse'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'w0rp/ale'
Plug 'pangloss/vim-javascript'
call plug#end()
syntax on
filetype on
filetype indent on
filetype plugin on
set hlsearch
set ai
set ruler
set linespace=1
set gfn=DejaVu\ Sans\ Mono\ for\ Powerline:h13
let g:auto_ctags = 1
set wrap linebreak nolist
set breakindent
set nofoldenable
set tags=./tags;,tags;
set ruler
set number
set expandtab
set autoindent
set clipboard=unnamed
set splitright
set splitbelow
set ttyfast
set lazyredraw
set laststatus=2
set encoding=utf8
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11
set background=dark
set textwidth=100
set relativenumber
set bs=2 tabstop=2 shiftwidth=2 softtabstop=2
colorscheme bubblegum
" Fix iterm display
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
"========================================================
" CONFIG AIRLINE
"========================================================
let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1
let g:airline_symbols = {}
let g:airline_symbols.space = "\ua0"
let g:airline_symbols.readonly = 'R'
let s:spc = g:airline_symbols.space
let g:airline_symbols.linenr = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#bufferline#overwrite_variables = 1
let g:bufferline_echo = 0
let g:bufferline_rotate = 1
let g:bufferline_fname_mod = ':f'
function! AirlineInit()
  let g:airline_section_a = airline#section#create(['%{toupper(mode())}'])
  let g:airline_section_b = airline#section#create([''])
  let g:airline_section_z = airline#section#create(['%3p%%', '|', 'linenr', ':%c '])
endfunction
"========================================================
" CONFIG ALE
"========================================================
let g:ale_fixers = {
\ 'ruby': ['rubocop']
\ }
let g:ale_lint_on_text_changed="never"
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_set_highlights = 0
let g:ale_set_loclist = 1
"let g:ale_set_quickfix = 1
map <silent> <leader>ln :ALENext<CR>
map <silent> <leader>lp :ALEPrevious<CR>
"========================================================
" CONFIG DEOPLETE
"========================================================
set completeopt+=noselect
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#json_directory = '~/deoplete-go'
let g:go_def_mode = "guru"
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 'ignorecase'
let g:deoplete#sources = {}
let g:deoplete#sources_ = ['buffer','tag']
" <Tab> completion:
" 1. If popup menu is visible, select and insert next item
" 2. Otherwise, if within a snippet, jump to next input
" 3. Otherwise, if preceding chars are whitespace, insert tab char
" 4. Otherwise, start manual autocomplete
imap <silent><expr><Tab> pumvisible() ? "\<C-n>"
\ : (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)"
\ : (<SID>is_whitespace() ? "\<Tab>"
\ : deoplete#mappings#manual_complete()))
smap <silent><expr><Tab> pumvisible() ? "\<C-n>"
\ : (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)"
\ : (<SID>is_whitespace() ? "\<Tab>"
\ : deoplete#mappings#manual_complete()))
inoremap <expr><S-Tab>  pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:is_whitespace() "{{{
let col = col('.') - 1
return ! col || getline('.')[col - 1] =~? '\s'
endfunction "}}}
"========================================================
" CONFIG GITGUTTER
"========================================================
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '*'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '-'
let g:gitgutter_sign_modified_removed = '_'
"========================================================
" CONFIG AUTO PAIR
"========================================================
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = '<M-b>'
let g:AutoPairsMultilineClose = 0
let g:indentLine_enabled = 0
"========================================================
" CONFIG MISC
"========================================================
" Tmux navigation
let g:tmux_navigator_no_mappings = 1
" Rpsec config
let test#strategy = "neovim"
" Solve vim ESC delay
set timeoutlen=1000 ttimeoutlen=0
if has("autocmd")
  autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
  autocmd FileType go set tabstop=8 shiftwidth=8 softtabstop=8
  autocmd FileType xml set equalprg=xmllint\ --format\ -
  autocmd VimEnter * call AirlineInit()
  autocmd VimEnter * AirlineTheme bubblegum
  autocmd BufWritePre * StripWhitespace
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
  autocmd FileType markdown set textwidth=80
  autocmd FileType markdown set formatoptions-=t
  autocmd Filetype cpp setlocal ts=4 sw=4 sts=0 expandtab
endif
let g:webdevicons_enable_ctrlp = 1
let g:move_key_modifier = 'C'
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.html.eex,*.html.erb"
let g:jsx_ext_required = 0
let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=node_modules'
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --ignore node_modules -l -g ""'
"========================================================
" FUNCTIONS
"========================================================
" Update ruby ctags
function! UpdateFullRubyTags()
  return system('ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)')
endfunction

function! UpdateRubyTags()
  return system('ctags -R --languages=ruby --exclude=.git --exclude=log .')
endfunction

function! UpdateElixirTags()
  return system('ctags -R --languages=elixir --exclude=.git --exclude=log .')
endfunction

" Toogle indents
function! IndentGuideToggle()
  let g:indent_guide_displayed = get(g:, 'indent_guide_displayed', '0')
  if g:indent_guide_displayed=='0'
    let g:indent_guide_displayed = '1'
    execute 'IndentLinesEnable'
    set colorcolumn=+1
  else
    let g:indent_guide_displayed = '0'
    execute 'IndentLinesDisable'
    set colorcolumn=0
  endif
endfunction
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
"========================================================
" MAPPING FZF
"========================================================
map <leader>f <ESC>:Files<CR>
map <leader>h <ESC>:History<CR>
map <Leader>b <ESC>:Buffers<CR>
map <silent> <leader>/ <ESC>:BLines<CR>
map <leader>ag <ESC>:Ag<space>
map <c-]> <ESC>:call fzf#vim#tags(expand("<cword>"))<cr>
map <silent> <leader>mm <ESC>:Commands<CR>
"========================================================
" MAPPING NERDTree
"========================================================
map <silent> <leader>ls <ESC>:NERDTreeToggle<CR>
map <silent> <leader>rev :NERDTreeFind<CR>
let NERDTreeMapOpenSplit = 'x'
let NERDTreeMapOpenVSplit = 'v'
"========================================================
" MAPPING RSPEC
"========================================================
map <Leader>tt :TestFile<CR>
map <Leader>ts :TestNearest<CR>
map <Leader>tl :TestLast<CR>
map <Leader>ta :TestSuite<CR>
let test#ruby#rspec#executable = 'bundle exec rspec'
"========================================================
" MAPPING EASYMOTION
"========================================================
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
nmap <silent> <tab> <Plug>(easymotion-w)
"========================================================
" MAPPING EASYALIGN
"========================================================
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
"========================================================
" MAPPING GIT
"========================================================
map <silent> gb :Gblame<CR>
map <silent> ghub :Gbrowse<CR>
map <silent> gy :call TimeLapse() <cr>
"========================================================
" MAPPING MISC
"========================================================
map <leader>urt <ESC>:call UpdateRubyTags()<CR>
map <leader>ufrt <ESC>:call UpdateFullRubyTags()<CR>
map <leader>uet <ESC>:call UpdateElixirTags()<CR>
nnoremap <silent> <Leader><CR> <ESC>:noh<CR>
map <silent> <leader>i <ESC>:call IndentGuideToggle()<CR>
map <silent> <leader>' cs'"
map <silent> <leader>" cs"'
map <silent> <leader><leader> <C-^><CR>
map <silent> <leader>u :UndotreeToggle<CR>
map <silent> <space>h <C-W><C-H>
map <silent> <space>j <C-W><C-J>
map <silent> <space>k <C-W><C-K>
map <silent> <space>l <C-W><C-L>
map <silent> <leader>wq <C-W>q
map <silent> <leader>path :let @+=@%<CR>
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
noremap <silent> <expr> ^ (v:count == 0 ? 'g^' : '^')
noremap <silent> <expr> $ (v:count == 0 ? 'g$' : '^')

nnoremap <leader>s :w<cr>
inoremap <leader>s <C-c>:w<cr>
if has("nvim")
  tnoremap <c-e> <C-\><C-n>
end
