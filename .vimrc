"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set hidden                 " Keep changed buffers without requiring saves
set ttyfast                " Faster Terminal, redraws stuff quicker!
set lazyredraw
set viewoptions=unix,slash " Better Unix/Windows compatibility
set modeline               " Allow file specific Vim settings

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Height of the command bar
set cmdheight=2

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 120 characters
set lbr
set tw=120

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Define all the different modes
let g:currentmode={
	\ 'n'  : 'Normal',
	\ 'no' : 'N·Operator Pending',
	\ 'v'  : 'Visual',
	\ 'V'  : 'V·Line',
	\ 's'  : 'Select',
	\ 'S'  : 'S·Line',
	\ 'i'  : 'Insert',
	\ 'R'  : 'Replace',
	\ 'Rv' : 'V·Replace',
	\ 'c'  : 'Command',
	\ 'cv' : 'Vim Ex',
	\ 'ce' : 'Ex',
	\ 'r'  : 'Prompt',
	\ 'rm' : 'More',
	\ 'r?' : 'Confirm',
	\ '!'  : 'Shell',
	\}

" Shorten a given filename by truncating path segments.
" https://github.com/blueyed/dotfiles/blob/master/vimrc#L396
function! ShortenFilename(bufname, maxlen) "{{{
	if getbufvar(bufnr(a:bufname), '&filetype') == 'help'
		return fnamemodify(a:bufname, ':t')
	endif

	let maxlen_of_parts = 7 " including slash/dot
	let maxlen_of_subparts = 5 " split at dot/hypen/underscore; including split

	let s:PS = exists('+shellslash') ? (&shellslash ? '/' : '\') : "/"
	let parts = split(a:bufname, '\ze['.escape(s:PS, '\').']')
	let i = 0
	let n = len(parts)
	let wholepath = '' " used for symlink check
	while i < n
		let wholepath .= parts[i]
		" Shorten part, if necessary:
		if i<n-1 && len(a:bufname) > a:maxlen && len(parts[i]) > maxlen_of_parts
		" Let's see if there are dots or hyphens to truncate at, e.g.
		" 'vim-pkg-debian' => 'v-p-d…'
		let w = split(parts[i], '\ze[._-]')
		if len(w) > 1
			let parts[i] = ''
			for j in w
			if len(j) > maxlen_of_subparts-1
				let parts[i] .= j[0:maxlen_of_subparts-2]."..."
			else
				let parts[i] .= j
			endif
			endfor
		else
			let parts[i] = parts[i][0:maxlen_of_parts-2].'...'
		endif
		endif
		" add indicator if this part of the filename is a symlink
		if getftype(wholepath) == 'link'
		if parts[i][0] == s:PS
			let parts[i] = parts[i][0] . '-> ' . parts[i][1:]
		else
			let parts[i] = '-> ' . parts[i]
		endif
		endif
		let i += 1
	endwhile
	let r = join(parts, '')
	return r
endfunction "}}}

" Find out current buffer's size and output it.
function! FileSize() "{{{
	let bytes = getfsize(expand('%:p'))
	if (bytes >= 1024)
		let kbytes = bytes / 1024
	endif
	if (exists('kbytes') && kbytes >= 1000)
		let mbytes = kbytes / 1000
	endif

	if bytes <= 0
		return 'null'
	endif

	if (exists('mbytes'))
		return mbytes . 'MB'
	elseif (exists('kbytes'))
		return kbytes . 'KB'
	else
		return bytes . 'B'
	endif
endfunction "}}}

" Statusline {{{
let &stl=''        " Clear statusline for when vimrc is loaded
let &stl.='%{toupper(g:currentmode[mode()])}'
let &stl.=' '      " Separator
let &stl.='%{HasPaste()}'
let &stl.='{'      " Opening curly bracket, for item group
let &stl.='%('     " Start of item group
let &stl.='%M'     " Show modified status of buffer
let &stl.='%R'     " Show if file is read-only: RO
let &stl.='%W'     " Show if buffer is a preview item?: PRV
let &stl.='%H'     " Show if buffer is a help file: HLP
let &stl.='%)'     " End of item group
let &stl.='}'      " Closing curly bracket, for item group
let &stl.=' '      " Separator
let &stl.='%<'     " Truncate from here on
let &stl.='%t'     " Current buffer's file name
let &stl.=' '      " Separator
let &stl.='['      " Opening square bracket for file info
let &stl.='%{&ft!=""?&ft.",":""}'
let &stl.='%{&fenc!=""?&fenc.",":&enc.","}'
let &stl.='%{&ff!=""?&ff.",":""}'
let &stl.='%{FileSize()}' " Output buffer's file size
let &stl.=']'             " Closing square bracket for file info
if exists('*GitBranchInfoString')        " If GitBranchInfo exists
	let &stl.='%{GitBranchInfoString()}' " Buffer's Git info
endif
let &stl.='%='     " Right side of statusline
let &stl.=' '      " So there's a space between both sides
let &stl.='[%l'    " Cursor's current line
let &stl.=':'      " Separator between line and column info
let &stl.='%c]'    " Current column
let &stl.=' '      " Separator
let &stl.='%LL.'  " Total of lines
let &stl.=' '      " Separator
let &stl.='(%p%%)' " Percentage through file in lines, as in <c-g>
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
set pastetoggle=<F2>

" Set mouse mode for vim
set mouse=a

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
   if &paste
        return 'PASTE-MODE '
    endif
    return ''
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Enable 256 colors palette
set t_ut=
set t_Co=256
set background=dark
colorscheme pablo

set number
set cursorline
hi LineNr ctermfg=grey
hi CursorLineNr ctermfg=11
hi CursorLine cterm=NONE ctermbg=234 ctermfg=NONE
hi StatusLine ctermbg=white ctermfg=black
