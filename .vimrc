" AUTOCOMMANDS
" drop trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e
" Move a cursor to the location it was left on previous file editation
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" warn on file change while editting
au FileChangedShell * echo "Warning: File changed on disk"
" yaml edit mode
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" highlighting extra multiple occurences of a space char
highlight ExtraWhitespace ctermbg=gray guibg=gray
" highlight phpt files the way php ones are
autocmd BufNewFile,BufRead *.phpt set ft=php
let php_minlines=666

" highlight lock files like json files
autocmd BufNewFile,BufRead *.lock set ft=javascript
"
" highlight typescript files like javascript onesl
autocmd BufNewFile,BufRead *.ts* set ft=javascript

" highlight .vimrc.d files the way .vimrc ones are
autocmd BufNewFile,BufRead .vimrc.d set ft=vim

" highlight Dockerfiles
autocmd BufNewFile,BufRead Dockerfile* set ft=dockerfile

" highlight .env files
autocmd BufNewFile,BufRead .env* set ft=sh

" highlight neon
autocmd BufNewFile,BufRead *.neon* set ft=yaml

" general conf SH
autocmd BufNewFile,BufRead *.conf set ft=sh

" api requester conf file
autocmd BufNewFile,BufRead *.api_request set ft=conf

" SQS files
autocmd BufNewFile,BufRead *.sqs set ft=sql

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

set nonu " no longer display line numbering
" tabs and indentation
"set noexpandtab " tab mode
set copyindent
set preserveindent
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab " space mode

" use specific text colours to work OK w/ terminal colour-scheme
set bg=light
" default split position on the right
set splitright
" default split position on the bottom
set splitbelow
" increase open tabs limit
set tabpagemax=100

set mmp=1048576

" prevent computationally intensive processing of arabic chars vim tries to do
" on pastes of binary data
if has('arabic')
    set noarabicshape
endif

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
:command! JSON :%!python -mjson.tool --no-ensure-ascii
" Prepare XML for the default formatter (`gg=G`)
:command! XML :%s/></>\r</g
" Resource config
:command! RS :source ~/.vimrc
" Switch ff display
:command! -nargs=1 FF e ++ff=<args>
" Switch ff display to unix - shortcut cmd
:command! Fu e ++ff=unix
" Search for snakecase and replace to camelcase
:command! Camel :%s/_\([a-z]\{1\}\)/\U\1\E/gc
" Run current buffer through bc
:command! Bc :!cat % |bc

" Getter + Setter from Getter macro i^R^R<registerName> (<80>kr ~= l)
let @g = 'yypcepublicwwigetlgU1lA() {returnjkkk$ybjjp^6li A;}j'
let @h = 'wyt wwpbbbbcevoidwrsftlyt(wwwi pbgulji = pbgul^cf this.jj^'
" Slack macro - convert text to alphabet emoji
let @a = 'i:alphabet-yellow-la:l'

" MAPPINGS
"
" convert multiple spaces into tabs (and vice versa in space mode)
map <F1> :%retab!<CR>
imap <F1> <NOP>

nmap <F2> :TagbarToggle<CR>

" toggle space char highlighting
nnoremap <F3> :match ExtraWhitespace /^\t*\zs \+/<CR>
nnoremap <F4> :match<CR>

" multimode wrap toggle
nnoremap <F5> :set wrap! wrap?<CR>
imap <F5> <C-O><F5>

" switch to/from vimdiff mode on current windows
nnoremap <F6> :windo diffthis<CR>
nnoremap <S-F6> :diffoff!<CR>

" toggle showing new line chars
nnoremap <F7> :set list! list? <CR>

" paste mode toggle
nnoremap <F8> :set invpaste paste?<CR>
set pastetoggle=<F8>
set showmode

" php syntax validation
map <F9> :!php -l %<CR>

" java syntax validation
map <F10> :!java-syntax % <CR>

" perl syntax validation
map <S-F11> :!perl -c %<CR>

" python syntax validation
map <F12> :!python -m py_compile %; rm %c<CR>
map <S-F12> :!sudo python3 -m py_compile %<CR>

" switch off Q command mode for unintentional annoyance
nnoremap Q <NOP>

map oo o<ESC>

" camelCase search bothwards
nnoremap <C-Right> /\u<CR>
nnoremap <C-Left> ?\u<CR>

" Save file using sudo
cmap WW w !sudo tee > /dev/null %<CR>

" Hex edit commands
:cmap HH :%!xxd<CR> :set filetype=xxd<CR>
:cmap GG :%!xxd -r<CR> :set binary<CR> :set filetype=<CR>

" PLUGINS
"
" Pathogen
execute pathogen#infect()
call pathogen#helptags() " generate helptags for everything in 'runtimepath'
syntax on
filetype plugin indent on

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

" enable non-VC override
if filereadable(expand("~/.vimrc.d"))
  source ~/.vimrc.d
endif
