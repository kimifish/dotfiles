

" ──────────────────────── Basic settings {{{
set nocompatible              " be iMproved, required
filetype off                  " required  
set number
set enc=utf-8	    " utf-8 по дефолту в файлах
set ls=2            " всегда показываем статусбар
set scrolloff=5	    " 5 строк при скролле за раз
set incsearch		" While typing a search command, show where the pattern, as it was typed so far, matches.
set smartcase		" Override the 'ignorecase' option if the search pattern contains uppercase characters.
set hlsearch	    " подсветка результатов поиска
hi Search ctermbg=DarkGreen
hi Search ctermfg=Black
" Буквенные команды на кириллице
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
" Время ожидания второго символа на случай комбинации
set timeoutlen=250 ttimeoutlen=0

" ░░░░░░░░░░░░ Symbols & Colors ░░░░░░░░░░░░

" vertical split symbol (space at the end is important)
set fillchars+=vert:\ 

" ░░░░░░░░░░░░ Wraps ░░░░░░░░░░░░
function! ToggleWrap(onoff) " {{{
	if a:onoff == 1
		let l:onWrap = 1
	elseif a:onoff == 0
		let l:onWrap = 0
	else
		if &wrap
			let l:onWrap = 0
		else
			let l:onWrap = 1
		endif
	endif

  if l:onWrap == 0
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> j
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> k
    silent! nunmap <buffer> <End>
    return "Wrap OFF"
  else
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display=lastline
    nnoremap <buffer> j gj
    nnoremap <buffer> k gk
    nnoremap <buffer> <Home> g<Home>
    nnoremap <buffer> <End> g<End>
    return "Wrap ON"
  endif
endfunction " }}}
call ToggleWrap(0)
set linebreak

" ░░░░░░░░░░░░ Registers ░░░░░░░░░░░░
" системный буфер обмена задаём вим-регистром по умолчанию
"set clipboard=unnamed
"if has('unnamedplus')
"    set clipboard=unnamed,unnamedplus
"endif

" ░░░░░░░░░░░░ Folding ░░░░░░░░░░░░
hi Folded ctermbg=0
set foldmethod=indent
set foldlevelstart=0 " Open with first level open, other foldings closed

" ░░░░░░░░░░░░ Indents ░░░░░░░░░░░░
set autoindent
set backspace=indent,eol,start
let g:indentLine_char = "|"
let g:indentLine_color_term = 236
let g:pymode_options_colorcolumn = 0

" ░░░░░░░░░░░░ Tabulation ░░░░░░░░░░░░
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
" Только жёсткие табы по четыре. Могут поплыть при печати например. Или при
" выводе в системе. Зато никаких пробелов нигде не добавляется.

" ░░░░░░░░░░░░ Backups & Swaps ░░░░░░░░░░░░
set nobackup 	     " no backup files
set nowritebackup    " only in case you don't want a backup file while
set noswapfile 	     " no swap files

filetype on
filetype plugin on
filetype plugin indent on

" ░░░░░░░░░░░░ Syntax highlight
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
set synmaxcol=120 " Максимально столбцов для подсветки синтаксиса. Иначе жутко тупит.
syntax enable
colorscheme desert
" Это схема расцветки, для разнообразия сойдет, но вообще
" мне не очень понравилось.
"set background=dark
"let g:solarized_termtrans=1
""let g:solarized_termcolors=256
"call togglebg#map("<F5>")
"colorscheme solarized

" ──────────────────────── Basic settings }}}

" ──────────────────────── Autocommands {{{
"
" Автозапуск NerdTree, если вим открывает каталог
augroup auto_nerdtree
	autocmd!
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
augroup END

" ──────────────────────── Filetype-specific autocommands {{{

" --- template language support (SGML / XML too) ---
augroup filetype_template
	autocmd!
	autocmd bufnewfile,bufread *.rhtml setlocal ft=eruby
	autocmd BufNewFile,BufRead *.mako setlocal ft=mako
	autocmd BufNewFile,BufRead *.tmpl setlocal ft=htmljinja
	autocmd BufNewFile,BufRead *.py_tmpl setlocal ft=python
augroup END

let html_no_rendering=1
let g:closetag_default_xml=1
let g:sparkupNextMapping='<c-l>'

" ───┤ Text ├───{{{
augroup filetype_text
	autocmd!
	autocmd FileType text call ToggleWrap(1)
augroup END " }}}

" ───┤ Python ├───{{{
augroup filetype_python
	autocmd!
	autocmd FileType python nnoremap <buffer> <localleader>c I#<esc> " закоментить строку	
	autocmd FileType python call ToggleWrap(0)
	autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 formatoptions+=croq softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
	" Жёсткие табы по 8, видимые по 4, дополняет пробелами.
augroup END " }}}

" ───┤ Vim ├───{{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END "}}}

" ───┤ Wiki ├───{{{
augroup filetype_wiki
	autocmd!
	autocmd BufNewFile,BufRead *.wiki setlocal ft=wiki
	autocmd FileType wiki onoremap <buffer> lr <c-u>:execute "normal! ?\<ref\r:nohlsearch\rvt>lt>l"<cr> 
augroup END "}}}

" ───┤ Pyrex ├───{{{
augroup filetype_pyrex
	autocmd!
	autocmd FileType pyrex setlocal expandtab shiftwidth=4 tabstop=8 
	\ softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END
"}}}

" ───┤ HTML ├───{{{
augroup filetype_html
	autocmd!
	autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
	autocmd FileType html,htmldjango,htmljinja,eruby,mako let b:closetag_html_style=1
	autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako source ~/.vim/scripts/closetag.vim
	autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
augroup END "}}}

" ───┤ CSS ├───{{{
augroup filetype_css
	autocmd!
	autocmd FileType css set omnifunc=csscomplete#CompleteCSS
	autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
augroup END
"}}}

" ───┤ Javascript ├───{{{
let javascript_enable_domhtmlcss=1
augroup filetype_js
	autocmd!
	autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
	autocmd BufNewFile,BufRead *.json setlocal ft=javascript
augroup END
"}}}
" ──────────────────────── END of Filetype-specific autocommands }}}

" ──────────────────────── Autocommands END }}}

" ──────────────────────── Mappings {{{
"
" Переключаем перенос по \w
noremap <silent> <Leader>w :echom ToggleWrap(2)<CR>

" Отступы по табу
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Поиск с very magic (:help magic)
nnoremap / /\v

noremap <Leader>ls :execute "normal! gg" . '/\v .+ +$' . "\<cr>"

" Нормальный режим по jk вместо Esc
inoremap qq <esc>
inoremap йй <esc>

" Разрыв строки по Лидер-Ввод
nnoremap <Leader><CR> i<CR><Esc>
"nnoremap <Leader>o m`o<Esc>``
"nnoremap <Leader>O m`O<Esc>``
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>
nnoremap <silent> oo :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> OO :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" Foldings
nnoremap <Leader>fm :set foldmethod=marker<CR>
nnoremap <Leader>fi :set foldmethod=indent<CR>
nnoremap <Leader>fs :set foldmethod=syntax<CR>

" inoremap <esc> <nop>
              
" Отключить стрелки, чтобы отучиться от них
nnoremap <Up> <nop>                     
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>

inoremap <Up> <C-o>gk
inoremap <Down> <C-o>gj

" Удобно переключаемся между буферами
nnoremap <silent> <F12> :bn!<CR>
nnoremap <silent> <F9> :bp!<CR>
nnoremap <silent> <F10> :ToggleBufExplorer<CR>

nnoremap <c-s> :w<CR>
inoremap <c-s> <Esc>:w<CR>a
"nnoremap <Leader>d :r !ds<CR>o<tab><tab>
"vnoremap <c-i> <Esc>:r !ds<CR>o<tab><tab>
"
" Редактирование и загрузка vimrс	
nnoremap <Leader>ev :split $MYVIMRC<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>

" Работа с окнами
nnoremap <Leader>= :vsplit<CR>
nnoremap <Leader>- :split<CR>

noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Визуальный режим
inoremap <C-z><C-z> <Esc>:wq<CR>

" Работа буфферами
nnoremap <C-q> :bd<CR> 	   " CTRL+Q - закрыть текущий буффер'

" TagBar настройки
noremap <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 0 " автофокус на Tagbar при открытии

" показать NERDTree на F3
" noremap <F3> :NERDTreeTabsToggle<CR>
noremap <F3> :Vifm<CR>

" TaskList настройки
noremap <F2> :TaskList<CR> 	   " отобразить список тасков на F2

" ──────────────────────── Mappings END }}}

" ──────────────────────── NerdTree settings {{{
" игнорируемые файлы с расширениями
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']  
" Автозапуск колонок слева и справа 
"autocmd vimenter * TagbarToggle
"autocmd vimenter * NERDTree

" Автозапуск, если вим запущен без открытия файла
"autocmd vimenter * if !argc() | NERDTree | endif

" ──────────────────────── NerdTree settings END }}}

" ──────────────────────── Vundle settings {{{

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'		" let Vundle manage Vundle, required

"---------=== Code/project navigation ===-------------
Plugin 'scrooloose/nerdtree' 	    	" Project and file navigation
Plugin 'majutsushi/tagbar'          	" Class/module browser

"------------------=== Other ===----------------------
Plugin 'bling/vim-airline'   	    	" Lean & mean status/tabline for vim
Plugin 'fisadev/FixedTaskList.vim'  	" Pending tasks list
Plugin 'rosenfeld/conque-term'      	" Consoles as buffers
Plugin 'tpope/vim-surround'	   	" Parentheses, brackets, quotes, XML tags, and more
Plugin 'vifm/vifm.vim'          " Vifm integration

"---------------=== Languages support ===-------------
" --- Python ---
Plugin 'klen/python-mode'	        " Python mode (docs, refactor, lints, highlighting, run and ipdb and more)
Plugin 'davidhalter/jedi-vim' 		" Jedi-vim autocomplete plugin
Plugin 'mitsuhiko/vim-jinja'		" Jinja support for vim
Plugin 'kien/ctrlp.vim' " FuzzyFinder (sort of)
Plugin 'scrooloose/nerdcommenter' " Comments
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'jeffkreeftmeijer/vim-numbertoggle' " относительные и абсолютные номера строк
Plugin 'vim-airline/vim-airline-themes' " ну всё ясно же
Plugin 'chikamichi/mediawiki.vim'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install -all'} " Нечёткий поиск
Plugin 'junegunn/fzf.vim' 
Plugin 'tpope/vim-fugitive'

call vundle#end()            		" required
" ──────────────────────── Vundle settings END }}}

" ──────────────────────── Vim-Airline Settings {{{
let g:airline_powerline_fonts = 1
set t_Co=256
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif

set laststatus=2
let g:airline_theme='badwolf'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" unicode symbols
 let g:airline_left_sep = '»'
 let g:airline_left_sep = '▶'
 let g:airline_right_sep = '«'
 let g:airline_right_sep = '◀'
 let g:airline_symbols.linenr = '␊'
 let g:airline_symbols.linenr = '␤'
 let g:airline_symbols.linenr = '¶'
 let g:airline_symbols.branch = '⎇'
 let g:airline_symbols.paste = 'ρ'
 let g:airline_symbols.paste = 'Þ'
 let g:airline_symbols.paste = '∥'
 let g:airline_symbols.whitespace = 'Ξ'

 " airline symbols
 let g:airline_left_sep = ''
 let g:airline_left_alt_sep = ''
 let g:airline_right_sep = ''
 let g:airline_right_alt_sep = ''
 let g:airline_symbols.branch = ''
 let g:airline_symbols.readonly = ''
 let g:airline_symbols.linenr = ''
function! MyLineNumber()
    return substitute(line('.'), '\d\@<=\(\(\d\{3\}\)\+\)$', ',&', 'g'). '/'.
        \    substitute(line('$'), '\d\@<=\(\(\d\{3\}\)\+\)$', ',&', 'g')
endfunction

call g:airline#parts#define('linenr', {'function': 'MyLineNumber', 'accents': 'bold'})
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#vcs_priority = ["git", "mercurial"]

let g:airline_section_a = airline#section#create(['mode','crypt','paste','spell'])
let g:airline_section_b = '%{FugitiveStatusline()}'
let g:airline_section_z = airline#section#create(['%3p%%: ', 'linenr', ':%3v'])

" ──────────────────────── Vim-Airline Settings END }}}

" ──────────────────────── FZF settings {{{
" This is the default extra key bindings
let g:fzf_action = {
 \ 'ctrl-t': 'tab split',
 \ 'ctrl-x': 'split',
 \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }
"
" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }
"
" Customize fzf colors to match your color scheme
let g:fzf_colors =
 \ { 'fg':      ['fg', 'Normal'],
 \ 'bg':      ['bg', 'Normal'],
 \ 'hl':      ['fg', 'Comment'],
 \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
 \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
 \ 'hl+':     ['fg', 'Statement'],
 \ 'info':    ['fg', 'PreProc'],
 \ 'border':  ['fg', 'Ignore'],
 \ 'prompt':  ['fg', 'Conditional'],
 \ 'pointer': ['fg', 'Exception'],
 \ 'marker':  ['fg', 'Keyword'],
 \ 'spinner': ['fg', 'Label'],
 \ 'header':  ['fg', 'Comment'] }
"
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'


 "Mapping selecting mappings>
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

 " Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

 " Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
" ──────────────────────── FZF settings END }}}

" ──────────────────────── Python-mode settings {{{

" отключаем автокомплит по коду (у нас вместо него используется jedi-vim)
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0

" документация
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'

" проверка кода
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_ignore="E501,W601,C0110"

" провека кода после сохранения
let g:pymode_lint_write = 1

" поддержка virtualenv
let g:pymode_virtualenv = 1

" установка breakpoints
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" подстветка синтаксиса
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" отключить autofold по коду
let g:pymode_folding = 0

" возможность запускать код
let g:pymode_run = 0

" Disable choose first function/method at autocomplete
let g:jedi#popup_select_first = 0

" ──────────────────────── Python-mode settings END }}}

" Оборачивание в тройные {} по Sv в визуальном режиме с запросом подсказки
let g:surround_118 = "# \1Blockname: \1 {{{\n \r \n # }}}"
