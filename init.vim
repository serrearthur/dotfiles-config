"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set modeline                " Allow file specific Vim settings
set hidden                  " Keep changed buffers without requiring saves
set viewoptions=unix,slash  " Better Unix/Windows compatibility

set rtp+=/home/keupon/.config/nvim/bundle/Vundle.vim
call vundle#begin('/home/keupon/.config/nvim/bundle')
Plugin 'VundleVim/Vundle.vim'

Plugin 'kien/ctrlp.vim'                 " Fuzzy file search
Plugin 'benekastah/neomake'             " Build tool (mapped below to <c-b>)
Plugin 'Valloric/YouCompleteMe'         " Autocompletion for C/C++, Python, JavaScript
Plugin 'thirtythreeforty/lessspace.vim' " Remove extraneous whitespace when edit mode is exited
Plugin 'bling/vim-airline'              " Status bar plugin
Plugin 'vim-airline/vim-airline-themes' " Themes for the status bar
Plugin 'scrooloose/nerdtree'            " Filesystem explorer
Plugin 'blueyed/vim-qf_resize'          " Automatic resizing of quickfix/location windows

call vundle#end()

" Plugin configuration
"" NERDTree
map <F3> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Quit if last tab is a NerdTREE
" autocmd vimenter * NERDTree " NerdTREE on startup
" autocmd vimenter * wincmd p " We focus the file to edit rather than NERDTree

"" Airline powerline symbols
let g:airline_symbols = {}
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''

"" Neomake configuration
nnoremap <C-b> :w<cr>:Neomake<cr>:QfResizeWindows<cr>
let g:neomake_open_list = 2 	" Automatically open the error list
let g:neomake_bash_enabled_makers = ['shellcheck']		" Configuration for Bash
let g:neomake_sh_enabled_makers = ['shellcheck']		" Configuration for Shell
let g:neomake_javascript_enabled_makers = ['eslint'] 	" Configuration for JS
let g:neomake_python_enabled_makers = ['pylint']		" Configuration for Python
let g:neomake_c_enabled_makers = ['clang']				" Configuration for C
let g:neomake_c_clang_maker = {
   \ 'args': ['-Wall', '-Wextra', '-Weverything', '-pedantic'],
   \ }
let g:neomake_cpp_enabled_makers = ['clang']			" Configuration for C++
let g:neomake_cpp_clang_maker = {
   \ 'exe': 'clang++',
   \ 'args': ['-Wall', '-Wextra', '-Weverything', '-pedantic', '-Wno-sign-conversion'],
   \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search settings
set ignorecase " Ignore case when searching
set smartcase " When searching try to be smart about cases
set magic " For regular expressions turn magic on

" Show matching brackets when text indicator is over them
set showmatch
set mat=2 " How many tenths of a second to blink when matching brackets

" Always show status bar
set laststatus=2

" Let plugins show effects after 500ms, not 4s
set updatetime=500

" Configure mouse mode
set mouse=a

" Don't let autocomplete affect usual typing habits
set completeopt=menuone,preview,noinsert

" Identation settings. Tabs are replaced by 4 spaces
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent smartindent

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keybindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set up leader
let mapleader=","

" Toggle paste mode on and off
set pastetoggle=<F2>

" Use system clipboard
set clipboard+=unnamedplus

" <C-c> is used to copy selection in visual mode
vnoremap <C-c> "+y

" Corrected behaviour of <Del> key in normal mode
nnoremap <Del> "_x

" :W sudo saves the file (useful for handling the permission-denied error)
command W w !sudo tee > /dev/null %

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Useful mappings for managing tabs
map <leader>c :tabnew<cr>
map <leader>x :tabclose<cr>
map <leader>n :tabnext<cr>
map <leader>p :tabprevious<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <leader>l :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General color theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Height of the command bar
set cmdheight=2

" Color theme settings
" colorscheme pablo
let g:airline_theme='luna'
set number
set cursorline
set background=dark
hi LineNr ctermfg=grey
hi CursorLineNr ctermfg=11
hi CursorLine cterm=NONE ctermbg=234 ctermfg=NONE
hi StatusLine ctermbg=white ctermfg=black
