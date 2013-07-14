"=============================================================================================
"	vim-multiple-cursors package - Common text wrapper object
"	Last Change: 2013 July 14
"	Maintainer: Name Surname <name@mail.org>
"	License: This file is placed in the public domain.
"	Version: 0.1.0
"
" 	Features available:
" 	- Retrieving comon text from common text buffer
" 	- Writing of common text inside working buffer
"=============================================================================================

" Init of current object
if exists('common_text_wrapper#commonTextWrapper["loaded"]')
	finish
endif

" cursorsWrapper class {{{

	"==================================================
	" To retrieve a NEW instance of this object call: cursors_wrapper#getObject()
	"
	" es. let s:my_fucking_obj = common_text_wrapper#getObject()
	" now if you try to do:
	"
	" echo s:my_fucking_obj.test_msg
	" >common_text_wrapper#commonTextWrapper: Fuck the world!
	"==================================================

	let common_text_wrapper#commonTextWrapper = {}

	" Extends oopHandler to give base methods to this class
	let s:oopHandlerClass = oop_framework#oop_base#getObject()
	let common_text_wrapper#commonTextWrapper = extend(common_text_wrapper#commonTextWrapper, s:oopHandlerClass, "keep")

	" Class fields {{{
		if exists("common_text_wrapper#commonTextWrapper")
			" settings base fields of this class, all fields of
			" this class are listed here

			" current class name
			let common_text_wrapper#commonTextWrapper["class_name"] = "common_text_wrapper#commonTextWrapper"

			" field to show if this object is already sourced
			let common_text_wrapper#commonTextWrapper["loaded"] = 1

			" specific fields for current object
			let common_text_wrapper#commonTextWrapper["base_window_buffer_id"] = ""
			let common_text_wrapper#commonTextWrapper["coords_window_buffer_id"] = ""
			let common_text_wrapper#commonTextWrapper["common_text_window_buffer_id"] = ""
			let common_text_wrapper#commonTextWrapper["ordered_coords_dictionary"] = ""
		endif
	" }}}

	" Class properties (getter/setter) {{{

	" }}}

	" Class methods {{{
		" Function to retrieve a new instance of current object {{{
		function! common_text_wrapper#getObject()
			return copy(g:common_text_wrapper#commonTextWrapper)
		endfunction
		" }}}

		" Function to retrieve common text from common text window {{{
		function common_text_wrapper#commonTextWrapper.getCommonText() dict

			" moving to common text window
			exe bufwinnr(self.common_text_window_buffer_id) . "wincmd w"

			" retrieving common text (only the first line)
			if !exists("l:common_text")
				let l:common_text = ""
			endif
			let l:common_text = getline(1)

			" moving to base window
			exe bufwinnr(self.base_window_buffer_id) . "wincmd w"

			return l:common_text
		endfunction
		" }}}

		" Function to write common text in all of saved coords {{{
		function common_text_wrapper#commonTextWrapper.writeCommonText() dict

			" retrieving common text
			if !exists("l:common_text")
				let l:common_text = ""
			endif
			let l:common_text = self.getCommonText()

			" for a corret writing the coords must be reordered, from biggest to smaller,
			" in this way the coords number continue to be consistent
			let l:coords_dictionary_ordered = self.ordered_coords_dictionary

			" loopping inside all cursor coords and write common text in every coord
			for rows in l:coords_dictionary_ordered['row_list']
				for cols in l:coords_dictionary_ordered[rows]
					call self.writeStrOnCoordinates(l:common_text, rows . ',' . cols)
					" echo \"col: \" . cols . \" | row: " . rows
					" echo \"common text: " .  l:common_text
					" echo coord
				endfor
			endfor
		endfunction
		" }}}

		" Function to write the string 'stringToWrite' starting from the coordinates 'coordinates' {{{
		function common_text_wrapper#commonTextWrapper.writeStrOnCoordinates(stringToWrite, coordinates) dict

			" split coordinates string 'row,col', inside a list
			if !exists("l:single_coordinates_list")
				let l:single_coordinates_list = []
			endif
			let l:single_coordinates_list = split(a:coordinates, ',')

			" switching to base window
			exe bufwinnr(self.base_window_buffer_id) . "wincmd w"

			"echo \"Writing of " . a:stringToWrite
			"echo l:single_coordinates_list[0]
			"echo l:single_coordinates_list[1]
			"echo \"-----------------"

			" moving cursor to column and row retrieved
			call setpos(".", [0, l:single_coordinates_list[0], l:single_coordinates_list[1], 0])

			" writing string 'stringToWrite' starting from column and row retrieved
			exe "normal! i" . a:stringToWrite . "\<Esc>" 

		endfunction
		" }}}
	" }}} Class methods end
" }}} cursorsWrapper class end
