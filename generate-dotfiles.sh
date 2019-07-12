#!/bin/sh
# generate dot files
# TODO generate function to print colors, separate file is easier
#   inline colors into this gen script for usage prompt
# suffix filename with date instead of trying to insert inline
# history -a/history -r bash

set -eu

version="generate-dotfiles 2017-05-07"

hostname=$1
color=$2
gray=238

[ ! -f ~/.gitignore_global ] &&
  echo "Downloading gitignore" &&
  curl -fLo ~/.gitignore_global \
  'https://www.gitignore.io/api/vim%2Cnode'

file=~/.gitconfig
[ ! -f $file ] && touch $file
! grep -q -F "$version" $file && \
  echo "Updating $file" && \
  cat <<EOF >> $file
# $version begin
[user]
        email = <jack.zhang>
        name = Jack Zhang
[push]
        default = simple
[core]
        excludesfile = $HOME/.gitignore_global
# $version end
EOF

file=~/.bash.jack
[ ! -f $file ] && touch $file
! grep -q -F "$version" $file && \
  echo "Updating $file" && \
  cat <<EOF >> $file
# $version begin
# custom prompt
color="\[\e[38;05;${color}m\]"
gray="\[\e[38;05;${gray}m\]"
end="\[\e[0m\]"
PS1="\n\$gray\w\$end\n\${color}$ \$end"

export TERM=screen-256color
export EDITOR=vim

# aliases
alias gcm='git commit -m'
alias glg='git log --graph --oneline --decorate --all'
alias gap='git add -p'
alias gai='git add -i'
alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias gf="git diff --name-only | uniq | xargs vim -"
alias ls='ls --color=auto'
# $version end
EOF

original_dir=$PWD
tmux_res_dir=~/.dotfiles/tmux-resurrect

[ ! -d $tmux_res_dir ] && \
  echo "Cloning $tmux_res_dir" && \
  mkdir -p $(dirname $tmux_res_dir) && \
  cd ~/.dotfiles && \
  git clone https://github.com/tmux-plugins/tmux-resurrect.git && \
  cd tmux-resurrect && \
  git reset --hard b8cc90a7f4db209d6c25d4156f8f236eec3b1dca && \
  cd $original_dir

tmux_status_extra_space=""
tmux -V | grep -q "tmux 2." && tmux_status_extra_space=" "

# tmux >= 1.9 has new syntax
# TODO for tmux < 1.9, bind %|"_ without pane_current_path
# old versions of tmux dont support colors
tmux_open_in_same_dir="
bind c run 'tmux new-window -c \"#{pane_current_path}\"'
bind-key '%' split-window -hc \"#{pane_current_path}\"
bind-key '|' split-window -hc \"#{pane_current_path}\"
bind-key '\"' split-window -vc \"#{pane_current_path}\"
bind-key '_' split-window -vc \"#{pane_current_path}\"
"
tmux -V | grep -q -E "tmux 1.[0-8]" && tmux_open_in_same_dir="
set-option default-path \"\$PWD\"
"

file=~/.tmux.conf
[ ! -f $file ] && touch $file
# file=~/.tmux.conf
! grep -q -F "$version" $file && \
  echo "Updating $file" && \
  cat <<EOF >> $file
# $version begin
set-option -g prefix C-j
bind-key j send-prefix
set -g base-index 1
set -s escape-time 0
setw -g aggressive-resize on
set -g status-left "[$hostname]${tmux_status_extra_space}"
set -g status-right ""
set -g status-interval 0

set -g window-status-current-fg colour${color}
set -g pane-border-fg colour${gray}
set -g pane-active-border-fg colour${color}
set -g display-panes-colour colour${color}
set -g display-panes-active-colour colour${color}
set -g status-fg colour236

set-window-option -g window-status-format '#I:#W'
set-window-option -g window-status-current-format '#I:#W'

set -g status-bg default
set -g status-fg white

bind-key -n M-1 select-window -t 1
bind-key -n M-2 select-window -t 2
bind-key -n M-3 select-window -t 3
bind-key -n M-4 select-window -t 4
bind-key -n M-5 select-window -t 5
bind-key -n M-6 select-window -t 6
bind-key -n M-7 select-window -t 7
bind-key -n M-8 select-window -t 8
bind-key -n M-9 select-window -t 9
bind-key -n M-0 select-window -t 10

set-window-option -g mode-keys vi

# bind-key -n C-Up resize-pane -U 5
# bind-key -n C-Left resize-pane -L 5
# bind-key -n C-Right resize-pane -R 5
# bind-key -n C-Down resize-pane -D 5

# Use Alt-vim keys without prefix key to switch panes
bind -n M-h select-pane -L
bind -n M-j select-pane -D
bind -n M-k select-pane -U
bind -n M-l select-pane -R

run-shell $tmux_res_dir/resurrect.tmux

$tmux_open_in_same_dir
# vim: set ft=sh:
# $version end
EOF

[ ! -f ~/.vim/autoload/plug.vim ] &&
  echo "Downloading plug.vim" &&
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/f7e6a86807a1f0be7257620a8c425e1a32f877bb/plug.vim

file=~/.vim/colors/cs.vim
[ ! -f $file ] &&
  echo "Downloading $file" &&
  curl -fLo $file --create-dirs \
  https://raw.githubusercontent.com/altercation/vim-colors-solarized/528a59f26d12278698bb946f8fb82a63711eec21/colors/solarized.vim

file=~/.vimrc
[ ! -f $file ] && touch $file
# file=~/.tmux.conf
! grep -q -F "$version" $file && \
  echo "Updating $file" && \
  cat <<EOF >> $file
" $version begin
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
colorscheme cs

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
nnoremap <Leader>o= <C-W>o

nnoremap <C-W>j :echo "Use [space]wj"<CR>
nnoremap <C-W>k :echo "Use [space]wk"<CR>
nnoremap <C-W>l :echo "Use [space]wl"<CR>
nnoremap <C-W>h :echo "Use [space]wh"<CR>
nnoremap <C-W>c :echo "Use [space]wc"<CR>
nnoremap <C-W>s :echo "Use [space]ws"<CR>
nnoremap <C-W>v :echo "Use [space]wv"<CR>
nnoremap <C-W>= :echo "Use [space]w="<CR>
nnoremap <C-W>o :echo "Use [space]0o"<CR>

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

nnoremap <leader>ev :e \$MYVIMRC<cr>
nnoremap <leader>sv :source \$MYVIMRC<cr>

set autoread

set shiftround

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
xmap \ <Plug>Commentary
nmap \ <Plug>CommentaryLine

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'tpope/vim-abolish'

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
noremap <Leader>u :UltiSnipsEdit<CR>

Plug 'kien/ctrlp.vim', {'on': 'CtrlP'}
noremap <silent> <leader>t :CtrlP<CR>

Plug 'scrooloose/nerdtree', {'on':  'NERDTreeToggle'}
silent! nnoremap <silent> <Leader>p :NERDTreeToggle<CR>

Plug 'jlanzarotta/bufexplorer', {'on': 'BufExplorer'}
nnoremap <leader>b :BufExplorer<cr>

Plug 'bronson/vim-trailing-whitespace'
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'vim-ruby/vim-ruby', {'for': 'ruby'}

Plug 'mxw/vim-jsx'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
noremap <silent> <leader>t :GFiles<CR>

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

  " Plug 'junegunn/goyo.vim'

Plug 'flowtype/vim-flow'
call plug#end()
" $version end
EOF
