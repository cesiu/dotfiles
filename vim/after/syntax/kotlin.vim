if exists("*HighlightOperators")
    call HighlightOperators()
endif


syntax keyword ktSynAfterType String Array List Map
hi! link ktSynAfterType Type

syntax keyword ktTodo NOTE contained
