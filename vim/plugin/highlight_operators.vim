" Based on:
"  https://github.com/vim-scripts/cSyntaxAfter
"  https://github.com/Valloric/vim-operator-highlight

function! HighlightOperators()
    " Java highlighting does this weird thing where we must match parentheses
    "  individually here, otherwise operators within don't get matched.
    syntax match hlOpsOperator "+\|-\|\*\|%\|=\|<\|>\|;\|?\|:\|,\|&\||\|!\|\^\|\~\|(\|)\|{\|}\|\.\|\[\|\]\|/\(/\|*\)\@!"

    syntax match hlOpsFunction "\w\+\s*("me=e-1,he=e-1

    hi! link hlOpsOperator Operator
    hi! link hlOpsFunction Function
endfunction
