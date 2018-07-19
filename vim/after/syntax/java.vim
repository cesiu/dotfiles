if exists("*HighlightOperators")
    call HighlightOperators()
endif

syntax keyword javaSynAfterKeyword this super
hi! link javaSynAfterKeyword Keyword

hi! link javaDocParam Keyword
hi! link javaDocSeeTagParam Keyword
