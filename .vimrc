" autocommands
autocmd BufWritePre * :%s/\s\+$//e
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
au FileChangedShell * echo "Warning: File changed on disk"

" highlighting extra spacesInsertLeave
highlight ExtraWhitespace ctermbg=gray guibg=gray
au BufReadPost * match ExtraWhitespace /^\s* \s\s*\|\s\+$/

" settings
set mouse=a
set encoding=utf8 " character encoding used inside Vim
set fileencoding=utf8 " character encoding for the files
set history=100
set colorcolumn=80
"set smartindent
set expandtab
"set clipboard=unnamed
set nu
" tabs and indentation
set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4

" commands
:command Dump :normal i echo "<pre>"; var_dump(); exit();<ESC>
:command Dp :.diffput

" 80 chars ruler colour
highlight ColorColumn ctermbg=DarkGray

" mappings
map oo o<ESC>

" convert multiple spaces into tabs
map <F10> :%retab!<CR>

" php 5.3 syntax validation
map <F9> :!/home/user/php53/bin/php -l %<CR>

" paste mode toggle
nnoremap <F8> :set invpaste paste?<CR>
set pastetoggle=<F8>
set showmode

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee %<CR>

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
