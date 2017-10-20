" This appears to be the best way to emulate 'VisualEnter' and 'VisualLeave'
"  events: https://stackoverflow.com/questions/15561132/
"          run-command-when-vim-enters-visual-mode

function! SetCursorLineNrVisual()
    set updatetime=0
    set relativenumber
    return ''
endfunction

function! ResetCursorLineNr()
    set updatetime=4000
    set norelativenumber
endfunction

vnoremap <silent> <expr> <SID>SetCursorLineNrVisual SetCursorLineNrVisual()
nnoremap <silent> <script> v v<SID>SetCursorLineNrVisual <left>
nnoremap <silent> <script> V V<SID>SetCursorLineNrVisual <left>
nnoremap <silent> <script> <C-v> <C-v><SID>SetCursorLineNrVisual <left>

autocmd CursorHold * call ResetCursorLineNr()
