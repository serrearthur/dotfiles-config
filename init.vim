"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set modeline                " Allow file specific Vim settings
set hidden                  " Keep changed buffers without requiring saves
set viewoptions=unix,slash  " Better Unix/Windows compatibility

set nocompatible              " Required for plugins
filetype off                  " Required for plugins

let g:coc_global_extensions = [
\ 'coc-json',
\ 'coc-tsserver',
\ 'coc-html',
\ 'coc-css',
\ 'coc-yaml',
\ 'coc-highlight',
\ 'coc-angular',
\ 'coc-sh',
\ 'coc-actions'
\ ]

" Vim-Plug configuration
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
              \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lambdalisue/suda.vim'

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install() } }

" Plug 'dense-analysis/ale'             " Linting tool
Plug 'blueyed/vim-qf_resize'          " Automatic resizing of quickfix/location windows
Plug 'thirtythreeforty/lessspace.vim' " Remove extraneous whitespace when edit mode is exited
Plug 'vim-airline/vim-airline'              " Status bar plugin
Plug 'vim-airline/vim-airline-themes' " Themes for the status bar
Plug 'scrooloose/nerdtree'            " Filesystem explorer
Plug 'jistr/vim-nerdtree-tabs'        " NERTree extension to group explorer with tabs

call plug#end()
filetype plugin indent on

source ~/.config/nvim/coc.vim

" Plugin configuration
"" NERDTree
map <F3> :NERDTreeFocusToggle<CR>

"" Airline
let g:airline_theme='luna'
let g:airline_symbols = {}
let g:airline_powerline_fonts = 1
let g:airline_symbols.linenr = '⌑'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search settings
set ignorecase " Ignore case when searching
set smartcase " When searching try to be smart about cases
set magic " For regular expressions turn magic on

" Show matching brackets when text indicator is over them
set showmatch
set mat=200 " How many tenths of a second to blink when matching brackets

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
" Configure this according to your OS
set clipboard+=unnamedplus

" <C-c> is used to copy selection in visual mode
" vnoremap <C-c> "+y

" Corrected behaviour of <Del> key in normal mode
nnoremap <Del> "_x

" :W sudo saves the file (useful for handling the permission-denied error)
command W :SudaWrite

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Fixes indentation and removes trailing spaces
fun! CleanFile()
    let l:save = winsaveview()
    normal gg=G
    %s/\s\+$//e
    call winrestview(l:save)
endfun
noremap <Leader>w :call CleanFile()<CR>

" Shortcuts to swap lines up and down
nnoremap <silent><C-S-Up> :let save_a=@a<Cr><Up>"add"ap<Up>:let @a=save_a<Cr>
nnoremap <silent><C-S-Down> :let save_a=@a<Cr>"add"ap:let @a=save_a<Cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Useful mappings for managing tabs
map <leader>c :tabnew<cr>
map <leader>x :tabclose<cr>
map <leader>n :tabnext<cr>
map <leader>p :tabprevious<cr>

" Let 'tl' toggle between the current and last accessed tab
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
set number
set cursorline
hi LineNr ctermfg=grey
hi CursorLineNr ctermfg=11
hi CursorLine cterm=NONE ctermbg=234 ctermfg=NONE
hi StatusLine ctermbg=white ctermfg=black
