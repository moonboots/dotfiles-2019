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

" set cursorline

" highlight current line number green
highlight CursorLineNR ctermfg=112
highlight CursorLine ctermbg=none
highlight CursorLineNR ctermbg=none
" highlight Cursor ctermbg=124
highlight Cursor ctermfg=124
" highlight iCursor ctermbg=124

highlight MatchParen ctermbg=235 ctermfg=118
highlight Search ctermbg=52
highlight Visual ctermbg=56
highlight SpellBad ctermbg=88
highlight SignColumn ctermbg=none
highlight SyntasticErrorSign ctermfg=88

set autoread

set shiftround

call plug#begin('~/.vim/plugged')
  Plug 'tpope/vim-commentary'
  xmap \ <Plug>Commentary
  nmap \ <Plug>CommentaryLine

  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'

  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-fugitive'

  " Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
  " noremap <Leader>u :UltiSnipsEdit<CR>

  Plug 'scrooloose/nerdtree', {'on':  'NERDTreeToggle'}
  silent! nnoremap <silent> <Leader>p :NERDTreeToggle<CR>

  " Plug 'jlanzarotta/bufexplorer', {'on': 'BufExplorer'}
  " nnoremap <leader>b :BufExplorer<cr>

  " Plug 'pangloss/vim-javascript', {'for': 'javascript'}
  Plug 'vim-ruby/vim-ruby', {'for': 'ruby'}
  Plug 'tpope/vim-rails', {'for': 'ruby'}
  Plug 'leafgarland/typescript-vim', {'for': 'typescript'}

  " Plug 'mxw/vim-jsx'

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  Plug 'fatih/vim-go'

  " Command for git grep
  " - fzf#vim#grep(command, with_column, [options], [fullscreen])
  command! -bang -nargs=* GGrep
    \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

  " Plug 'flowtype/vim-flow'
  " Plug 'rafi/awesome-vim-colorschemes'

  Plug 'jremmen/vim-ripgrep'

  Plug 'benmills/vimux'
  noremap <silent> <leader>g :Rg<CR>

  " Plug 'ngmy/vim-rubocop', {'for': 'ruby'}
  Plug 'w0rp/ale'
call plug#end()
" generate-dotfiles 2017-05-07 end

" SHORTCUTS
nnoremap <leader>snp :set nopaste<cr>
nnoremap <leader>sp :set paste<cr>

" fzf
noremap <silent> <leader>t :Files<CR>
noremap <silent> <leader>fg :GFiles<CR>
noremap <silent> <leader>fa :Files<CR>
noremap <silent> <leader>b :Buffers<CR>

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

nnoremap <C-W>j :echoe "use wj"<CR>
nnoremap <C-W>k :echoe "use wk"<CR>
nnoremap <C-W>l :echoe "use wl"<CR>
nnoremap <C-W>h :echoe "use wh"<CR>
nnoremap <C-W>c :echoe "use wc"<CR>
nnoremap <C-W>s :echoe "use ws"<CR>
nnoremap <C-W>v :echoe "use wv"<CR>
nnoremap <C-W>= :echoe "use w="<CR>
nnoremap <C-W>o :echoe "use wo"<CR>

" go shortcuts
" nnoremap <Leader>gr :GoRun<CR>
function! JackGoRun()
  call VimuxInterruptRunner()
  call VimuxRunCommand("go run " . @%)
endfunction
nnoremap <Leader>gr :call JackGoRun()<CR>
nnoremap <Leader>gb :GoBuild<CR>
nnoremap <Leader>gf :GoFmt<CR>
nnoremap <Leader>gi :GoImports<CR>
" autocmd FileType go autocmd BufWritePre <buffer> call GoFmt()
augroup go
  autocmd FileType go autocmd BufWritePre <buffer> GoFmt
  autocmd FileType go autocmd BufWritePre <buffer> GoImports
augroup END

nnoremap <Leader>vr :source ~/.vimrc<CR>
nnoremap <Leader>ve :e ~/.vimrc<CR>

" nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>ev :echoe "use ve"<CR>
" nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>sw :Rg <cword><CR>

set backupdir=.backup/,~/.backup/,/tmp//
set directory=.swp/,~/.swp/,/tmp//
set undodir=.undo/,~/.undo/,/tmp//
