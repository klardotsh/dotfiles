" Vim syntax file
" Language:     zoom
" Maintainer:   Josh Klar <j@iv597.com>
" Last Change:  09 June 2013
" Version:      1

if exists("b:current_syntax")
  finish
endif

setlocal iskeyword+=:
setlocal iskeyword+=#
setlocal iskeyword+=!
syn case ignore

syn region zoomString1 start=/"/ end=/"/ skip=/\\"/
syn region zoomString2 start=/'/ end=/'/ skip=/\\'/

syn region hashBang start=/^#!\// end=/\n/

syn region zoomComment start=/--/ end=/$/
syn region zoomCommentMultiline start=/---/ end=/---/

syn region zoomImport start=/^\(>\|>>\)\s\S*\ / end=/\($\|\s\{--\}\)/

syn match zoomFuncDef /^<\?\(\t\|\s\)\?\w\+/

syn match zoomFuncReturn "->"

syn region zoomReturnVal start=/\s*>>>\s*/ end=/$/
syn match zoomReturnValShort "\s?\s"
syn match zoomReturnValShortFail "\s??\s"

syn keyword zoomStockTypes int null

highlight link hashBang Comment
highlight link zoomComment Comment
highlight link zoomCommentMultiline Comment
highlight link zoomString1 String
highlight link zoomString2 String

highlight link zoomImport Include

highlight link zoomFuncDef Function

highlight link zoomFuncReturn Structure

highlight link zoomReturnVal Conditional
highlight link zoomReturnValShort Conditional
highlight link zoomReturnValShortFail Conditional

highlight link zoomStockTypes Keyword

let b:current_syntax = "zoom"
