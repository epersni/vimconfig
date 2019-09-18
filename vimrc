call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'morhetz/gruvbox'
Plug 'yggdroot/indentline'
Plug 'tpope/vim-fugitive'
call plug#end()
"==============================================================================
" TODO:
"==============================================================================
" - when coding, I want to warn if tabs are used
" - when coding, I want to warn if trailing whitespace is in the file
" - I want to be able to have local project settings 
" - I want to have a custom sheet sheet quickly available
" - Static code analysis wit ALE? plugin
" - Fuzzy file finder FZF
"==============================================================================
" Coding Related
"==============================================================================
" Add rule at column 80
set colorcolumn=80
" Enable ruler the right side of the status line at the bottom of the window
set ruler 
set rulerformat=%l\:%c
" Specific ruler for when writing git commits
au FileType gitcommit set cc=72
"Print the line number in front of each line
set number
" When a bracket is inserted, briefly jump to the matching one
set showmatch
" Syntax highlighting
syntax enable
" The kind of folding used for the current window.  Possible values:
  " |fold-manual|	manual	    Folds are created manually.
  " |fold-indent|	indent	    Lines with equal indent form a fold.
  " |fold-expr|	expr	    'foldexpr' gives the fold level of a line.
  " |fold-marker|	marker	    Markers are used to specify folds.
  " |fold-syntax|	syntax	    Syntax highlighting items specify folds.
  " |fold-diff|	diff	    Fold text that is not changed.
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2
"==============================================================================
" Files Opening Related
"==============================================================================
" Tab completion opens nice dialog
set wildmenu
"	Complete longest common string, then list alternatives
set wildmode=longest,list
" A buffer is unloaded when it is abandoned
set hidden
"==============================================================================
"" Text Editing Related
"==============================================================================
" Make sure Plug 'morhetz/gruvbox' is installed
colorscheme gruvbox
" Allow backspacing over: autoindent, line breaks, start of insert
" same as ":set backspace=indent,eol,start" but backwards compatible with 
" previous vim versions
set backspace=2
" Do not create swapfile for the buffer
set noswapfile
" Do not create backup before overwriting a file
set nobackup
" a <Tab> in front of a line inserts blanks according to 'shiftwidth'
" What gets inserted (a <Tab> or spaces) depends on the 'expandtab' option.
set smarttab
" Number of spaces to use for each step of (auto)indent
set shiftwidth=2
" Number of spaces that a <Tab> in the file counts for
set tabstop=8
" Use spaces instead of tabs (note: disabled when 'paste' option is set)
set expandtab
" Copy indent from current line when starting a new line
set autoindent 
" Do smart autoindenting when starting a new line
set smartindent
" When on, lines longer than the width of the window will wrap and displaying 
" continues on the next line
set wrap
"==============================================================================
" Key Bindings
"==============================================================================
" Go to tab by number
noremap <F1> 1gt
noremap <F2> 2gt
noremap <F3> 3gt
noremap <F4> 4gt
noremap <F5> 5gt
noremap <F6> 6gt
noremap <F7> 7gt
noremap <F8> 8gt

"Better window navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Switch betten c/c++ header files and sources
map <F11> :e %:p:s,.hpp$,.X123X,:s,.cpp$,.hpp,:s,.X123X$,.cpp,<CR>.

" Open the file explorer
nmap <F12> :Explore<CR>

"==============================================================================
" File explorer settings (settings for :explore)
"==============================================================================
" hide ./
let g:netrw_list_hide = '^\./$' 
" normal sort direction
let g:netrw_sort_direction = "normal"
let g:netrw_sort_by = "name"
" ignore casing
let g:netrw_sort_options = "i"
" ls style of listings (with file size etc.)
let g:netrw_liststyle = 1
let g:netrw_sort_sequence = '[\/]$,\<core\%(\.\d\+\)\=,\.[a-np-z]$,Makefile,makefile,SConstruct,SConscript,*,\.o$,\.obj$,	\.info$,\.swp$,\.bak$,\~$'

"==============================================================================
" Text Editor Configuration // TODO: maybe scrolling?
"==============================================================================
" More characters will be sent to the screen for redrawing
set ttyfast 
" When this option is set, the screen will not be redrawn while executing 
" macros, registers and other commands that have not been	typed
set lazyredraw 
" Use a visual bell instead of beeping.  The terminal code to display the visual
" bell is given with 't_vb'. Disable both beep and flash
set visualbell
set t_vb=
" The value of this option influences when the last window will have a
" status line:
" 	0: never
" 	1: only if there are at least two windows
" 	2: always
set laststatus=2
" The mouse can be enabled for different modes:
" 	n	Normal mode and Terminal modes
" 	v	Visual mode
" 	i	Insert mode
" 	c	Command-line mode
" 	h	all previous modes when editing a help file
" 	a	all previous modes
" 	r	for |hit-enter| and |more-prompt| prompt
set mouse=a
"
filetype indent plugin on

"==============================================================================
" Search Related
"==============================================================================
" Ignore case in search patterns
set ignorecase
" When there is a previous search pattern, highlight all its matches
set hlsearch

"==============================================================================
" Rename tabs to show tab number.
"==============================================================================
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let wn = tabpagewinnr(i,'$')

            let s .= '%#TabNum#'
            let s .= i
            " let s .= '%*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= ' ' . file . ' '
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
    set showtabline=1
    highlight link TabNum Special
endif
