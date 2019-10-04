" Pencil vim color scheme, based on:
"  https://github.com/reedes/vim-colors-pencil

let g:colors_name = "pencil"

set background=light
set t_Co=256
hi clear

if exists("syntax_on")
  syntax reset
endif

" Base syntax colors:
let s:dark_red      = { "cterm":  "88", "gui": "#870000" }
let s:dark_purple   = { "cterm":  "54", "gui": "#5f0087" }
let s:darker_blue   = { "cterm":  "17", "gui": "#00005f" }
let s:dark_blue     = { "cterm":  "19", "gui": "#0000af" }
let s:dark_cyan     = { "cterm":  "24", "gui": "#005f87" }
let s:dark_green    = { "cterm":  "22", "gui": "#005f00" }

" Grayscale colors:
let s:white         = { "cterm": "255", "gui": "#eeeeee" }
let s:lighter_gray  = { "cterm": "253", "gui": "#dadada" }
let s:light_gray    = { "cterm": "251", "gui": "#c6c6c6" }
let s:gray          = { "cterm": "245", "gui": "#8a8a8a" }
let s:dark_gray     = { "cterm": "240", "gui": "#585858" }
let s:darker_gray   = { "cterm": "238", "gui": "#444444" }
let s:subtle_black  = { "cterm": "234", "gui": "#1c1c1c" }
let s:black         = { "cterm": "232", "gui": "#080808" }

" Interface colors:
let s:light_blue    = { "cterm": "153", "gui": "#afd7ff" }


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
call s:h("Normal",        { "bg": s:white,        "fg": s:subtle_black })
call s:h("Visual",        { "bg": s:light_blue })
call s:h("Alternative",   { "bg": s:lighter_gray, "fg": s:subtle_black })
call s:h("Heading",       { "bg": s:lighter_gray, "fg": s:gray,
                          \ "cterm": "underline", "gui": "underline" })

" Cursor positioning:
call s:h("Cursor",        { "bg": s:light_blue })
call s:h("CursorLine",    { "bg": s:lighter_gray })
call s:h("CursorColumn",  { "bg": s:lighter_gray })
call s:h("CursorLineNr",  { "bg": s:lighter_gray, "fg": s:subtle_black })

" Line numbers:
call s:h("LineNr",        { "bg": s:lighter_gray, "fg": s:gray })
call s:h("SignColumn",    { "bg": s:lighter_gray })
" The guide at 80 characters:
call s:h("ColorColumn",   { "bg": s:lighter_gray })
hi! link Conceal          LineNr

" Interface borders:
call s:h("VertSplit",     { "bg": s:gray,         "fg": s:gray })
call s:h("StatusLine",    { "bg": s:lighter_gray, "fg": s:gray })
call s:h("StatusLineNC",  { "bg": s:lighter_gray, "fg": s:gray })
hi! link StatusLineTerm   StatusLine
hi! link StatusLineTermNC StatusLineNC

" Tab names:
call s:h("Title",         { "fg": s:gray })
call s:h("TabLine",       { "bg": s:light_gray,   "fg": s:gray })
call s:h("TabLineFill",   { "bg": s:lighter_gray })
call s:h("TabLineSel",    { "bg": s:white,        "fg": s:subtle_black,
                          \ "cterm": "bold", "gui": "bold" })

" Active WildMenu selection:
call s:h("WildMenu",      { "bg": s:lighter_gray, "fg": s:subtle_black,
                          \ "cterm": "bold", "gui": "bold" })

" Keyword completion menu:
call s:h("Pmenu",         { "bg": s:lighter_gray, "fg": s:gray })
call s:h("PmenuSbar",     { "bg": s:lighter_gray })
call s:h("PmenuThumb",    { "bg": s:gray })
call s:h("PmenuSel",      { "bg": s:lighter_gray, "fg": s:subtle_black,
                          \ "cterm": "bold", "gui": "bold" })

" Disable search highlighting:
call s:h("Search",        {})
call s:h("IncSearch",     {})

" Spell checking:
call s:h("SpellBad",      { "fg": s:dark_red,
                          \ "cterm": "underline", "gui": "underline"})
call s:h("SpellRare",     { "fg": s:dark_red,
                          \ "cterm": "underline", "gui": "underline"})
hi! link SpellLocal       SpellRare
hi! link SpellCap         SpellRare

" vimdiff differences:
call s:h("DiffAdd",       { "fg": s:dark_green })
call s:h("DiffChange",    { "fg": s:dark_blue })
call s:h("DiffText",      { "fg": s:dark_blue })
call s:h("DiffDelete",    { "fg": s:dark_red })

" Warning messages:
call s:h("Error",         { "fg": s:dark_red,
                          \ "cterm": "bold", "gui": "bold" })
call s:h("ErrorMsg",      { "fg": s:dark_red })
call s:h("WarningMsg",    { "fg": s:dark_red })
call s:h("Question",      { "fg": s:subtle_black })

" Directories (this also affects NERDTree) and files:
call s:h("Directory",     { "fg": s:dark_blue,
                          \ "cterm": "bold", "gui": "bold" })
call s:h("EndOfBuffer",   { "fg": s:dark_gray })
hi! link NonText          EndOfBuffer

" Comments :
call s:h("Comment",       { "fg": s:darker_gray })
call s:h("Todo",          { "fg": s:dark_red,
                          \ "cterm": "bold", "gui": "bold" })
call s:h("SpecialComment",{ "fg": s:darker_gray,
                          \ "cterm": "bold", "gui": "bold" })

" Types :
call s:h("Type",          { "fg": s:dark_red })
call s:h("StorageClass",  { "fg": s:dark_red })
hi! link Structure        Type
hi! link Typedef          Type

" Literals :
call s:h("String",        { "fg": s:dark_purple })
call s:h("SpecialChar",   { "fg": s:dark_blue })
call s:h("Constant",      { "fg": s:dark_purple })
hi! link Number           Constant
hi! link Character        Constant
hi! link Float            Constant
hi! link Boolean          Constant

"" Expressions :
call s:h("Operator",      { "fg": s:darker_blue,
                          \ "cterm": "bold", "gui": "bold" })
call s:h("Identifier",    {})

" Statements :
call s:h("Statement",     { "fg": s:darker_blue,
                          \ "cterm": "bold", "gui": "bold" })
hi! link Conditional      Statement
hi! link Repeat           Statement

" Blocks :
call s:h("MatchParen",    { "bg": s:lighter_gray, "fg": s:dark_blue,
                          \ "cterm": "bold", "gui": "bold" })

" Functions :
call s:h("Function",      { "fg": s:black,
                          \ "cterm": "bold", "gui": "bold" })

" Keywords :
call s:h("Keyword",       { "fg": s:darker_blue,
                          \ "cterm": "bold", "gui": "bold" })
hi! link Label            Keyword
hi! link Exception        Keyword

" Preprocessor directives:
call s:h("PreProc",       { "fg": s:darker_blue,
                          \ "cterm": "bold", "gui": "bold" })
hi! link Include          PreProc
hi! link Define           PreProc
hi! link Macro            PreProc
hi! link PreCondit        PreProc

" Miscellaneous syntax:
call s:h("Special",       { "fg": s:darker_blue,
                          \ "cterm": "bold", "gui": "bold" })
hi! link Tag              Special
hi! link Delimiter        Special
hi! link Debug            Special
call s:h("Underlined",    { "gui": "underline", "cterm": "underline" })
