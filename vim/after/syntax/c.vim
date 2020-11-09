if exists("*HighlightOperators")
    call HighlightOperators()
endif

syntax match cSynAfterType "\S\+_t"
hi! link cSynAfterType Type

syntax keyword cTodo NOTE contained
