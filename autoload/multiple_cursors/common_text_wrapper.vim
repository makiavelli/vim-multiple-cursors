"=============================================================================================
"	vim-multiple-cursors package - Common text wrapper prototype
"	Last Change: 2013 July 17
"	Maintainer: makiavelli <https://github.com/makiavelli/vim-multiple-cursors>
"	License: This file is placed in the public domain.
"	Version: 0.1.0
"
" 	Prototype's features available:
" 	- Function to retrieve common text from a common text buffer
" 	- Function to write common text inside a working buffer
"=============================================================================================

" Avoids further load
if exists('commonTextWrapperLoaded')
	finish
endif

" cursorsWrapper prototype {{{

	"==================================================
	" To retrieve a NEW instance of this prototype call: multiple_cursors#common_text_wrapper#commonTextWrapper.New()
	"
	" es. let s:my_fucking_obj = multiple_cursors#common_text_wrapper#commonTextWrapper.New()
	" now if you try to do:
	"
	" echo s:my_fucking_obj.test_msg
	" >multiple_cursors#common_text_wrapper#commonTextWrapper: Fuck the world!
	"==================================================

	let multiple_cursors#common_text_wrapper#commonTextWrapper = {}

	" Prototype properties (getter/setter) {{{
	" }}}

	" Prototype methods {{{
		" Function to retrieve a new instance of current prototype {{{
		function multiple_cursors#common_text_wrapper#commonTextWrapper.New()

			" Extends oopHandler to give base methods to this prototype
			let l:commTextWrapp = extend(copy(self), g:oop_framework#oop_base#oopHandler.New(), "keep")

			" ### OVERRIDING PROPERTIES AND METHODS FROM oopHandler HERE ###

			" Prototype fields {{{

				" current prototype name
				let l:commTextWrapp["class_name"] = "multiple_cursors#common_text_wrapper#commonTextWrapper"

				" field to show if this prototype was already sourced
				let l:commTextWrapp["loaded"] = 1

				" specific fields for current prototype
				let l:commTextWrapp["base_window_buffer_id"] = ""
				let l:commTextWrapp["coords_window_buffer_id"] = ""
				let l:commTextWrapp["common_text_window_buffer_id"] = ""
				let l:commTextWrapp["ordered_coords_dictionary"] = {}
			" }}} Prototype fields end

			return l:commTextWrapp
		endfunction
		" }}}

		" Function to retrieve common text from common text window {{{
		function multiple_cursors#common_text_wrapper#commonTextWrapper.getCommonText()

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

		" Function to write common text in all saved coords {{{
		function multiple_cursors#common_text_wrapper#commonTextWrapper.writeCommonText()

			" retrieving common text
			if !exists("l:common_text")
				let l:common_text = ""
			endif
			let l:common_text = self.getCommonText()

			" the coords lists must be reordered, from biggest to smaller,
			" in this way the coords number continue to be consistent
			let l:coords_dictionary_ordered = self.ordered_coords_dictionary

			" loopping inside all cursor coords and write common text in every coord
			for rows in l:coords_dictionary_ordered['row_list']
				for cols in l:coords_dictionary_ordered[rows]
					call self.writeStrOnCoordinates(l:common_text, rows . ',' . cols)
				endfor
			endfor
		endfunction
		" }}}

		" Function to write the string 'stringToWrite' starting from the coordinates 'coordinates' {{{
		function multiple_cursors#common_text_wrapper#commonTextWrapper.writeStrOnCoordinates(stringToWrite, coordinates)

			" split coordinates string 'row,col', into a list
			if !exists("l:single_coordinates_list")
				let l:single_coordinates_list = []
			endif
			let l:single_coordinates_list = split(a:coordinates, ',')

			" switching to base window
			exe bufwinnr(self.base_window_buffer_id) . "wincmd w"

			" moving cursor to column and row retrieved
			call setpos(".", [0, l:single_coordinates_list[0], l:single_coordinates_list[1], 0])

			" writing string 'stringToWrite' starting from column and row retrieved
			exe "normal! i" . a:stringToWrite . "\<Esc>" 

		endfunction
		" }}}
	" }}} Prototype methods end
" }}} cursorsWrapper prototype end

let commonTextWrapperLoaded = 1
