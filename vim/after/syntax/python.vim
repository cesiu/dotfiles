if exists("*HighlightOperators")
    call HighlightOperators()
endif

" Python highlights these as built-ins...which isn't *wrong* -- they are, in
"  in fact, implemented as singleton classes -- it's just not as useful.
syntax keyword pySynAfterBoolean None True False
hi! link pySynAfterBoolean Boolean

syntax keyword pySynAfterKeyword self
hi! link pySynAfterKeyword Keyword

syntax keyword pySynAfterTypes TypeVar Generic Optional Any Union List Dict Tuple Set Iterable Iterator Generator Callable
hi! link pySynAfterTypes pythonBuiltin

syntax keyword pySynAfterExceptions TimeoutExpired
hi! link pySynAfterExceptions Structure

" It's not a perfect match, but attempt to highlight docstrings as comments.
syntax region pySynAfterDocstring start=/\z('''\|"""\)/ end=/\z1/ keepend contains=pythonEscape,pythonSpaceError,pythonDoctest,@Spell
hi! link pySynAfterDocstring Comment

" By default, escape sequences link to Special, which doesn't match C/Java.
hi! link pythonEscape SpecialChar
