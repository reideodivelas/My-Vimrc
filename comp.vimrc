set nu
set shell=/bin/bash
set rnu
set history=10000
set tabstop=4
set shiftwidth=4
set t_Co=256
set splitright
set confirm
set showbreak=↪
" set cursorline
set incsearch
set ignorecase
set showcmd
" set foldcolumn=2
set guifont=Source\ Code\ Pro\ for\ Powerline:h14

if has('vim_starting')
	if &compatible
		set nocompatible
	endif
endif

"Syntax enabled.
syntax on
filetype plugin indent on

" autocmd BufWinLeave .* mkview
" autocmd BufWinEnter .* silent loadview

"Setting the same clipboard for Vim and System.
"set clipboard=unnamed

"You see suggestion for commands in Airline.
set wildmenu


"This is your leader key
:let mapleader = "\<Space>"

"Disabling that irritating ERROR bell PHEW!
if has("gui_macvim")
	autocmd GUIEnter * set vb t_vb=
endif

set undofile
"Setting directory for .backup, .swp, .undo files to location I want to.
set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//


call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'luochen1990/rainbow'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'yggdroot/indentline'
Plug 'jiangmiao/auto-pairs'
Plug 'honza/vim-snippets'
call plug#end()


"NETRW
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
augroup ProjectDrawer
"Trailing whitespaces
"
"Automatically remove all trailing whitespaces on saving file.
autocmd BufWritePre * :%s/\s\+$//e


"These mappings are for easy movements between mutiple splits in VIM.
"Ex- Press ctrl+j to go to split just below your cursor.
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Remapped ctrl+e to go to the end of the line in INSERT mode and ctrl+a to start of the line.
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0

"This will show lines as you indent you code.
"A real life saver for me.
"let g:indentLine_bgcolor_term = 239
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
"indentLine settings for terminal and gui
autocmd! User indentLine doautocmd indentLine Syntax

"Rainbow Brackets plugin
let g:rainbow_active = 1


nnoremap ,cpp :-1read $HOME/.vim/skeleton/skel.cpp<CR>5j3wa<CR><ESC>O
nmap <leader>t :vert term<CR>
"This is for c and cpp
autocmd FileType c,cpp :set cindent
autocmd FileType c,cpp :setf c
autocmd FileType c,cpp :set expandtab




" Compiling and execution

if filereadable("Makefile")
        set makeprg=make\ -s
    else
        " autocmd FileType java       set makeprg=javac\ %
        " autocmd FileType scala      set makeprg=scalac\ %
        " autocmd FileType haskell    set makeprg=ghc\ -o\ %<\ %
        " autocmd FileType javascript set makeprg=echo\ OK
        " autocmd FileType python     set makeprg=python3\ %
        " autocmd FileType perl       set makeprg=echo\ OK
        autocmd FileType c          set makeprg=gcc\ -o\ %<\ %
        autocmd FileType cpp        set makeprg=g++\ --std=c++17\ -o\ %<\ %
    endif

                                " nmap <F8> <ESC>:w<CR><ESC>:!./%<CR>
                                " imap <F8> <ESC>:w<CR><ESC>:!./%<CR>
    autocmd FileType c          nmap <F4> <ESC>:w<CR><ESC>:vert term ./%<<CR>
    autocmd FileType c          imap <F4> <ESC>:w<CR><ESC>:vert term ./%<<CR>
    autocmd FileType cpp        nmap <F4> <ESC>:w<CR><ESC>:vert term ./%<<CR>
    autocmd FileType cpp        imap <F4> <ESC>:w<CR><ESC>:vert term ./%<<CR>
    " autocmd FileType java       nmap <F4> <ESC>:w<CR><ESC>:!java %<<CR>
    " autocmd FileType java       imap <F4> <ESC>:w<CR><ESC>:!java %<<CR>
    " autocmd FileType scala      nmap <F4> <ESC>:w<CR><ESC>:!scala %<<CR>
    " autocmd FileType scala      imap <F4> <ESC>:w<CR><ESC>:!scala %<<CR>
    " autocmd FileType haskell    nmap <F4> <ESC>:w<CR><ESC>:!./%<<CR>
    " autocmd FileType haskell    imap <F4> <ESC>:w<CR><ESC>:!./%<<CR>
    " autocmd FileType python     nmap <F4> <ESC>:w<CR><ESC>:term python3 %<CR>
    " autocmd FileType python     imap <F4> <ESC>:w<CR><ESC>:term python3 %<CR>
    " autocmd FileType perl       nmap <F4> <ESC>:w<CR><ESC>:!perl %<CR>
    " autocmd FileType perl       imap <F4> <ESC>:w<CR><ESC>:!perl %<CR>

    imap <F3> <ESC>:w<CR><ESC>:make<CR>:cwindow<CR><CR>
    nmap <F3> <ESC>:w<CR><ESC>:make<CR>:cwindow<CR><CR>

    imap <F2> <ESC>:w<CR><ESC>:silent make<CR>:call feedkeys("\<F4>")<CR>
    nmap <F2> <ESC>:w<CR><ESC>:silent make<CR>:call feedkeys("\<F4>")<CR>

    "F2 to compile and run :copen for errors
    "<F3> for compiling only
    "F4 to run file pre-existing binary
    "

silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)


"fzf.vim-------------------maps and uses----------------------

"Leader+L for line search in the current file.
nnoremap <silent> <Leader>L   :BLines<CR>
"Leader+B for buffer search.
nnoremap <silent> <Leader>B  :Buffers<CR>
"Leader+ff+Enter for file search.
nnoremap <silent> ff :Files

command! -bang DesktopFiles call fzf#vim#files('~/Desktop/', <bang>0)
nmap <Leader>_ :DesktopFiles<CR>


let g:fzf_history_dir = '/Users/arx6363/tmp_vim/skim_his'
let g:fzf_files_options =
			\ '--preview "(coderay {} || bat {}) 2> /dev/null | head -'.&lines.'"'
let g:fzf_layout = {'window' : {'width' : 0.8, 'height' : 0.8}}

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)


"--------multi_cursor-----------------------------------------------------------------
let g:multi_cursor_use_default_mapping=1

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

augroup resume_edit_position
	autocmd!
	autocmd BufReadPost *
				\ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
				\ | execute "normal! g`\"zvzz"
				\ | endif
augroup END


command! -nargs=* -complete=dir Cd call fzf#run(fzf#wrap(
			\ {'source': 'find '.(empty(<f-args>)? '.' : <f-args>).' -type d',
			\  'sink': 'cd'}))

 let g:UltiSnipsExpandTrigger= '<tab>'
 let g:UltiSnipsJumpForwardTrigger='<C-j>'
 let g:UltiSnipsJumpBackwardTrigger='<C-k>'
 " If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

set laststatus=2
"hi statusline       guibg=blue   guifg=white "If using terminal comment out these two lines.
"hi LineNr guibg=NONE guifg=green

" Formats the statusline
let g:currentmode={
			\ 'n'  : 'NORMAL ',
			\ 'v'  : 'VISUAL ',
			\ 'V'  : 'V·Line ',
			\ '' : 'V·Block ',
			\ 'i'  : 'INSERT ',
			\ 'R'  : 'Replace',
			\ 'Rv' : 'V·Replace ',
			\ 'c'  : 'Command ',
			\}

set statusline=
" Show current mode
set statusline+=\ %{toupper(g:currentmode[mode()])}

set statusline+=\ %=                            " align left
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}]                         "file format

set statusline+=%h                               "help file flag

set statusline+=%y                               "filetype
set statusline+=Line:%l/%L[%p%%]            " line X of Y [percent of file]
set statusline+=\ Col:%c                    " current column
set statusline+=\ Buf:%n                    " Buffer number
set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor

colorscheme elflord
hi Cursor gui=reverse guibg=NONE guifg=NONE
hi Visual gui=reverse guibg=NONE guifg=NONE
