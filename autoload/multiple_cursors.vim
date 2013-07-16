"=============================================================================================
"	vim-multiple-cursors package - Main file
"	Last Change: 2013 July 16
"	Maintainer: makiavelli <name@mail.org>
"	License: This file is placed in the public domain.
"	Version: 0.1.0
"
"	If you want to write the same text in different points inside a file,
"	this plugin help you to do the trick.
"
" 	Features available:
"	- function to create user interface
"	- function to save cursor coords
"	- function to write common text
"	- TODO: function to clear all saved coords
"	- TODO: function to power off the vim-multiple-cursors plugin
"=============================================================================================

" Avoids further load
if exists('vimMultipleCursorsLoaded')
	finish
endif

"===========================================
"
" vim-multiple-cursors plugin main functions
"
"===========================================

	" Init of buffers_wrapper class
	if exists("s:buff_obj")
		let s:buff_obj = {}
	endif

	if exists("s:cursors_obj")
		let s:cursors_obj = {}
	endif

	if exists("s:text_obj")
		let s:text_obj = {}
	endif

	let s:buff_obj = buffers_wrapper#buffersWrapper.New()
	let s:cursors_obj = cursors_wrapper#cursorsWrapper.New()
	let s:text_obj = common_text_wrapper#commonTextWrapper.New()

	" Function to create base user interface to play with this plugin, will be created two windows.
	" First window to save the cursor coords, second window to insert the text to write {{{
	function! multiple_cursors#InitPlugin()
		" Saving base window buffer id
		call s:buff_obj.logMsg("Saving base window buffer id")
		call s:buff_obj.baseWindowBufferId(winbufnr(0))

		" creating coords window and saving buffer number associated with new window created
		8new
		call s:buff_obj.logMsg("Saving coords window buffer id")
		call s:buff_obj.coordsWindowBufferId(winbufnr(0))

		" creating common text window and save buffer number associated with new window created
		100vne
		call s:buff_obj.logMsg("Saving common text window buffer id")
		call s:buff_obj.commonTextWindowBufferId(winbufnr(0))

		" Move cursor to base window
		exe bufwinnr(s:buff_obj.baseWindowBufferId()) . "wincmd w"

		" saving buffers id inside cursors_wrapper class
		let s:cursors_obj.base_window_buffer_id = s:buff_obj.base_window_buffer_id
		let s:cursors_obj.coords_window_buffer_id = s:buff_obj.coords_window_buffer_id
		let s:cursors_obj.common_text_window_buffer_id = s:buff_obj.common_text_window_buffer_id

		" saving buffers id inside common_text_wrapper class
		let s:text_obj.base_window_buffer_id = s:buff_obj.base_window_buffer_id
		let s:text_obj.coords_window_buffer_id = s:buff_obj.coords_window_buffer_id
		let s:text_obj.common_text_window_buffer_id = s:buff_obj.common_text_window_buffer_id
	endfunction
	" }}}

	" Function to saving the current coords of the cursor {{{
	function! multiple_cursors#SaveCoords()
		call s:cursors_obj.saveCursorXY()
	endfunction
	" }}}

	" Function to write common text inside working buffer {{{
	function! multiple_cursors#WriteText()
		" retrieving coords list dictionary ordered
		let s:text_obj.ordered_coords_dictionary = s:cursors_obj.castAndOrderCoordsList()
		" write text inside every coors 
		call s:text_obj.writeCommonText()
	endfunction
	" }}}

"===============================================
"
" vim-multiple-cursors plugin main functions end
"
"===============================================

let vimMultipleCursorsLoaded = 1
