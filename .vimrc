set nocompatible " Don't care about vi compatibility

"-------------------------------------
" airline options
"-------------------------------------
set laststatus=2        
filetype plugin indent on
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline_theme="solarized"
let g:airline_powerline_fonts = 1

"-------------------------------------
" YouCompleteMe options
"-------------------------------------
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
map <leader>= :YcmCompleter FixIt<CR>

"-------------------------------------
" Syntastic options
"-------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_bash_checkers = ['sh']
let g:syntastic_ruby_checkers = ['rubylint']
let g:syntastic_cpp_compiler = ['g++']
let g:syntastic_cpp_checkers = ['g++']
let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic"
"let g:syntastic_cpp_check_header = 1

"-------------------------------------
" vimplug options
"-------------------------------------
call plug#begin()
"Plug 'marijnh/tern_for_vim', { 'do': 'npm install' } " javascript autocomplete
"Plug 'https://github.com/Townk/vim-autoclose.git'       " auto-match braces
"Plug 'https://github.com/edsono/vim-matchit.git'
Plug 'jiangmiao/auto-pairs'
Plug 'nvie/vim-flake8'                                                           " Pep8 linting for python
"Plug 'tmhedberg/SimpylFold'                                                     " folding for python
Plug 'scrooloose/syntastic'                                                      " General linter
"Plug 'scrooloose/nerdtree'                                                      " Project navigation
Plug 'vim-airline/vim-airline'                                           " Pretty, fast
"Plug 'davidhalter/jedi-vim'                                             " Python autocomplete"Plug 'dag/vim2hs'                                                                       " Haskell syntax/linting
"Plug 'pangloss/vim-javascript'                                          " javascript syntax/folds
Plug 'dag/vim-fish'                                                                      " fish syntax highlighting
Plug 'morhetz/gruvbox'                               " color theme
Plug 'vim-airline/vim-airline-themes'                " themes for decor
"Plug 'Valloric/YouCompleteMe'                        " omnifunc autocomplete
"   Installed via AUR
" Plug 'starcraftman/vim-eclim'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " YCM alternative
" Plug 'artur-shaik/vim-javacomplete2'                 " java autocomplete
call plug#end()

"-------------------------------------
" vim-jedi options
"-------------------------------------
"let g:jedi#force_py_version=3

"-------------------------------------
" SimplyFold options
"-------------------------------------
let g:SimplyFold_docstring_preview = 1

"-------------------------------------
" Leader mapping - Space is always
" accessible by either thumb.
"-------------------------------------
let mapleader =" "
nnoremap <Space> <Nop>

"-------------------------------------
" color and appearance
"-------------------------------------
syntax enable                                           " Enable syntax highlighting.
"set t_Co=256                                           " Use 256 colors (max for term/tmux).
set background=dark                                     " Use a dark background.
let g:gruvbox_italic=1                          " Use italics with gruvbox theme.
colorscheme gruvbox
set termguicolors

"allow italic text (vim; nvim ignores this)
set t_ZH=
set t_ZR=

"-------------------------------------
" Tabs, indents, menus, highlighting
"-------------------------------------
set tabstop=4                                           " How many spaces is an existing tab.
set softtabstop=4                                       " How many spaces is a new tab.
set expandtab                                           " Turn tabs into spaces.
set shiftwidth=4                                        " Indent by equivalent of 4 spaces.
set smartindent                                         " Insert indents intelligently.
set number                                                      " View line numbers.
set relativenumber                                      " View relative line numbers.
"set cursorline                                         " Underline current cursor line.
set wildmenu                                            " Autocomplete menu.
let python_highlight_all = 1

" Highlight text past column 80
highlight OverLength ctermbg=grey guibg=#444444
match OverLength /\%80v.\+/

" Toggle relative numbers (return to absolute numbers).
nmap <silent> <leader>n :setlocal relativenumber!<Enter>

"-------------------------------------
" code folding
"-------------------------------------
"set foldmethod=syntax
"set foldlevel=99
"nnoremap <leader>f za

"-------------------------------------
" compiling and running code
"-------------------------------------
filetype on
filetype indent on

function CompileAndRun ()   " Checks file type and compiles/runs.
    :w
    if (&ft == 'c')
        :!clear; gcc % -o %:r; echo -e "\nOutput:\n"; ./%:r
    elseif (&ft == 'cpp')
        :!clear; g++ % -o %:r; echo -e "\nOutput:\n"; ./%:r
    elseif getline(1) =~ '^#!.*\<python3\>'
        :!clear; echo -e "\n\nOutput:\n"; python3 %
    elseif (&ft == 'python')
        :!clear; echo -e "\n\nOutput:\n"; python %
    elseif (&ft == 'markdown')
        :silent execute "!markdown % > %:r.html &" | redraw!
        elseif (&ft == 'java')
                :!clear; javac %; echo "\n\nOutput:\n"; java %:r
        elseif (&ft == 'javascript')
                :!clear; echo -e "\n\nOutput:\n"; node % --harmony
        elseif (&ft == 'haskell')
        :!clear; ghc % -o %:r; echo -e "\nOutput:\n"; ./%:r
    elseif (&ft == 'scheme')
        :!clear; echo -e "\nOutput:\n"; racket %;
    endif
endfunction

map <F5> :call CompileAndRun()<Enter>

"-------------------------------------
" Save and upload HTML files to server
"-------------------------------------
"function SaveAndUploadMunro ()
"       :w
"       :!clear; scp % n01100239@munro.humber.ca:~/public_html
"endfunction
"
"function SaveAndUploadAltervista ()
"       :w
"       :!clear; ncftpput -utssoti -pianh1188 ftp.tssoti.altervista.org / %
"endfunction

"map <silent><leader>sm :call SaveAndUploadMunro()<Enter>
"map <silent><leader>sa :call SaveAndUploadAltervista()<Enter>

"-------------------------------------
" Time saving preparations for coding.
"-------------------------------------
function PrepareForC ()
        call append("0","#include <stdio.h>")
        call append("2","int main(void)")
        call append("3","{")
        call append("4","}")
endfunction

function PrepareForCpp ()
        call append("0","#include <iostream>")
        call append("2","int main(void)")
        call append("3","{")
        call append("4","}")
endfunction

function PrepareForJava ()
        call append("0","/**")
        call append("1"," * @author")
        call append("2"," * @version")
        call append("3"," */")
        call append("5","class "  . expand("%:t:r"))
        call append("6","{")
        call append("7","       public static void main(String argv[])")
        call append("8","       {")
        call append("9","       }")
        call append("10","}")
endfunction

function PrepareForHTML ()
        call append("0","<!DOCTYPE html>")
        call append("2","<HTML>")
        call append("3","       <HEAD>")
        call append("4","               <TITLE></TITLE>")
        call append("5","               <LINK REL='stylesheet' TYPE='text/css' HREF=''>")
        call append("6","       </HEAD>")
        call append("7","       <BODY>")
        call append("8","       </BODY>")
        call append("9","</HTML>")
endfunction

nmap <silent> <leader>pc :call PrepareForC()<Enter>
nmap <silent> <leader>pp :call PrepareForCpp()<Enter>
nmap <silent> <leader>pj :call PrepareForJava()<Enter>
nmap <silent> <leader>ph :call PrepareForHTML()<Enter>

"-------------------------------------
" moving, searching, patterns
"-------------------------------------
set ignorecase      " Ignore case when searching.
set incsearch       " Highlight pattern matches while typing.
set smartcase       " Override ignorecase when search has uppercase character.
set hlsearch        " Highlight all matches of a search.

" Turn off highlights (once done searching).
map <silent> <leader>h :noh<CR> 

" Go to next/previous tab.
map <silent> <leader>t gT
map <silent> <leader>y gt

" Horizontally split window and switch to new split.
map <silent> <leader>w :split<CR> <C-w>w

" Vertically split window and switch to new split.
map <silent> <leader>e :vsplit<CR> <C-w>w

" Make a new tab.
map <silent> <leader>mt :tabnew<CR>

" Cycle through windows
map , <C-w>w<ESC>

" To fix slow scrolling over ssh.
"set ttyfast
"set ttyscroll=1

" Insert blank lines in normal mode.
map <C-o> :normal o<CR><ESC>


"------------------------------------
" Filetype specific conditions.
"------------------------------------

" Turn off tabs to spaces in makefiles, in case it is turned on elsewhere.
autocmd FileType make setlocal noexpandtab

" This lets Eclim and YouCompleteMe play nice together.
"autocmd FileType java EclimEnable
"autocmd FileType java let g:EclimCompletionMethod = 'omnifunc'

" These are the omnifunc autocomplete options built into vim.
filetype plugin on
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" Haskell indentation
autocmd FileType haskell set expandtab
autocmd FileType haskell set softtabstop=2
autocmd FileType haskell set shiftwidth=2
autocmd FileType haskell set shiftround
autocmd FileType haskell abbrev -> ➞
autocmd FileType haskell abbrev :: ∷

" Javascript
autocmd FileType javascript set expandtab
autocmd FileType javascript set softtabstop=2
autocmd FileType javascript set shiftwidth=2
autocmd FileType javascript set shiftround

" Scheme
autocmd FileType scheme set expandtab
autocmd FileType scheme set softtabstop=2
autocmd FileType scheme set shiftwidth=2
autocmd FileType scheme set shiftround

" fish
autocmd FileType fish compiler fish

" ruby
autocmd FileType ruby set expandtab
autocmd FileType ruby set softtabstop=2
autocmd FileType ruby set shiftwidth=2
autocmd FileType ruby set shiftround

" use deoplete
"let g:deoplete#enable_at_startup = 1
