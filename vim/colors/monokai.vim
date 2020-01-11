" Monokai vim color scheme, based on:
"  https://github.com/sickill/vim-monokai
"  https://www.monokai.pro
"  https://github.com/thinkpixellab/flatland

let g:colors_name = "monokai"

set background=dark
set t_Co=256
hi clear

if exists("syntax_on")
  syntax reset
endif

" Base syntax colors:
let s:pink          = { "cterm": "204", "gui": "#ff6188" }
let s:green         = { "cterm": "113", "gui": "#a9dc76" }
let s:yellow        = { "cterm": "221", "gui": "#ffd866" }
let s:orange        = { "cterm": "209", "gui": "#fc9867" }
let s:purple        = { "cterm": "141", "gui": "#ab9df2" }
let s:cyan          = { "cterm":  "81", "gui": "#78dce8" }

" Grayscale colors:
let s:white         = { "cterm": "231", "gui": "#fcfcfa" }
let s:lighter_gray  = { "cterm": "250", "gui": "#bcbbbb" }
let s:light_gray    = { "cterm": "245", "gui": "#908e8f" }
let s:gray          = { "cterm": "242", "gui": "#6c6a6c" }
let s:dark_gray     = { "cterm": "240", "gui": "#575558" }
let s:darker_gray   = { "cterm": "237", "gui": "#3e3b3f" }
let s:darkest_gray  = { "cterm": "235", "gui": "#2c292d" }
let s:black         = { "cterm": "233", "gui": "#131d16" }

" Interface colors:
let s:blue          = { "cterm":  "33", "gui": "#2095f0" }
let s:dark_blue     = { "cterm":  "24", "gui": "#005f87" }
let s:off_white     = { "cterm": "230", "gui": "#fdf9f3" }
let s:tan           = { "cterm": "222", "gui": "#ffd787" }


" Highlights a given group with a style specified in an associative array.
"  Stolen from: https://github.com/noahfrederick/vim-hemisu
function! s:h(group, style)
  execute "highlight" a:group
        \ "ctermfg=" (has_key(a:style, "fg")    ? a:style.fg.cterm : "NONE")
        \ "ctermbg=" (has_key(a:style, "bg")    ? a:style.bg.cterm : "NONE")
        \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
        \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
        \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
        \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
endfunction


" Base mode settings:
call s:h("Normal",        { "bg": s:darkest_gray, "fg": s:white })
call s:h("Visual",        { "bg": s:dark_blue })
call s:h("Alternative",   { "bg": s:darker_gray,  "fg": s:white })
call s:h("Heading",       { "bg": s:darker_gray,  "fg": s:gray,
                          \ "cterm": "underline", "gui": "underline" })

" Cursor positioning:
call s:h("Cursor",        { "bg": s:light_gray })
call s:h("CursorLine",    { "bg": s:darker_gray })
call s:h("CursorColumn",  { "bg": s:darker_gray })
call s:h("CursorLineNr",  { "bg": s:darker_gray,  "fg": s:orange })

" Line numbers:
call s:h("LineNr",        { "bg": s:darker_gray,  "fg": s:gray })
call s:h("SignColumn",    { "bg": s:darker_gray })
" The guide at 80 characters:
call s:h("ColorColumn",   { "bg": s:darker_gray })
hi! link Conceal          LineNr

" Interface borders:
call s:h("VertSplit",     { "bg": s:dark_gray,    "fg": s:dark_gray })
call s:h("StatusLine",    { "bg": s:darker_gray,  "fg": s:lighter_gray })
call s:h("StatusLineNC",  { "bg": s:darkest_gray, "fg": s:gray })
hi! link StatusLineTerm   StatusLine
hi! link StatusLineTermNC StatusLineNC

" Tab names:
call s:h("Title",         { "fg": s:lighter_gray })
call s:h("TabLine",       { "bg": s:dark_gray,    "fg": s:lighter_gray })
call s:h("TabLineFill",   { "bg": s:darker_gray })
call s:h("TabLineSel",    { "bg": s:darkest_gray, "fg": s:white,
                          \ "cterm": "bold", "gui": "bold" })

" Active WildMenu selection:
call s:h("WildMenu",      { "bg": s:dark_gray,    "fg": s:white,
                          \ "cterm": "bold", "gui": "bold" })

" Keyword completion menu:
call s:h("Pmenu",         { "bg": s:darker_gray,  "fg": s:lighter_gray })
call s:h("PmenuSbar",     { "bg": s:dark_gray })
call s:h("PmenuThumb",    { "bg": s:light_gray })
call s:h("PmenuSel",      { "bg": s:dark_gray,    "fg": s:white,
                          \ "cterm": "bold", "gui": "bold" })

" Disable search highlighting:
call s:h("Search",        {})
call s:h("IncSearch",     {})

" Spell checking:
call s:h("SpellBad",      { "fg": s:orange,
                          \ "cterm": "underline", "gui": "underline"})
call s:h("SpellRare",     { "fg": s:yellow,
                          \ "cterm": "underline", "gui": "underline"})
hi! link SpellLocal       SpellRare
hi! link SpellCap         SpellRare

" vimdiff differences:
call s:h("DiffAdd",       { "fg": s:green })
call s:h("DiffChange",    { "fg": s:orange })
call s:h("DiffText",      { "fg": s:orange })
call s:h("DiffDelete",    { "fg": s:pink })

" ALE errors:
call s:h("ALEErrorSign",  { "bg": s:darker_gray, "fg": s:pink })
call s:h("ALEWarningSign",{ "bg": s:darker_gray, "fg": s:pink })

" Warning messages:
call s:h("Error",         { "fg": s:pink,
                          \ "cterm": "bold", "gui": "bold" })
call s:h("ErrorMsg",      { "fg": s:pink })
call s:h("WarningMsg",    { "fg": s:orange })
call s:h("Question",      { "fg": s:white })

" Directories (this also affects NERDTree) and files:
call s:h("Directory",     { "fg": s:blue,
                          \ "cterm": "bold", "gui": "bold" })
call s:h("EndOfBuffer",   { "fg": s:darkest_gray})
hi! link NonText          EndOfBuffer

" Comments :
call s:h("Comment",       { "fg": s:gray })
call s:h("Todo",          { "fg": s:yellow,
                          \ "cterm": "bold", "gui": "bold" })
call s:h("SpecialComment",{ "fg": s:light_gray,
                          \ "cterm": "bold", "gui": "bold" })

" Types :
call s:h("Type",          { "fg": s:cyan })
call s:h("StorageClass",  { "fg": s:pink })
hi! link Structure        Type
hi! link Typedef          Type

" Literals :
call s:h("String",        { "fg": s:tan })
call s:h("SpecialChar",   { "fg": s:yellow })
call s:h("Constant",      { "fg": s:purple })
hi! link Number           Constant
hi! link Character        Constant
hi! link Float            Constant
hi! link Boolean          Constant

" Expressions :
call s:h("Operator",      { "fg": s:pink })
call s:h("Identifier",    {})

" Statements :
call s:h("Statement",     { "fg": s:pink })
hi! link Conditional      Statement
hi! link Repeat           Statement

" Blocks :
call s:h("MatchParen",    { "bg": s:darker_gray,
                          \ "cterm": "bold", "gui": "bold" })

" Functions :
call s:h("Function",      { "fg": s:green })

" Keywords :
call s:h("Keyword",       { "fg": s:pink })
hi! link Label            Keyword
hi! link Exception        Keyword

" Preprocessor directives:
call s:h("PreProc",       { "fg": s:pink })
hi! link Include          PreProc
hi! link Define           PreProc
hi! link Macro            PreProc
hi! link PreCondit        PreProc

" Miscellaneous syntax:
call s:h("Special",       { "fg": s:pink })
hi! link Tag              Special
hi! link Delimiter        Special
hi! link Debug            Special
call s:h("Underlined",    { "gui": "underline", "cterm": "underline" })
