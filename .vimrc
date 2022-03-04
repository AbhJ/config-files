set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" PLUGINS

call vundle#begin()
Plugin 'tibabit/vim-templates'
Plugin 'udalov/kotlin-vim'
Plugin 'wakatime/vim-wakatime'
Plugin 'pangloss/vim-javascript'
Plugin 'preservim/nerdcommenter'
Plugin 'morhetz/gruvbox'
Plugin 'itchyny/lightline.vim'
call vundle#end()            " required

filetype plugin indent on    " required
filetype plugin on

" REMEMBER POSITITON OF CURSOR LAST TIME

if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

let g:lightline = { 
                  \ 'colorscheme': 'gruvbox',
                  \ 'active': {
                  \   'left': [ ['mode'],
                  \             ['fugitive', 'readonly', 'filename'], ['modified', 'devicons_filetype'] ],
                  \   'right': [ ['mylineinfo'], ['percent'],['filetype'], ['linter_errors', 'linter_warnings', 'linter_ok']]
                  \ },
                  \ 'component_function': {
                  \   'mylineinfo': "MyLineinfo",
                  \ },
                  \ 'tab_component_function': {
                  \ },
                  \ 'component': {
                  \   'readonly': '%{&filetype=="help"?"":&readonly?"\ue0a2":""}',
                  \   'modified': '%{&filetype=="help"?"":&modified?"\ue0a0":&modifiable?"":"-"}',
                  \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
                  \ },
                  \ 'component_visible_condition': {
                  \   'readonly': '(&filetype!="help"&& &readonly)',
                  \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
                  \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
                  \ },
                  \ }

"                  \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
"                  \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
function! MyLineinfo()
      return line('.') . '/' . line('$') . ':' . col('.')
endfunction

set relativenumber
syntax enable
filetype plugin indent on

if (has("termguicolors"))
      set termguicolors
endif

colorscheme gruvbox
" set cursorline

" DEFINING FUNCTIONS
function Sing()
      :read ~/.vim/templates/cp_in_cpp_templates/sing.cpp
endfunction
function Mult()
      :read ~/.vim/templates/cp_in_cpp_templates/mult.cpp
endfunction
function Goog()
      :read ~/.vim/templates/cp_in_cpp_templates/goog.cpp
endfunction
function Modulo()
      :read ~/.vim/templates/cp_in_cpp_templates/Modulo.cpp
endfunction
" function! Toggle_transparent_background()                                                       
    " hi Normal guibg=NONE ctermbg=NONE                                                           
" endfunction                                                                                     
" nnoremap <C-t><C-b> :call Toggle_transparent_background()<CR> 
hi Normal guibg=NONE ctermbg=NONE                                                           
" SETTING TABS INSTEAD OF SPACES AND TAB == 4 SPACES
set tabstop=4
set noshowmode
set shiftwidth=4
set smartcase
set autoread " FILE IS REFRESHED IF EDITED BY OTHER TEXT EDITOR
set paste " NO COMMENT EXTENSION AFTER GOING TO NEW LINE
set mouse=a
map <LeftMouse> <nop>
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>


" MAPPING KEYBOARD SHORTCUTS
nmap >> <Nop>
nmap << <Nop>
vmap >> <Nop>
vmap << <Nop>
nnoremap <Tab>   >>
nnoremap <S-Tab> <<
vnoremap <Tab>   >><Esc>gv
vnoremap <S-Tab> <<<Esc>gv

" SPLIT MANAGEMENT
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" FORMAT JAVA AND C++
map <C-f> :TemplateExpand<CR>:%!astyle --indent=force-tab=4 -xe -xj -A2 -y -xg -p -xd -xb -Y -k3 -W3 -xW -H -U<CR>

" CP BUILD COMMAND
map <C-b> :TemplateExpand<CR>:%!astyle --indent=force-tab=4 -xe -xj -A2 -y -xg -p -xd -xb -Y -k3 -W3 -xW -H -U<CR>:w<CR>:!time g++ -std=c++20 -Wall -Wextra -O2 -pthread -H -I . % -o runfile && timeout 1.5s /usr/bin/time -v ./runfile <input.txt> output.txt && rm runfile<CR>

map <C-\> <leader>c<space><CR>
vmap <C-\> <leader>cs<CR>
let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
