filetype on
autocmd BufNewFile,BufRead *.md set filetype=markdown

autocmd Filetype *          setlocal ts=3 sts=3 sw=3
autocmd Filetype cpp        setlocal ts=3 sts=3 sw=3
autocmd Filetype css        setlocal ts=2 sts=2 sw=2
autocmd Filetype idl        setlocal ts=2 sts=2 sw=2
autocmd Filetype php        setlocal ts=2 sts=2 sw=2
autocmd Filetype html       setlocal ts=2 sts=2 sw=2
autocmd Filetype scss       setlocal ts=2 sts=2 sw=2
autocmd Filetype python     setlocal ts=4 sts=4 sw=4
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype c          setlocal ts=3 sts=3 sw=3
autocmd Filetype sql        setlocal ts=2 sts=2 sw=2
autocmd Filetype java       setlocal ts=3 sts=3 sw=3
autocmd Filetype markdown   setlocal ts=4 sts=4 sw=4
autocmd BufNewFile,BufReadPost *.pde set filetype=java ts=2 sts=2 sw=2

filetype indent on

syntax enable
:set expandtab smarttab
:set shiftwidth=3
:set tabstop=3
set number
:set ruler
:set laststatus=2
set ai
set si
colorscheme monokai
":set textwidth=80
:set colorcolumn+=81
:hi ColorColumn guibg=#2d2d2d ctermbg=246

autocmd Filetype c,java,python call CSyntaxAfter()
