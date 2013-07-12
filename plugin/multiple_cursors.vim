"=============================================================================================
"	vim-multiple-cursors package - Main file (mapping only)
"	Last Change: 2013 July 12
"	Maintainer: Name Surname <name@mail.org>
"	License: This file is placed in the public domain.
"	Version: 0.1.0
"
"	If you want to write the same text in different points inside a file,
"	this plugin help you to do the trick.
"
"						*multiplecursor-settings*
"	to skipping the auto key mapping:
"		let g:multiple_cursors_map_keys = 0
"
"
" 	Features available:
"	- function to start the multiple cursors plugin
"	- function to power-off the multiple cursors plugin
"	- function to clear coords window/buffer and common text window/buffer
"=============================================================================================

"	Mappings:
	if !exists('g:multiple_cursors_map_keys')
		let g:multiple_cursors_map_keys = 1
	endif

	if g:multiple_cursors_map_keys
		" internal mapping
		nnoremap <C-F3> :call multiple_cursors#InitPlugin()<CR>
	endif

"	Commands:
"		Init 'vim-multiple-cursors' plugin:
"		:multipleCursors.init()
"

"===========================================
"
" vim-multiple-cursors plugin main functions
"
"===========================================

