"=============================================================================================
"	vim-multiple-cursors package - Mapping
"	Last Change: 2013 July 14
"	Maintainer: makiavelli <name@mail.org>
"	License: This file is placed in the public domain.
"	Version: 0.1.0
"
"	If you want to write the same text in different points inside a file,
"	this plugin help you to do the trick.
"
"						*multiplecursor-settings*
"	to skip the auto key mapping:
"		let g:multiple_cursors_map_keys = 0
"
"=============================================================================================


"===========================================
"
" vim-multiple-cursors plugin mapping
"
"===========================================


	" Mappings:
	if !exists('g:multiple_cursors_map_keys')
		let g:multiple_cursors_map_keys = 1
	endif

	if g:multiple_cursors_map_keys
		" internal mapping
		nnoremap <C-F3> :call multiple_cursors#multiple_cursors#InitPlugin()<CR>
		nnoremap <C-F4> :call multiple_cursors#multiple_cursors#SaveCoords()<CR>
		nnoremap <C-F5> :call multiple_cursors#multiple_cursors#WriteText()<CR>
	endif

	" Commands:
	" 	Init 'vim-multiple-cursors' plugin:
	" 	:call multiple_cursors#multiple_cursors#InitPlugin()
