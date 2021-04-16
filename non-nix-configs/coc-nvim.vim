" from vim.reaper
let g:coc_status_warning_sign = ''
let g:coc_status_error_sign = ''
hi CocWarningSign ctermfg=blue
hi CocErrorSign ctermfg=red
hi CocInfoSign ctermfg=yellow
hi CocHintSign ctermfg=green

nmap <Leader>cd <Plug>(coc-definition)
nmap <Leader>ct <Plug>(coc-type-definition)
nmap <Leader>ci <Plug>(coc-implementation)
nmap <Leader>crn <Plug>(coc-rename)
nnoremap <Leader>cc :<C-u>CocList commands<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction
