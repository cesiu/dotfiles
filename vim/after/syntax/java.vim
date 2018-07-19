if exists("*HighlightOperators")
    call HighlightOperators()
endif

syntax keyword javaSynAfterKeyword this super
hi! link javaSynAfterKeyword Keyword

syntax keyword javaSynAfterType Object Boolean Byte Short Integer Long Float Double Character String List Map ArrayList LinkedList HashMap LinkedHashMap Set HashSet LinkedHashSet
hi! link javaSynAfterType Type

hi! link javaDocParam Keyword
hi! link javaDocSeeTagParam Keyword
