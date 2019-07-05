" generate-dotfiles 2017-05-07 begin
set nocompatible

inoremap fd <Esc>
cnoremap fd <Esc>
" inoremap <esc> <nop>

set timeoutlen=500
set tabstop=2 expandtab shiftwidth=2 softtabstop=2

filetype plugin indent on
syntax on
set background=dark
let g:solarized_termcolors=256
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme paramountblue

let mapleader=" "
let maplocalleader=" "
set visualbell t_vb=

" prefix mapping
nnoremap <Leader>wj <C-W>j
nnoremap <Leader>wk <C-W>k
nnoremap <Leader>wl <C-W>l
nnoremap <Leader>wh <C-W>h
nnoremap <Leader>wc <C-W>c
nnoremap <Leader>ws <C-W>s
nnoremap <Leader>wv <C-W>v
nnoremap <Leader>w= <C-W>=
nnoremap <Leader>wo <C-W>o

nnoremap <C-W>j :echo "Use [space]wj"<CR>
nnoremap <C-W>k :echo "Use [space]wk"<CR>
nnoremap <C-W>l :echo "Use [space]wl"<CR>
nnoremap <C-W>h :echo "Use [space]wh"<CR>
nnoremap <C-W>c :echo "Use [space]wc"<CR>
nnoremap <C-W>s :echo "Use [space]ws"<CR>
nnoremap <C-W>v :echo "Use [space]wv"<CR>
nnoremap <C-W>= :echo "Use [space]w="<CR>
nnoremap <C-W>o :echo "Use [space]0o"<CR>

" go shortcuts
nnoremap <Leader>gr :GoRun<CR>
nnoremap <Leader>gb :GoBuild<CR>
nnoremap <Leader>gf :GoFmt<CR>
nnoremap <Leader>gi :GoImports<CR>

set hidden " don't warn about unsaved buffer

set relativenumber
set number
set numberwidth=2

set ignorecase
set smartcase

set hlsearch
" make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>

set noesckeys

set cursorline

" disable existing cursorline styles like underlining
highlight CursorLine cterm=NONE

" highlight current line number green
highlight CursorLineNR ctermfg=112

au InsertEnter * highlight Cursorline ctermbg=233
au InsertEnter * highlight CursorLineNR ctermfg=196

au InsertLeave * highlight Cursorline ctermbg=none
au InsertLeave * highlight CursorLineNR ctermfg=112

highlight MatchParen ctermbg=235 ctermfg=118
highlight Search ctermbg=52
highlight Visual ctermbg=235
highlight SpellBad ctermbg=88
highlight SignColumn ctermbg=none
highlight SyntasticErrorSign ctermfg=88

nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

set autoread

set shiftround

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
xmap \ <Plug>Commentary
nmap \ <Plug>CommentaryLine

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'tpope/vim-abolish'

" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" noremap <Leader>u :UltiSnipsEdit<CR>

" Plug 'kien/ctrlp.vim', {'on': 'CtrlP'}
" noremap <silent> <leader>t :CtrlP<CR>

Plug 'scrooloose/nerdtree', {'on':  'NERDTreeToggle'}
silent! nnoremap <silent> <Leader>p :NERDTreeToggle<CR>

Plug 'jlanzarotta/bufexplorer', {'on': 'BufExplorer'}
nnoremap <leader>b :BufExplorer<cr>

" Plug 'bronson/vim-trailing-whitespace'
" Plug 'pangloss/vim-javascript', {'for': 'javascript'}
" Plug 'vim-ruby/vim-ruby', {'for': 'ruby'}

" Plug 'mxw/vim-jsx'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
noremap <silent> <leader>t :GFiles<CR>

Plug 'fatih/vim-go'
" noremap <silent> <leader>t :GFiles<CR>

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

  " Plug 'junegunn/goyo.vim'

" Plug 'flowtype/vim-flow'
Plug 'rafi/awesome-vim-colorschemes'

Plug 'jremmen/vim-ripgrep'
noremap <silent> <leader>g :Rg<CR>
call plug#end()
" generate-dotfiles 2017-05-07 end
