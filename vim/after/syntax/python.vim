if exists("*HighlightOperators")
    call HighlightOperators()
endif

" Python highlights these as built-ins...which isn't *wrong* -- they are, in
"  in fact, implemented as singleton classes -- it's just not as useful.
syntax keyword pySynAfterBoolean None True False
hi! link pySynAfterBoolean Boolean

syntax keyword pySynAfterKeyword self
hi! link pySynAfterKeyword Keyword

syntax keyword pySynAfterExceptions TimeoutExpired
hi! link pySynAfterExceptions Structure

" By default, escape sequences link to Special, which doesn't match C/Java.
hi! link pythonEscape SpecialChar
