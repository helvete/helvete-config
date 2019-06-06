" AUTOCOMMANDS
" drop trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e
" Move a cursor to the location it was left on previous file editation
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" warn on file change while editting
au FileChangedShell * echo "Warning: File changed on disk"

" highlighting extra multiple occurences of a space char
highlight ExtraWhitespace ctermbg=gray guibg=gray
" highlight phpt files the way php ones are
autocmd BufNewFile,BufRead *.phpt set ft=php
let php_minlines=666

" highlight lock files like json files
autocmd BufNewFile,BufRead *.lock set ft=javascript

" highlight .vimrc.d files the way .vimrc ones are
autocmd BufNewFile,BufRead .vimrc.d set ft=vim

" highlight Dockerfiles
autocmd BufNewFile,BufRead Dockerfile* set ft=dockerfile

" highlight .env files
autocmd BufNewFile,BufRead .env* set ft=sh

" highlight neon
autocmd BufNewFile,BufRead *.neon* set ft=yaml

" 80 chars ruler colour
highlight ColorColumn ctermbg=Brown

" SETTINGS
set mouse=a
set encoding=utf8 " character encoding used inside Vim
set fileencoding=utf8 " character encoding for the files
set history=1000
set colorcolumn=80
set showcmd
"set smartindent

set nu " display line numbering
" tabs and indentation
"set noexpandtab " tab mode
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4
set expandtab " space mode

" COMMANDS
"
" Diffing helpers
:command! Dp :diffput
:command! Dg :diffget
:command! Du :diffupdate
" Convert 2 spaces to a tab char
:command! Sp2Tb :%s/  /\t/g
" Convert file type to unix
:command! ToUnix set ff=unix
" Format json
:command! JSON :%!python -mjson.tool
" Prepare XML for the default formatter (`gg=G`)
:command! XML :%s/></>\r</g
" Resource config
:command! RS :source ~/.vimrc
" Switch ff display
:command! -nargs=1 FF e ++ff=<args>
" Switch ff display to unix - shortcut cmd
:command! Fu e ++ff=unix

" MAPPINGS
map oo o<ESC>

" convert multiple spaces into tabs (and vice versa in space mode)
map <F10> :%retab!<CR>

" multimode wrap toggle
nnoremap <F5> :set wrap! wrap?<CR>
imap <F5> <C-O><F5>

" toggle showing new line chars
nnoremap <F7> :set list! list? <CR>

" php syntax validation
map <F9> :!php -l %<CR>

" perl syntax validation
map <S-F11> :!perl -c %<CR>

" python syntax validation
map <S-F12> :!sudo python3 -m py_compile %<CR>
map <F12> :!python -m py_compile %; rm %c<CR>

" paste mode toggle
nnoremap <F8> :set invpaste paste?<CR>
set pastetoggle=<F8>
set showmode

" switch to/from vimdiff mode on current windows
nnoremap <F6> :windo diffthis<CR>
nnoremap <S-F6> :diffoff!<CR>

" use specific text colours
set bg=light
" default split position on the right
set splitright
" default split position on the bottom
set splitbelow
" increase open tabs limit
set tabpagemax=100

set mmp=1048576

" toggle space char highlighting, TODO: toggle mode to save one F-x key
:nnoremap <F3> :match ExtraWhitespace /^\t*\zs \+/<CR>
:nnoremap <F4> :match<CR>

" switch off Q command mode for unintentional annoyance. Still waiting to
" learn to utilize it... ;-)
:nnoremap Q <NOP>

" annoying F1 missclicks - would do :help for help anyways
:nnoremap <F1> <NOP>
:inoremap <F1> <NOP>

" Save file using sudo
cmap WW w !sudo tee > /dev/null %<CR>

if has('arabic')
    set noarabicshape
endif

" Pathogen
execute pathogen#infect()
call pathogen#helptags() " generate helptags for everything in 'runtimepath'
syntax on
filetype plugin indent on

nmap <F2> :TagbarToggle<CR>
" TagBar {
	let g:tagbar_autofocus = 1
	let g:tagbar_autoclose = 1
	let g:tagbar_type_php = {
		\ 'ctagstype' : 'php',
		\ 'kinds' : [
			\ 'i:interfaces',
			\ 'c:classes',
			\ 'd:constant definitions',
			\ 'f:functions',
			\ 'j:javascript functions:1'
		\ ]
		\ }
	let g:tagbar_left = 1
	let g:tagbar_compact = 1
	let g:tagbar_width = 30
	let g:tagbar_zoomwidth = 0
	let g:tagbar_iconchars = ['|', '+']
	" }

if filereadable(expand("~/.vimrc.d"))
  source ~/.vimrc.d
endif
