syntax match asmSynAfterNumber "[#x][-]\=\x\+"
hi! link asmSynAfterNumber Number

syntax region asmSynAfterString start=/"/ end=/"/ keepend
hi! link asmSynAfterString String

syntax keyword asmTodo NOTE contained
