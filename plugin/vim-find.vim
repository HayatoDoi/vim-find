" =====================================================
" File name          : vim-find.vim
" Author             : Hayato Doi
" License            : MIT
" Copyright (c) 2023, Hayato Doi
" =====================================================
if !exists('g:find_binary')
	let g:find_binary = 'find'
endif
if !exists('g:find_opt')
	let g:find_opt = ' . -type f -name '
endif

function! s:Find(content)
	if empty(a:content)
		let l:text = expand("<cfile>")
	else
		let l:text = a:content
	endif
	let l:text_list = split(l:text, ':')
	if len(l:text_list) == 1
		let l:file_path = l:text_list[0]
		let l:file_line = -1
	elseif len(l:text_list) == 2
		let l:file_path = l:text_list[0]
		let l:file_line = l:text_list[1]
		let l:file_line = substitute(l:file_line, ' ', '', 'g')
	else
		echo "Invalid file name"
		return
	endif
	if l:file_line != -1 && matchstr(l:file_line, '^\d*$') == ""
		echo "Invalid file line"
		return
	endif
	let l:file_path_list = split(l:file_path, '/')
	let l:file_name = l:file_path_list[len(l:file_path_list) - 1]
	let l:cmd = g:find_binary . ' ' . g:find_opt .' ''*' . l:file_name . '*'' | grep ''' . l:file_path . ''' | sort'
	let l:find_result = systemlist(l:cmd)
	let l:qflist = []
	if len(l:find_result) == 0
		echo 'No match found for ' . l:file_path
		return
	endif
	for file in l:find_result
		if l:file_line == -1
			call add(l:qflist, {'filename':file})
		else
			call add(l:qflist, {'filename':file, 'lnum':l:file_line})
		endif
	endfor
	call setqflist(l:qflist)
	exe 'botright' 'copen'
	redraw!
endfunction

command! -nargs=* -complete=file Find call s:Find(<q-args>)

