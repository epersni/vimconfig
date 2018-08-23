set wildmode=longest,list
set wildmenu
set ruler
set cc=80
set backspace=2
set number
set ignorecase
set hlsearch
set showmatch
set ttyfast "fast terminal
set lazyredraw "to avoid scrolling problems
syntax enable

" GIT commit help
au FileType gitcommit set cc=72

"colors delek
"colorscheme darkblue
"set background=dark

" disable visual bell
set visualbell
set t_vb=

" Use spaces instead of tabs
set expandtab

set noswapfile
set nobackup

"indent xml files, use gg=G
"set equalprg=xmllint\ --format\ -

" Be smart when using tabs ;)
set smarttab
set shiftwidth=2
set tabstop=2

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Always show the status line
set laststatus=2

" Enable mouse support in console
set mouse=a

filetype indent plugin on

" Remove any trailing whitespace that is in the file
"autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" highlight spaces
"highlight ExtraWhitespace ctermbg=red guibg=red
"match ExtraWhitespace /\s\+$/
"autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
"autocmd InsertEnter * call clearmatches() "match ExtraWhitespace /\s\+\%#\@<!$/
"autocmd InsertLeave * match ExtraWhitespace /\s\+$"/
"autocmd BufWinLeave * call clearmatches()

"autocmd BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
"autocmd InsertLeave * let w:m2=matchadd('ErrorMsg', '\%>81v.\+', -1)
"autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>81v.\+', -1


" Disable F1 help
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>
" Go to tab by number
noremap <F1> 1gt
noremap <F2> 2gt
noremap <F3> 3gt
noremap <F4> 4gt
noremap <F5> 5gt
noremap <F6> 6gt
noremap <F7> 7gt
noremap <F8> 8gt

" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
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

"Better window navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" auto update csope
nmap <F11> :!find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' > cscope.files<CR>
  \:!cscope -b -i cscope.files -f cscope.out<CR>
  \:cs kill -1<CR>:cs add cscope.out<CR>
nmap <F12> :Explore<CR>
nmap <F9> <ESC>:ls<CR>

" File explorer settings
" =============================================================================
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
