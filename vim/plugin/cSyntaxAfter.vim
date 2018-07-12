" File: cSyntaxAfter.vim
" Author: Sergey Vlasov <sergey@vlasov.me>
" Last Change: 2015-03-10
" Version: 0.3
""
" This plugin was initially created for codeblock_dark color theme to
" highlight operators (+ - / * = <> () and others) in C-like languages.
" Why it's needed? Well, by default vim doesn't do that. After switching
" from Code::Block to vim I got really missed it.
"
" Then the plugin grew into something bigger. I started to use it to unify
" overal syntax highlighting for C-like languages.
"
" There are two ways to enable the plugin:
"
"   1. If you want to use CSyntaxAfter highlighting as is, put this into your
"   .vimrc:
"
"      autocmd! FileType c,cpp,java,php call CSyntaxAfter()
"
"   2. If you also want to extend the highlighting or add other C-like languages
"   support (Java, Go etc), create a corresponding <filetype>.vim file in
"   .vim/after/syntax/ and call CSyntaxAfter() from there instead.
"
"   WARNING: For same file type use either option (1.) or (2.), basically avoid calling
"   CSyntaxAfter() more than once.
"
"   For example, to distinguish "++" and "--" operator from "+" and "-" in C and C++,
"   remove "c" and "cpp" from autocmd above and instead create .vim/after/syntax/c.vim
"   with (cpp syntax is based on c):
"
"      if exists("*CSyntaxAfter")
"         call CSyntaxAfter()
"      endif
"
"      syntax match longOperators "++\|--"
"      hi longOperators guifg=green guibg=red
"

function! CSyntaxAfter()
    syntax keyword Boolean true false null NULL TRUE FALSE
    syntax keyword Statement namespace stderr stdin stdout new this self delete

    " All the operators *except* slash and star:
    syntax match csaOperator "[-+&|<>=!~.,;:%&^?]"
    " Stars and slashes may not be adjacent:
    syntax match csaOperator "[^\/*][\/*][^\/*]"ms=s+1,hs=s+1,me=e-1,he=e-1
    " Account for the beginnings and ends of lines:
    syntax match csaOperator "^[\/*][^\/*]"me=e-1,he=e-1
    syntax match csaOperator "[^\/*][\/*]$"ms=s+1,hs=s+1
    syntax match csaOperator "^[\/*]$"
    " Account for a slash or star immediately following a match:
    syntax match csaOperator "[^\/*]\@1<=[\/*][^\/*]"me=e-1,he=e-1

    " Also highlight functions:
    syntax match csaFunction "\w\+\s*("me=e-1,he=e-1

    hi link csaOperator Operator
    hi link csaFunction Function
endfunction
