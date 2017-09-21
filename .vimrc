" AUTOCOMMANDS
" drop trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e
" Move a cursor to the location it was left on previous file editation
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" warn on file change while editting
au FileChangedShell * echo "Warning: File changed on disk"

" highlighting extra multiple occurences of space char
highlight ExtraWhitespace ctermbg=gray guibg=gray
" au BufReadPost * match ExtraWhitespace /^\s* \s\s*\|\s\+$/
" highlight phpt files the way php ones are
autocmd BufNewFile,BufRead *.phpt set ft=php

" 80 chars ruler colour
highlight ColorColumn ctermbg=DarkGray

" Load directory tree to a new tab on launch; in a very Q&D way ;-)
"autocmd VimEnter * :tabe /tmp/tree
"autocmd VimEnter * :%!find .
"autocmd VimEnter * :tabm
"autocmd VimEnter * :tabfirst

" SETTINGS
set mouse=a
set encoding=utf8 " character encoding used inside Vim
set fileencoding=utf8 " character encoding for the files
set history=1000
set colorcolumn=80
"set smartindent

" another ruler, 120 cols this time
"highlight OverLength ctermbg=red ctermfg=white
"match OverLength /\%<121v.\%>120v/

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
" PHP dump sequence
:command Dump :normal iecho "<pre>"; var_dump(); exit();<ESC>
" Diffing helper
:command Dp :.diffput
" PHP PDO construct (counts on Doctrine I)
:command Pdo :normal i$pdo = Doctrine_Manager::connection()->getDbh();<CR>$stmt = $pdo->prepare($query);<CR>$stmt->execute($params);<CR>$row = $stmt->fetch(PDO::FETCH_ASSOC)
" Convert 2 spaces to a tab char
:command Sp2Tb :%s/  /\t/g
" Convert file type to unix
:command ToUnix set ff=unix
" Format json
:command JSON :%!python -mjson.tool

" MAPPINGS
map oo o<ESC>
" convert multiple spaces into tabs
map <F10> :%retab!<CR>
" php 5.3 syntax validation
map <F9> :!/home/user/php53/bin/php -l %<CR>
" php Main version syntax validation
map <S-F9> :!php -l %<CR>
" python syntax validation
map <S-F12> :!sudo python3 -m py_compile %<CR>
map <F12> :!python -m py_compile %; rm %c<CR>
" paste mode toggle
nnoremap <F8> :set invpaste paste?<CR>
set pastetoggle=<F8>
set showmode

" toggle space char highlighting
:nnoremap <F3> :match ExtraWhitespace /^\t*\zs \+/<CR>
:nnoremap <F4> :match<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee %<CR>

:colorscheme default

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
