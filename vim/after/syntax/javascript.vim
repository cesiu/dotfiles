if exists("*HighlightOperators")
    call HighlightOperators()
endif

syntax keyword jsSynAfterKeyword var let function this async await
hi! link jsSynAfterKeyword Keyword

" For whatever reason, javaScriptNumber by default links to javaScriptValue,
"  which isn't defined.
hi! link javaScriptNumber Number
