" cesiu

filetype on
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.txt set filetype=txt
autocmd BufNewFile,BufRead *.pde set filetype=java
autocmd BufNewFile,BufRead *.cu set filetype=c
autocmd BufNewFile,BufRead *.rkt set filetype=scheme

autocmd Filetype *          setlocal ts=3 sts=3 sw=3
autocmd Filetype cpp        setlocal ts=3 sts=3 sw=3
autocmd Filetype css        setlocal ts=2 sts=2 sw=2
autocmd Filetype idl        setlocal ts=2 sts=2 sw=2
autocmd Filetype php        setlocal ts=2 sts=2 sw=2
autocmd Filetype html       setlocal ts=2 sts=2 sw=2
autocmd Filetype scss       setlocal ts=2 sts=2 sw=2
autocmd Filetype python     setlocal ts=4 sts=4 sw=4
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype c          setlocal ts=4 sts=4 sw=4
autocmd Filetype sql        setlocal ts=2 sts=2 sw=2
autocmd Filetype java       setlocal ts=3 sts=3 sw=3
autocmd Filetype markdown   setlocal ts=4 sts=4 sw=4
autocmd Filetype tex        setlocal ts=2 sts=2 sw=2

filetype indent on
syntax enable
colorscheme monokai

set backspace=indent,eol,start
set expandtab smarttab
set shiftwidth=4
set tabstop=4
set number
set ruler
set laststatus=2
set ai
set si
"set textwidth=80
set scrolloff=1
set cursorline
set colorcolumn+=81
hi ColorColumn guibg=#2d2d2d ctermbg=246

imap <C-w> <C-o><C-w>
map <C-n> :NERDTreeToggle<CR>

"autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

autocmd Filetype c,java,python call CSyntaxAfter()
autocmd Filetype make       setlocal noexpandtab
autocmd Filetype txt        setlocal spell spelllang=en_us
autocmd Filetype txt        setlocal textwidth=80
