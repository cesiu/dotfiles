" lstlisting.vim: support for the lstlisting package
"   Author : Charles E. Campbell
"   Date   : Sep 09, 2018
"   Version: 1c	ASTRO-ONLY
" NOTE: Place this file in your $HOME/.vim/after/syntax/tex/ directory (make it if it doesn't exist)
" If s:tex_fast contains "v" AND g:tex_verbspell exists, then the lstlisting texZone will permit spellchecking there.
let b:loaded_lstlisting  = "v1c"
syn region texZone	start="\\lstinputlisting"	end="{\s*[a-zA-Z/.0-9_^]\+\s*}"

" by default, enable all region-based highlighting
let s:tex_fast= "bcmMprsSvV"
if exists("g:tex_fast")
 if type(g:tex_fast) != 1
  " g:tex_fast exists and is not a string, so
  " turn off all optional region-based highighting
  let s:tex_fast= ""
 else
  let s:tex_fast= g:tex_fast
 endif
endif

if s:tex_fast =~# 'v'
 if exists("g:tex_verbspell") && g:tex_verbspell
  syn region texZone	matchgroup=texBeginEnd start="\\begin{lstlisting}"	matchgroup=texBeginEnd end="\\end{lstlisting}\|%stopzone\>"	contains=@Spell
 else
  syn region texZone	matchgroup=texBeginEnd start="\\begin{lstlisting}"	matchgroup=texBeginEnd end="\\end{lstlisting}\|%stopzone\>"
 endif
else
 syn region texZone		matchgroup=texBeginEnd start="\\begin{lstlisting}"	matchgroup=texBeginEnd end="\\end{lstlisting}\|%stopzone\>"
endif
