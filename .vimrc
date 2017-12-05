" AUTOCOMMANDS
" drop trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e
" Move a cursor to the location it was left on previous file editation
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" warn on file change while editting
au FileChangedShell * echo "Warning: File changed on disk"

" highlighting extra multiple occurences of space char
highlight ExtraWhitespace ctermbg=gray guibg=gray
" highlight phpt files the way php ones are
autocmd BufNewFile,BufRead *.phpt set ft=php

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
set noexpandtab " tab mode
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4
"set expandtab " space mode

" COMMANDS
"
" Diffing helper
:command! Dp :.diffput
" Convert 2 spaces to a tab char
:command! Sp2Tb :%s/  /\t/g
" Convert file type to unix
:command! ToUnix set ff=unix
" Format json
:command! JSON :%!python -mjson.tool
" Resource config
:command! RS :source ~/.vimrc

" MAPPINGS
map oo o<ESC>
" convert multiple spaces into tabs
map <F10> :%retab!<CR>

" php syntax validation
map <F9> :!php -l %<CR>

" perl syntax validation
map <F11> :!perl -c %<CR>

" python syntax validation
map <S-F12> :!sudo python3 -m py_compile %<CR>
map <F12> :!python -m py_compile %; rm %c<CR>

" paste mode toggle
nnoremap <F8> :set invpaste paste?<CR>
set pastetoggle=<F8>
set showmode

" use darker text colours
set bg=light
" default split position on the right
set splitright
" increase open tabs limit
set tabpagemax=100

" toggle space char highlighting
:nnoremap <F3> :match ExtraWhitespace /^\t*\zs \+/<CR>
:nnoremap <F4> :match<CR>

" switch off Q command mode for unintentional annoyance. Still waiting to
" learn to utilize it... ;-)
:nnoremap Q <NOP>
" annoying F1 missclicks - would do :help for help anyways
:nnoremap <F1> <NOP>
:inoremap <F1> <NOP>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!!<CR> w !sudo tee %<CR>

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
	let g:tagbar_iconchars = ['▷', '◢']
	" }
