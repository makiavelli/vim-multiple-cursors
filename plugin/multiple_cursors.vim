"=============================================================================================
"	vim-multiple-cursors package - Main file
"	Last Change: 2013 July 8
"	Maintainer: Name Surname <name@mail.org>
"	License: This file is placed in the public domain.
"	Version: 0.1.0
"
"	If you want to write the same text in different points inside a file,
"	this plugin help you to do the trick.
"
"						*multiplecursor-settings*
"	to power off the auto key mapping:
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
"		TODO: define here the internal mapping
		nnoremap <leader>d :call <sid>MultipleCursors()<CR>
	endif

"	Commands:
"		Init 'vim-multiple-cursors' plugin:
"		:MultipleCursors()
"


"===========================================
"
" vim-multiple-cursors plugin main functions
"
"===========================================

if exists("MC_loaded")
	delfun MultipleCursors
	delfun ClearMultipleCursors
	delfun InitMultipleCursorPlugin
endif

function MultipleCursors()
	" - Function to create coords window and common text window

	" creating coords window and saving buffer number associated with new window created
	exe ":8new"
	call SetCoordsWindowBufferId()

	" creating common text window and save buffer number associated with new window created
	exe ":100vne"
	call SetCommonTextWindowBufferId()

	" move cursor to base window
	exe bufwinnr(GetBaseWindowBufferId()) . "wincmd w"
endfunction

function ClearMultipleCursors()
	" TODO: Function to clear coords window/buffer and common text window/buffer
endfunction

function InitMultipleCursorPlugin()
	" Function to init the MultipleCursorPlugin

	call SetBaseWindowBufferId()
	call MultipleCursors()
endfunction

let MC_loaded = 1
