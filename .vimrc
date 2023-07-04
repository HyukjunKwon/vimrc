" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
set nocompatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
"    \| exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes) in terminals

"map j gj 
"map k gk

if $TERM == 'screen'
set term=xterm
endif

" line number
highlight LineNr ctermfg=black ctermbg=Gray
highlight StatusLine ctermfg=LightGreen

" default settings
filetype plugin indent on
set bs=indent,eol,start
set autoindent
"set smartindent
set ruler
set number
set ts=4
set sw=4
set hlsearch
set bg=dark
set wildmenu

" Enable backscpace
set softtabstop=4
" On pressing tab, insert 4 spaces
set expandtab

" show column at 80 
set colorcolumn=80


set mouse=nvc
set ttymouse=xterm2
set switchbuf=useopen,usetab,newtab

" highlight
highlight Comment ctermfg=darkgreen
au FileType c,cpp,latex,tex highlight Comment ctermfg=cyan


" key mapping
map k gk
map j gj
map <up> gk
map <down> gj
imap <up> <c-o>gk
imap <down> <c-o>gj

" [F5] Make, [F4] Next Error [Shift+F4] Previous Error
map <F5> <ESC>:w<CR>:mak<CR>
map <F4> <ESC>:cn<CR>
map <Undo> <ESC>:cp<CR>
imap <F2> <ESC>:w<CR>
map <F2> <ESC><ESC>:w<CR>
map <F6> <ESC>:!./a.out<CR>
map <F7> <ESC>:setlocal spell spelllang=en_us<CR>
map <F8> <ESC>:setlocal spell spelllang=<CR>

" file extension
func! MyFiletype(ext)
	if filereadable("Makefile") || filereadable("makefile")
		return
	endif

	if a:ext == "c"
		set makeprg=echo\ 'gcc\ %';gcc\ %
	elseif a:ext == "cpp"
		set makeprg=echo\ 'g++\ %';g++\ %
	elseif a:ext == "latex"
		set makeprg=echo\ 'pdflatex\ %\ --halt-on-error';pdflatex\ %\ --halt-on-error
	elseif a:ext == "python"
		set makeprg=echo\ 'python\ %';python\ %
	elseif a:ext == "php"
		set makeprg=echo\ 'php\ %';php\ %
	elseif a:ext == "scheme"
		set makeprg=mzscheme\ -f\ %
	elseif a:ext == "cs"
		set makeprg=echo\ 'gmcs\ %';gmcs\ %
	elseif a:ext == "ml"
		set makeprg=ledit\ ocaml\ -init\ %
	elseif a:ext == "s"
		set ft=mips
		set makeprg=spim\ -f\ %
		hi Comment ctermfg=green
	endif
endfunc

func! LatexMapping()

	" ignore character 
	func! Ignore(pat)
		let c = nr2char(getchar(0))
		return (c =~ a:pat) ? '' : c
	endf

	iab <buffer> \begin{align*}			\begin{align*}<CR><CR>\end{align*}<Up><C-R>=Ignore('[\r\s]')<CR>
	iab <buffer> \begin{align}			\begin{align}<CR><CR>\end{align}<Up><C-R>=Ignore('[\r\s]')<CR>
	iab <buffer> \begin{equation*}		\begin{equation*}<CR><CR>\end{equation*}<Up><C-R>=Ignore('[\r\s]')<CR>
	iab <buffer> \begin{equation}		\begin{equation}<CR><CR>\end{equation}<Up><C-R>=Ignore('[\r\s]')<CR>
	iab <buffer> \begin{displaymath}	\begin{displaymath}<CR><CR>\end{displaymath}<Up><C-R>=Ignore('[\r\s]')<CR>
	iab <buffer> \begin{enumerate}		\begin{enumerate}<CR><CR>\end{enumerate}<Up><C-R>=Ignore('[\r\s]')<CR>
	iab <buffer> \begin{itemize}		\begin{itemize}<CR><CR>\end{itemize}<Up><C-R>=Ignore('[\r\s]')<CR>
	iab <buffer> \begin{description}	\begin{description}<CR><CR>\end{description}<Up><C-R>=Ignore('[\r\s]')<CR>
	iab <buffer> \begin{center}			\begin{center}<CR><CR>\end{center}<Up><C-R>=Ignore('[\r\s]')<CR>
	iab <buffer> \begin{verbatim}		\begin{verbatim}<CR><CR>\end{verbatim}<Up><C-R>=Ignore('[\r\s]')<CR>
	iab <buffer> \begin{lstlisting}		\begin{lstlisting}<CR><CR>\end{lstlisting}<Up><C-R>=Ignore('[\r\s]')<CR>
	iab <buffer> \begin{quote}			\begin{quote}<CR><CR>\end{quote}<Up><C-R>=Ignore('[\r\s]')<CR>
	iab <buffer> \begin{quotation}		\begin{quotation}<CR><CR>\end{quotation}<Up><C-R>=Ignore('[\r\s]')<CR>

	imap <F3>align*			<ESC>i\begin{align*}<CR>\end{align*}<ESC>ko<TAB>
	imap <F3>align			<ESC>i\begin{align}<CR>\end{align}<ESC>ko<TAB>
	imap <F3>equation*		<ESC>i\begin{equation*}<CR>\end{equation*}<ESC>ko<TAB>
	imap <F3>equation		<ESC>i\begin{equation}<CR>\end{equation}<ESC>ko<TAB>
	imap <F3>displaymath	<ESC>i\begin{displaymath}<CR>\end{displaymath}<ESC>ko<TAB>

	imap <F3>enumerate		<ESC>i\begin{enumerate}[1.]<CR>\end{enumerate}<ESC>ko<TAB>
"	imap <F3>enu(			<ESC>i\begin{enumerate}[(1)]<CR>\end{enumerate}<ESC>ko<TAB>
"	imap <F3>enua			<ESC>i\begin{enumerate}[(a)]<CR>\end{enumerate}<ESC>ko<TAB>
	imap <F3>itemize		<ESC>i\begin{itemize}<CR>\end{itemize}<ESC>ko<TAB>
	imap <F3>description	<ESC>i\begin{description}<CR>\end{description}<ESC>ko<TAB>

	imap <F3>center			<ESC>i\begin{center}<CR>\end{center}<ESC>ko<TAB>
	imap <F3>flushleft		<ESC>i\begin{flushleft}<CR>\end{flushleft}<ESC>ko<TAB>
	imap <F3>flushright		<ESC>i\begin{flushright}<CR>\end{flushright}<ESC>ko<TAB>

	imap <F3>verbatim		<ESC>i\begin{verbatim}<CR>\end{verbatim}<ESC>ko<TAB>
	imap <F3>lstlisting		<ESC>i\begin{lstlisting}<CR>\end{lstlisting}<ESC>ko<TAB>
	imap <F3>quote			<ESC>i\begin{quote}<CR>\end{quote}<ESC>ko<TAB>
	imap <F3>quotation		<ESC>i\begin{quotation}<CR>\end{quotation}<ESC>ko<TAB>

endfunc


autocmd FileType python			 :vmap comm :s/^/#/g<CR>:nohl<CR><ESC>
autocmd FileType python			 :vmap unco :s/^#//<CR>:nohl<CR><ESC>
autocmd FileType tex,latex		      :vmap comm :s/^/%/g<CR>:nohl<CR><ESC>
autocmd FileType tex,latex		      :vmap unco :s/^%//<CR>:nohl<CR><ESC>
autocmd FileType scheme			 :vmap comm :s/^/;/g<CR>:nohl<CR><ESC>
autocmd FileType scheme			 :vmap unco :s/^;//<CR>:nohl<CR><ESC>
autocmd FileType h,c,cpp,java,cs	:vmap comm :s/^/\/\//g<CR>:nohl<CR><ESC>
autocmd FileType h,c,cpp,java,cs	:vmap unco :s/^\/\///g<CR>:nohl<CR><ESC>

au FileType c		   call MyFiletype("c")
au FileType cpp		 call MyFiletype("cpp")
au FileType tex,latex   call MyFiletype("latex")
au FileType tex,latex	call LatexMapping()
au FileType python	      call MyFiletype("python")
au FileType php		 call MyFiletype("php")
au FileType scheme	      call MyFiletype("scheme")
au FileType cs		  call MyFiletype("cs")
au FileType ocaml	       call MyFiletype("ml")
au FileType asm 	    call MyFiletype("s")
au FileType tex		setlocal spell spelllang=en_us

" Source a global configuration file if available
" XXX Deprecated, please move your changes here in /etc/vim/vimrc
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif


