if exists("*HighlightOperators")
    call HighlightOperators()
endif

syntax match cSynAfterType "\w\+_t"
hi! link cSynAfterType Type

syntax keyword cTodo NOTE contained
