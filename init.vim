""""""" Plugin management stuff """""""
" Enable filetype plugins
filetype plugin on
set modeline               " Allow file specific Vim settings
set hidden                 " Keep changed buffers without requiring saves
set viewoptions=unix,slash " Better Unix/Windows compatibility

set rtp+=/home/keupon/.config/nvim/bundle/Vundle.vim
call vundle#begin('/home/keupon/.config/nvim/bundle')
Plugin 'VundleVim/Vundle.vim'

" Custom plugins...
" Ctrl-P - Fuzzy file search
Plugin 'kien/ctrlp.vim'
" Neomake build tool (mapped below to <c-b>)
Plugin 'benekastah/neomake'
" Autocomplete for a lot of languages
Plugin 'Valloric/YouCompleteMe'
" Remove extraneous whitespace when edit mode is exited
Plugin 'thirtythreeforty/lessspace.vim'
" LaTeX editing
Plugin 'LaTeX-Box-Team/LaTeX-Box'
" Status bar mods
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
" NerdTREE file explorer plugin
Plugin 'scrooloose/nerdtree'

" After all plugins...
call vundle#end()

" Plugin configuration
map <F3> :NERDTreeToggle<CR>
" NerdTREE on startup
autocmd vimenter * NERDTree
autocmd vimenter * wincmd p
" Quit if last tab is a NerdTREE
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Airline powerline symbols
let g:airline_symbols = {}
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''

""""""" Jedi-VIM """""""
" Don't mess up undo history
let g:jedi#show_call_signatures = "0"


""""""" SuperTab configuration """""""
"let g:SuperTabDefaultCompletionType = "<c-x><c-u>"
function! Completefunc(findstart, base)
    return "\<c-x>\<c-p>"
endfunction

""""""" General coding stuff """""""

" Search settings
set ignorecase " Ignore case when searching
set smartcase " When searching try to be smart about cases
set magic " For regular expressions turn magic on

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" Always show status bar
set laststatus=2
" Let plugins show effects after 500ms, not 4s
set updatetime=500
" Configure mouse mode
set mouse=a
" Don't let autocomplete affect usual typing habits
set completeopt=menuone,preview,noinsert
" Let vim-gitgutter do its thing on large files
let g:gitgutter_max_signs=10000

""""""" Python stuff """""""
syntax enable
set number showmatch
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent smartindent
let python_highlight_all = 1

""""""" Keybindings """""""
" Set up leaders
let mapleader=","

" Toggle paste mode on and off
set pastetoggle=<F2>

" Use system clipboard
set clipboard+=unnamedplus
vnoremap <C-c> "+y
nnoremap <Del> "_x<Left>

" Neomake and other build commands (ctrl-b)
nnoremap <C-b> :w<cr>:Neomake<cr>

autocmd BufNewFile,BufRead *.tex,*.bib noremap <buffer> <C-b> :w<cr>:new<bar>r !make<cr>:setlocal buftype=nofile<cr>:setlocal bufhidden=hide<cr>:setlocal noswapfile<cr>
autocmd BufNewFile,BufRead *.tex,*.bib imap <buffer> <C-b> <Esc><C-b>

" :W sudo saves the file (useful for handling the permission-denied error)
command W w !sudo tee > /dev/null %

""""""" NVIM UI """""""
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

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
nmap <Leader>l :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Height of the command bar
set cmdheight=2

" Color theme settings
colorscheme pablo
let g:airline_theme='luna'
set number
set cursorline
set background=dark
hi LineNr ctermfg=grey
hi CursorLineNr ctermfg=11
hi CursorLine cterm=NONE ctermbg=234 ctermfg=NONE
hi StatusLine ctermbg=white ctermfg=black
