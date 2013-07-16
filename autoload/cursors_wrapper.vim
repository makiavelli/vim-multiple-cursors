"=============================================================================================
"	vim-multiple-cursors package - Cursors position wrapper object
"	Last Change: 2013 July 16
"	Maintainer: makiavelli <name@mail.org>
"	License: This file is placed in the public domain.
"	Version: 0.1.0
"
" 	Features available:
" 	- Retrieving current position of cursor (col and row)
" 	- Saving position retrieved inside a specific buffer
" 	- Retrieving as dictionary all positions saved inside a buffer
" 	- Orders position retrieved inside dictionary
"=============================================================================================

if exists('cursorsWrapperLoaded')
	finish
endif

" cursorsWrapper class {{{

	"==================================================
	" To retrieve a NEW instance of this object call: cursors_wrapper#getObject()
	"
	" es. let s:my_fucking_obj = cursors_wrapper#getObject()
	" now if you try to do:
	"
	" echo s:my_fucking_obj.test_msg
	" >cursors_wrapper#cursorsWrapper: Fuck the world!
	"==================================================

	let cursors_wrapper#cursorsWrapper = {}

	" Class properties (getter/setter) {{{

	" }}}

	" Class methods {{{
		" Function to retrieve a new instance of current class {{{
		function cursors_wrapper#cursorsWrapper.New()

			" Extends oopHandler to give base methods to this class
			let l:cursWrapp = extend(copy(self), g:oop_framework#oop_base#oopHandler.New(), "keep")

			" ### OVERRIDING CLASSES AND METHODS OF oopHandler HERE ###
			" Class fields {{{
				" current class name
				let l:cursWrapp["class_name"] = "cursors_wrapper#cursorsWrapper"

				" field to show if this object is already sourced
				let l:cursWrapp["loaded"] = 1

				" specific fields for current object
				let l:cursWrapp["base_window_buffer_id"] = ""
				let l:cursWrapp["coords_window_buffer_id"] = ""
				let l:cursWrapp["common_text_window_buffer_id"] = ""
			" }}} Class fields end

			return l:cursWrapp
		endfunction
		" }}}

		" Function to get the current coord of cursor {{{
		function cursors_wrapper#cursorsWrapper.getCursorXY()

			" [bufnum, lnum, col, off]
			" retrieve current cursor position in base window
			let l:current_cursor_position = getpos(".")

			" convert list of position retrieved in a string like this, "line,column
			let l:coords_string = l:current_cursor_position[1] . "," . l:current_cursor_position[2]

			return l:coords_string
		endfunction
		" }}}

		" Function to retrieve the buffer from the coords window {{{
		function cursors_wrapper#cursorsWrapper.getSavedCoords()

			" - switching to previously coords window buffer (GetCoordsWindowBufferId())
			" - read all line with getline(1, \"$\")
			" - switching to previously window
			" - return list of all lines
			" saving current windows number
			" let g:current_window_number = winnr()

			" switching to coord list window
			exe bufwinnr(self.coords_window_buffer_id) . "wincmd w"

			" let l:coords_coords = getbufline(bufwinnr(GetCoordsWindowBufferId())), 1, "$")
			" l:coords_coords = getline(1, \"$")
			" retrieving all coords from buffer

			" clear var to saving the cursor coords
			if !exists("l:cursor_coords")
				let l:cursor_coords = []
			endif
			let l:cursor_coords = getline(1, "$")
			" echo \"buffer id of coords saved: " . GetCoordsWindowBufferId()
			" echo \"related window numer: " . bufwinnr(GetCoordsWindowBufferId())
			" echo \"coords: " . l:coords_coords

			" switching to previously window
			exe bufwinnr(self.base_window_buffer_id) . "wincmd w"

			return l:cursor_coords
		endfunction
		" }}}

		" Functions to cast list of coords inside dictionary 
		" and order keys and values of the new dictionary {{{
		function cursors_wrapper#cursorsWrapper.castCoordsListIntoDictionary()
			" Function to cast list of coords inside dictionary
			"
			" Casting a list of coords into dictionary, like this:
			"
			" ------------------- FROM ---------------------
			" ['137,1', '123,12', '137,5', '112,9', '137,8']
			"
			" ------------------- TO -----------------------
			" { 'row_list' : [137, 123, 112], '137' : [12, 8, 1], '123' : [12], '112' : [9] }
			"
			" in shortly, all rows are grouped and become the keys of a dictionary, every row contain a list of cols.
			" First key of the dictionary 'row_list', contain the list of all row retrieved. 
			" Next, all lists inside the dictionary (both rows list than col list) will be ordered from bigger to lower
			" this ensures the consistency of the coords saved

			" retrieving all saved coords
			if !exists("l:coords_list")
				let l:coords_list = []
			endif
			let l:cursor_coords = self.getSavedCoords()

			" init of dictionary
			if !exists("l:coords_dictionary")
				let l:coords_dictionary = {}
			endif

			" init the key 'row_list'
			if !exists("l:coords_dictionary['row_list']")
				let l:coords_dictionary['row_list'] = []
			endif

			" casting list to dictionary as described above
			for coord in l:cursor_coords
				if coord
					"[0] row, [1] col
					let l:single_coordinate_list = split(coord, ',')

					" init the key with row and list of cols related to the row
					if !exists("l:coords_dictionary[l:single_coordinate_list[0]]")
						let l:coords_dictionary[l:single_coordinate_list[0]] = []
					endif

					" filling first key 'row_list' with this row, but only if NOT already exists inside the list
					if !count(l:coords_dictionary['row_list'], l:single_coordinate_list[0])
						let l:coords_dictionary['row_list'] = add(l:coords_dictionary['row_list'], l:single_coordinate_list[0])
					endif

					" filling rows with every col found, this will produce a list of rows for every col
					" es. '173' : [1,32,7]
					let l:coords_dictionary[l:single_coordinate_list[0]] = add(l:coords_dictionary[l:single_coordinate_list[0]], l:single_coordinate_list[1])
				endif
			endfor

			return l:coords_dictionary
		endfunction
		" }}}

		" function to compare two elements inside a list
		" http://vimdoc.sourceforge.net/htmldoc/eval.html - *sort()* *E702* {{{
		function cursors_wrapper#CompareListItems(i1, i2)

			" this ensures that will be compared two numbers
			let l:num1 = str2nr(a:i1)
			let l:num2 = str2nr(a:i2)

			return l:num1 == l:num2 ? 0 : l:num1 < l:num2 ? 1 : -1
		endfunction
		" }}}

		" Function to order all lists inside of coords dictionary in descending order, this ensures
		" the consistency of the coords saved {{{
		function cursors_wrapper#cursorsWrapper.orderListsInsideCoordsDictionary(coordsDictionary)

			call self.logMsg("Ordering all lists inside dictionary: " . string(a:coordsDictionary))

			" ordering rows list
			let a:coordsDictionary['row_list'] = sort(a:coordsDictionary['row_list'], "cursors_wrapper#CompareListItems")

			" ordering all lists inside dictionary
			for coord in a:coordsDictionary['row_list']
				if coord
					let a:coordsDictionary[coord] = sort(a:coordsDictionary[coord], "cursors_wrapper#CompareListItems")
					" echo a:coordsDictionary[coord]
				endif
			endfor

			call self.logMsg("Lists inside dictionary successfully ordere: " . string(a:coordsDictionary))

			return a:coordsDictionary
		endfunction
		" }}}

		" Function to cast coords list into dictionary and orders keys and value {{{
		function cursors_wrapper#cursorsWrapper.castAndOrderCoordsList()

			if !exists("l:coords_dictionary_ordered")
				let l:coords_dictionary_ordered = {}
			endif
			let l:coords_dictionary_ordered = self.orderListsInsideCoordsDictionary(self.castCoordsListIntoDictionary())

			return l:coords_dictionary_ordered
		endfunction
		" }}}

		" Function to write (or append) the cursor X(col) and Y(row) inside coords buffer {{{
		function cursors_wrapper#cursorsWrapper.saveCursorXY()

			if !exists("l:coords_xy")
				let l:coords_xy = ""
			endif
			let l:coords_xy = self.getCursorXY()
			call self.logMsg("string retrived: ". string(l:coords_xy))

			"if current buffer is equal to base window buffer id, then cursor coords could be saved
			if winbufnr(0) == self.base_window_buffer_id
				" retrieving a list of saved coords
				" if !exists("l:saved_coords_list")
					" let l:saved_coords_list = []
				" endif
				" let l:saved_coords_list = GetSavedCoords()

				" echo \"coords retrieved"
				" echo l:saved_coords_list
				" echo \"cursor current coords"
				" echo l:coords_xy
				" switching to coords list window and append new coords retrieved to coords list
				exe bufwinnr(self.coords_window_buffer_id) . "wincmd w"
				call append(0, l:coords_xy)
				" call add(l:saved_coords_list, l:coords_xy)

				" return to base window
				exe bufwinnr(self.base_window_buffer_id) . "wincmd w"
			endif

			" echo \"current buff id: " . b:current_window_bufnr
			" echo \"cursor window buff id: " . GetCoordsWindowBufferId()
		endfunction
		" }}}
	" }}} Class methods end
" }}} cursorsWrapper class end

let cursorsWrapperLoaded = 1
