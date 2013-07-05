"	Vim global plugin to enable multiple cursors
"	Last Change: 2013 July 15
"	Maintainer: Name Surname <name@mail.org>
"	License: This file is placed in the public domain.

"MultipleCursor plugin - Main file

"Function list
"	MultipleCursors() -> function to start the multiple cursors plugin
"	MultipleCursorsOff() -> function to power-off the multiple cursors plugin
"	GetCursorXY() -> function to get current coords of cursor
"	SaveCursorXY() -> function to save the current cursor position into coords window

"Global vars
	" base window buffer id

" Current working window functions
" function! FunctTest()
"  	echo \"ciao"
"	return 'Filter users'
"endfunction
"	unlet! Afunc
"let Afunc = function('FunctTest')
"let g:WindowsWrapper = { \"FunctTest" : g:FuncRef }
" TODO: source of BuffersWrapper.vim and CursorsWrapper.vim

"
"
" MultipleCursors plugin main functions
"
"

function! MultipleCursors()
	" - Function to create coords window and common text window

	" creating coords window and saving buffer number associated with new window created
	8new
	call SetCoordsWindowBufferId()

	" creating common text window and save buffer number associated with new window created
	100vne
	call SetCommonTextWindowBufferId()

	" move cursor to base window
	exe bufwinnr(GetBaseWindowBufferId()) . "wincmd w"
endfunction
" call MultipleCursors()



function! ClearMultipleCursors()
	" TODO: Function to clear coords window/buffer and common text window/buffer
endfunction

function! InitMultipleCursorPlugin()
	" Function to init the MultipleCursorPlugin

	call SetBaseWindowBufferId()
	call MultipleCursors()
endfunction
