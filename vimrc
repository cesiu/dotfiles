" cesiu

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
" Set a type for text files.
autocmd BufNewFile,BufRead *.txt set filetype=txt

" Default indentation is four spaces.
set shiftwidth=4
set tabstop=4
set softtabstop=4
" Expand tabs to spaces.
set expandtab smarttab
" Enable autoindenting and smartindenting...
set autoindent smartindent
" ...except with Python since it's not C-like and comments get messed up...
autocmd FileType python setlocal nosmartindent indentexpr=GetPythonIndent(v:lnum)
" ...and, of course, we need tabs in Makefiles.
autocmd Filetype make setlocal noexpandtab

" Use two-space indents for CSS, HTML, JavaScript. 
autocmd FileType css setlocal ts=2 sts=2 sw=2
autocmd FileType html setlocal ts=2 sts=2 sw=2
autocmd FileType javascript setlocal ts=2 sts=2 sw=2

" Enable syntax highlighting.
syntax enable
" Use the Monokai color scheme: https://github.com/sickill/vim-monokai
colorscheme monokai
" Highlight operators: https://github.com/vim-scripts/cSyntaxAfter
autocmd FileType c,cpp,java,python,php,javascript call CSyntaxAfter()
" Check spelling and wrap text in txt files.
autocmd FileType txt setlocal spell spelllang=en_us textwidth=80

" Allow backspacing over autoindents, newlines, and start of insert.
set backspace=indent,eol,start
" Allow switching split windows while in insert mode.
imap <C-w> <C-o><C-w>
" Remap the home key to mimic '^' instead of '0'.
imap <Home> <C-o>^

" Turn on line numbers.
set number
" (Redundant if using Airline) Show the cursor position.
set ruler
" Always show the statusline.
set laststatus=2
" Show a guide at 80 chars.
set colorcolumn+=81
hi ColorColumn guibg=#2d2d2d ctermbg=246
" Highlight the current line.
set cursorline
" Always show one line beyond the cursor.
set scrolloff=1


" Plugin settings:
"execute pathogen#infect()

" Use Ctrl+N to toggle NERDTree. 
"map <C-n> :NERDTreeToggle<CR>
" Exit NERDTree if it's the last open buffer.
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Don't check syntax until save.
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_enter = 0

" Use the Minimalist Airline theme.
"let g:airline_theme='minimalist'
" Use patched Powerline fonts for Airline.
"let g:airline_powerline_fonts=1

" The following should be unnecessary given correct installation of powerline
"  patched fonts:
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
