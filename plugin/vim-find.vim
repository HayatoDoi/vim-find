" =====================================================
" File name          : vim-find.vim
" Author             : Hayato Doi
" License            : MIT
" Copyright (c) 2021, Hayato Doi
" =====================================================
if !exists('g:find_binary')
	let g:find_binary = 'find'
endif
if !exists('g:find_opt')
	let g:find_opt = ' . -name '
endif

function! s:Find(content)
	if empty(a:content)
		let l:text = expand("<cfile>")
	else
		let l:text = a:content
	endif
	let l:cmd = g:find_binary . ' ' . g:find_opt .' ''' . l:text . ''' | sort'
	let l:find_result = systemlist(l:cmd)
	let l:qflist = []
	if len(l:find_result) == 0
		echo 'No match found for ' . l:text
		return
	endif
	for file in l:find_result
		call add(l:qflist, {'filename':file})
	endfor
	call setqflist(l:qflist)
	exe 'botright' 'copen'
	redraw!
endfunction

command! -nargs=* -complete=file Find call s:Find(<q-args>)

