if exists("*HighlightOperators")
    call HighlightOperators()
endif

syntax keyword javaSynAfterKeyword this
hi! link javaSynAfterKeyword Keyword

hi! link javaDocParam Keyword
hi! link javaDocSeeTagParam Keyword
