if exists("*HighlightOperators")
    call HighlightOperators()
endif

syntax keyword javaSynAfterKeyword this super
hi! link javaSynAfterKeyword Keyword

syntax keyword javaSynAfterType Object Boolean Byte Short Integer Long Float Double Character String Iterable Iterator Collection Collections List Map Array Arrays ArrayList LinkedList HashMap LinkedHashMap Set HashSet LinkedHashSet Stream Collectors Function
hi! link javaSynAfterType Type

hi! link javaDocParam Keyword
hi! link javaDocSeeTagParam Keyword

syntax keyword javaTodo NOTE contained
