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
" Set a type for Swift files.
autocmd BufNewFile,BufRead *.swift set ft=swift

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
autocmd FileType css,html,javascript setlocal ts=2 sts=2 sw=2

" Enable syntax highlighting.
syntax enable
" Use the Monokai color scheme: https://github.com/sickill/vim-monokai
colorscheme monokai
let g:projector_colorscheme='pencil'
" Highlight operators: https://github.com/vim-scripts/cSyntaxAfter
autocmd FileType c,cpp,java,python,php,javascript call CSyntaxAfter()
" Check spelling in TeX, text, and Markdown files.
autocmd FileType tex,txt,markdown setlocal spell spelllang=en_us
set spellfile=$HOME/dotfiles/spellfile.utf-8.add
" Underline misspellings instead of highlighting.
hi SpellBad ctermbg=NONE cterm=underline,bold guibg=NONE gui=underline,bold
hi SpellCap ctermbg=NONE cterm=underline guibg=NONE gui=underline
hi SpellLocal ctermbg=NONE cterm=underline guibg=NONE gui=underline
hi SpellRare ctermbg=NONE cterm=underline guibg=NONE gui=underline
" This wraps text in txt files, but realistically, I never end up using it,
"  and it just ends up annoying me:
"autocmd FileType txt setlocal textwidth=80

" Allow backspacing over autoindents, newlines, and start of insert.
set backspace=indent,eol,start
" Allow switching split windows while in insert mode.
inoremap <C-w> <C-o><C-w>
" I always forgot that this isn't a thing.
cnoreabbrev hsplit split
" Remap the home key to mimic '^' instead of '0'.
imap <Home> <C-o>^
" Apparently some other people don't keep their lines under 80 chars.
noremap <Up> g<Up>
inoremap <Up> <C-o>g<Up>
noremap j gj
noremap <Down> g<Down>
inoremap <Down> <C-o>g<Down>
noremap k gk
" When was the last time you used Ctrl+P instead of 'k'?
set pastetoggle=<C-p>
" Allow switching to visual block mode from insert mode.
inoremap <C-v> <C-o><C-v>

" Turn on line numbers.
set number
" Use relative line numbers while yanking and deleting.
nnoremap y :set relativenumber<CR>y
nnoremap d :set relativenumber<CR>d
" Sometimes the naive solution is the safest solution.
onoremap y y:set norelativenumber<CR>
onoremap d d:set norelativenumber<CR>
onoremap h h:set norelativenumber<CR>
onoremap j j:set norelativenumber<CR>
onoremap k k:set norelativenumber<CR>
onoremap l l:set norelativenumber<CR>
onoremap w w:set norelativenumber<CR>
onoremap b b:set norelativenumber<CR>
onoremap $ $:set norelativenumber<CR>
onoremap ^ ^:set norelativenumber<CR>
onoremap gg gg:set norelativenumber<CR>
onoremap G G:set norelativenumber<CR>
onoremap <Esc> <Esc>:set norelativenumber<CR>
" (Redundant if using Airline) Show the cursor position.
set ruler
" Show the current command.
set showcmd
" Always show the statusline.
set laststatus=2
" Show a guide at 80 chars.
autocmd FileType * if &ft != "tex" && &ft != "txt" && &ft != "markdown" | set colorcolumn+=81
" Highlight the current line.
set cursorline
" ...that's studidly laggy. Mitigate it.
set lazyredraw
" Show partial wrapped lines at the end of the window.
set display=lastline
" Always show one line beyond the cursor.
set scrolloff=1
" Jump to the last known cursor position.
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" Persist undo history across sessions.
if has('persistent_undo')
    let undo_dir = expand('$HOME/.vim/undo_dir')
    if !isdirectory(undo_dir)
        call mkdir(undo_dir, "", 0700)
    endif
    set undodir=$HOME/.vim/undo_dir
    set undofile
endif

" Silence that infernal beeping!
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
" Use Bash-esque file completion.
set wildmode=longest,full
set wildmenu


" Plugin settings:
silent! execute pathogen#infect()

" Use Ctrl+m to toggle undotree.
map <C-m> :silent! UndotreeToggle<CR>
" Use Ctrl+n to toggle NERDTree.
map <C-n> :silent! NERDTreeToggle<CR>
" Exit NERDTree if it's the last open buffer.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Don't use any of the gitgutter mappings.
let g:gitgutter_map_keys = 0

" Don't check syntax until save.
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
" Underline ALE errors instead of highlighting.
hi ALEError ctermbg=NONE cterm=underline,bold guibg=NONE gui=underline,bold

" Use the Minimalist Airline theme.
let g:airline_theme='minimalist'
let g:airline_projector_theme='sol'
" Use patched Powerline fonts for Airline.
let g:airline_powerline_fonts=1

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

" End cesiu.
