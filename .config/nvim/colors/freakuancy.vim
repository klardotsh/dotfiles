" Vim color file
"
" from https://pastebin.com/raw/Q5Te0Dct
" from https://www.reddit.com/r/unixporn/comments/ghunsw/fvwm_wip_unified_freebsd_theme/

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
	syntax reset
    endif
endif
let g:colors_name="desert"

hi Normal	guifg=White guibg=grey20

" highlight groups
hi Cursor	guibg=magenta guifg=slategrey
"hi CursorIM
"hi Directory
"hi DiffAdd
"hi DiffChange
"hi DiffDelete
"hi DiffText
"hi ErrorMsg
hi VertSplit	guibg=#c2bfa5 guifg=grey50 gui=none
hi Folded	guibg=grey30 guifg=red
hi FoldColumn	guibg=grey30 guifg=magenta
hi IncSearch	guifg=slategrey guibg=magenta
"hi LineNr
hi ModeMsg	guifg=Red
hi MoreMsg	guifg=Red
hi NonText	guifg=LightRed guibg=grey30
hi Question	guifg=springgreen
hi Search	guibg=magenta guifg=wheat
hi SpecialKey	guifg=red
hi StatusLine	guibg=#c2bfa5 guifg=black gui=none
hi StatusLineNC	guibg=#c2bfa5 guifg=grey50 gui=none
hi Title	guifg=indianred
hi Visual	gui=none guifg=magenta guibg=olivedrab
"hi VisualNOS
hi WarningMsg	guifg=red
"hi WildMenu
"hi Menu
hi Scrollbar    guifg=grey80
"hi Tooltip

" syntax highlighting groups
hi Comment	guifg=LightRed
hi Constant	guifg=#ffa0a0
hi Identifier	guifg=LightRed
hi Statement	guifg=magenta
hi PreProc	guifg=indianred
hi Type		guifg=darkmagenta
hi Special	guifg=grey80
"hi Underlined
hi Ignore	guifg=grey40
"hi Error
hi Todo		guifg=orangered guibg=yellow2

" color terminal definitions
hi SpecialKey	ctermfg=darkgreen
hi NonText	cterm=bold ctermfg=magenta
hi Directory	ctermfg=red
hi ErrorMsg	cterm=bold ctermfg=7 ctermbg=1
hi IncSearch	cterm=NONE ctermfg=magenta ctermbg=red
hi Search	cterm=NONE ctermfg=grey ctermbg=magenta
hi MoreMsg	ctermfg=red
hi ModeMsg	cterm=NONE ctermfg=red
hi LineNr	ctermfg=darkgray
hi Question	ctermfg=magenta
hi StatusLine	cterm=darkgray
hi StatusLineNC cterm=reverse
hi VertSplit	cterm=darkgray
hi Title	ctermfg=magenta
hi Visual	cterm=darkgray
hi VisualNOS	cterm=bold,underline
hi WarningMsg	ctermfg=1
hi WildMenu	ctermfg=0 ctermbg=3
hi Folded	ctermfg=darkgrey ctermbg=NONE
hi FoldColumn	ctermfg=darkgrey ctermbg=NONE
hi DiffAdd	ctermbg=4
hi DiffChange	ctermbg=5
hi DiffDelete	cterm=bold ctermfg=4 ctermbg=6
hi DiffText	cterm=bold ctermbg=1
hi Comment	ctermfg=darkgray
hi Constant	ctermfg=magenta
hi Special	ctermfg=magenta
hi Identifier	ctermfg=magenta
hi Statement	ctermfg=red
hi PreProc	ctermfg=red
hi Type		ctermfg=2
hi Underlined	cterm=underline ctermfg=5
hi Ignore	cterm=bold ctermfg=7
hi Ignore	ctermfg=darkgrey
hi Error	cterm=bold ctermfg=7 ctermbg=1

"vim: sw=4
