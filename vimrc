" Begin cesiu.

" Enable indentation and plugins dependent on filetype.
filetype plugin indent on

" Treat CUDA files as C files.
autocmd BufNewFile,BufRead *.cu set filetype=c
" Treat .md files as Markdown files.
autocmd BufNewFile,BufRead *.md set filetype=markdown
" Treat Processing files as Java files.
autocmd BufNewFile,BufRead *.pde set filetype=java
" Treat Racket files as Scheme files.
autocmd BufNewFile,BufRead *.rkt set filetype=scheme
" Treat Cal Poly's special 'mybashrc' as a shell file.
autocmd BufNewFile,BufRead .mybashrc set filetype=sh
" Set a type for text files.
autocmd BufNewFile,BufRead *.txt set filetype=txt

" Use Bash-esque file completion.
set wildmode=longest:full,full
set wildmenu


" Default indentation is four spaces.
set shiftwidth=4
set tabstop=4
set softtabstop=4
" Expand tabs to spaces.
set expandtab smarttab
" Enable autoindenting and smartindenting...
set autoindent smartindent
" ...except with Python since it's not C-like and comments get messed up...
autocmd FileType python
               \ setlocal nosmartindent indentexpr=GetPythonIndent(v:lnum)
" ...and, of course, we need tabs in Makefiles.
autocmd Filetype make setlocal noexpandtab
" Use two-space indents for CSS, HTML, JavaScript.
autocmd FileType css,html,javascript setlocal ts=2 sts=2 sw=2


" Enable syntax highlighting.
syntax enable
" Use the Monokai color scheme by default; Pencil for projections.
if $PENCIL == 1
    colorscheme pencil
else
    colorscheme monokai
endif
" Check spelling in TeX, text, and Markdown files.
autocmd FileType tex,txt,markdown setlocal spell spelllang=en_us
set spellfile=$HOME/dotfiles/spellfile.utf-8.add


" Allow backspacing over autoindents, newlines, and start of insert.
set backspace=indent,eol,start
" Treat the underscore as a word.
set iskeyword-=_
" Remap the home key to mimic '^' instead of '0'.
map <Home> ^
imap <Home> <C-o>^
" Apparently some other people don't keep their lines under 80 chars.
inoremap <Up> <C-o>g<Up>
nnoremap <Up> g<Up>
nnoremap j gj
vnoremap <Up> g<Up>
vnoremap j gj
inoremap <Down> <C-o>g<Down>
nnoremap <Down> g<Down>
nnoremap k gk
vnoremap <Down> g<Down>
vnoremap k gk

" Open vertical splits to the right.
set spr
" Allow switching split windows while in insert mode.
inoremap <C-w> <C-o><C-w>
" Allow switching to visual block mode from insert mode.
inoremap <C-v> <C-o><C-v>


" Turn on line numbers.
set number
" Use relative line numbers while yanking and deleting.
if exists('##TextYankPost')
    nnoremap y :set relativenumber<CR>y
    nnoremap d :set relativenumber<CR>d
    autocmd TextYankPost * set norelativenumber
    onoremap <Esc> <Esc>:set norelativenumber<CR>
endif

" (Redundant if using Airline) Show the cursor position.
set ruler
" Show the current command.
set showcmd
" Always show the statusline.
set laststatus=2
" Always show the tabline.
set showtabline=2
" Show a guide at 80 chars.
autocmd FileType * if &ft != "tex" && &ft != "txt" && &ft != "markdown"
                 \ | set colorcolumn+=81
" Highlight the current line.
set cursorline
" ...that's stupidly laggy. Mitigate it.
set lazyredraw
" Show partial wrapped lines at the end of the window.
set display=lastline
" Always show one line beyond the cursor.
set scrolloff=1
" Disable folding.
set nofoldenable

" Open all arguments as tabs.
tab all
" Jump to the last known cursor position.
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                    \ | exe "normal! g`\"" | endif

" Turn off Shift+U; it's too easy to hit accidentally.
nmap U <Nop>
" Persist undo history across sessions.
if has('persistent_undo')
    let undo_dir = expand('$HOME/.vim/undo_dir')
    if !isdirectory(undo_dir)
        call mkdir(undo_dir, "", 0700)
    endif
    set undodir=$HOME/.vim/undo_dir
    set undofile
endif


" Silence that beeping!
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=


" I write tons of LaTeX and I'm bad at marks.
let mapleader='`'
" Use 'p' to toggle paste mode.
set pastetoggle=<Leader>p
" Use 's' to strip trailing whitespace.
map <Leader>s :%s/\s\+$//e<CR>
" Use 'cd' to set the working directory.
map <Leader>cd :lcd %:p:h<CR>
" Use 'u' to toggle undotree.
map <Leader>u :silent! UndotreeToggle<CR>
" Use 'n' to toggle NERDTree.
map <Leader>n :silent! NERDTreeToggle<CR>


" Plugin settings:
silent! execute pathogen#infect()

" Exit NERDTree if it's the last open buffer.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
                 \     && b:NERDTree.isTabTree()) | q | endif

" Don't use any of the gitgutter mappings.
let g:gitgutter_map_keys = 0

" Don't check syntax until save.
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
" Underline ALE errors instead of highlighting.
hi ALEError ctermbg=NONE cterm=underline,bold guibg=NONE gui=underline,bold

" Use the Minimalist Airline theme by default; Silver for projections.
if $PENCIL == 1
    let g:airline_theme='silver'
else
    let g:airline_theme='minimalist'
endif
" Use Powerline fonts for Airline.
let g:airline_powerline_fonts=1
" Show ALE errors in Airline.
let g:airline#extensions#ale#enabled = 1

" The following should be unnecessary given correct installation of Nerd Fonts:
"if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
"endif
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'

" End cesiu.
