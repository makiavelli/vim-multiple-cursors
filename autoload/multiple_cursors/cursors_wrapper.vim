"=============================================================================================
"	vim-multiple-cursors package - Cursors position wrapper prototype
"	Last Change: 2013 July 17
"	Maintainer: makiavelli <https://github.com/makiavelli/vim-multiple-cursors>
"	License: This file is placed in the public domain.
"	Version: 0.1.0
"
" 	Prototype's features available:
" 	- Function to retrieve current cursor position (col and row)
" 	- Function to save cursor position inside a specific buffer
" 	- Function to cast all coords saved inside a dictionary
" 	- Function to reorder a coords dictionary
"=============================================================================================

" Avoids further load
if exists('cursorsWrapperLoaded')
	finish
endif

" cursorsWrapper prototype {{{

	"==================================================
	" To retrieve a NEW instance of this prototype call: multiple_cursors#cursors_wrapper#cursorsWrapper.New()
	"
	" es. let s:my_fucking_obj = multiple_cursors#cursors_wrapper#cursorsWrapper.New()
	" now if you try to do:
	"
	" echo s:my_fucking_obj.test_msg
	" >multiple_cursors#cursors_wrapper#cursorsWrapper: Fuck the world!
	"==================================================

	let multiple_cursors#cursors_wrapper#cursorsWrapper = {}

	" Prototype properties (getter/setter) {{{
	" }}}

	" Prototype methods {{{
		" Function to retrieve a new instance of current prototype {{{
		function multiple_cursors#cursors_wrapper#cursorsWrapper.New()

			" Extends oopHandler to give base methods to this prototype
			let l:cursWrapp = extend(copy(self), g:oop_framework#oop_base#oopHandler.New(), "keep")

			" ### OVERRIDING PROPERTIES AND METHODS FROM oopHandler HERE ###

			" Prototype fields {{{

				" current prototype name
				let l:cursWrapp["class_name"] = "multiple_cursors#cursors_wrapper#cursorsWrapper"

				" field to show if this prototype was already sourced
				let l:cursWrapp["loaded"] = 1

				" specific fields for current prototype
				let l:cursWrapp["base_window_buffer_id"] = ""
				let l:cursWrapp["coords_window_buffer_id"] = ""
				let l:cursWrapp["common_text_window_buffer_id"] = ""
			" }}} Prototype fields end

			return l:cursWrapp
		endfunction
		" }}}

		" Function to retrieve current cursor coords {{{
		function multiple_cursors#cursors_wrapper#cursorsWrapper.getCursorXY()

			" retrieve current cursor position
			" let l:current_cursor_position = [0,0,0,0] 
			" getpos(\".") " -> [bufnum, lnum, col, off]
			let l:current_cursor_position = getpos(".")

			" let l:test = getpos("'<") " -> [bufnum, lnum, col, off]
			" let l:test1 = getpos("'>") " -> [bufnum, lnum, col, off]
			" call self.logMsg("line number -> " . string(l:test))
			" call self.logMsg("line number1 -> " . string(l:test1))

			" convert coords list into string like this, 'line,column'
			let l:coords_string = l:current_cursor_position[1] . "," . l:current_cursor_position[2]

			return l:coords_string
		endfunction
		" }}}

		" TODO: Function to retrieve current cursor coords {{{
		function multiple_cursors#cursors_wrapper#cursorsWrapper.getCursorXYVmap()

			" retrieve current cursor position
			" let l:current_cursor_position = [0,0,0,0] 
			" getpos(\".") " -> [bufnum, lnum, col, off]
			" let l:current_cursor_position = getpos(".")

				call self.logMsg("mode: " . mode("1"))
			" identify visual mode
			if (mode() == "\<C-v>")
				call self.logMsg("char selection")
			elseif (mode() == "\<C-V>")
				call self.logMsg("line selection")
			elseif (mode() == "\<C-CTRL-V>")
				call self.logMsg("block selection")
			endif

			let l:point_a = getpos("'<") " -> [bufnum, lnum, col, off]
			let l:point_b = getpos("'>") " -> [bufnum, lnum, col, off]

			let l:point_a_details = {"bufnum" : l:point_a[0], "lnum" : l:point_a[1], "col" : l:point_a[2], "off" : l:point_a[3]}
			let l:point_b_details = {"bufnum" : l:point_b[0], "lnum" : l:point_b[1], "col" : l:point_b[2], "off" : l:point_b[3]}

			" Identify selection type
			" if (l:point_a = l:point_b)
			" 	- single point selection
			" else if (l:point_a[lnum] = l:point_b[lnum] && l:point_a[col] != l:point_b[col])
			" 	- vertical selection
			" else if (l:point_a[lnum] != l:point_b[lnum])
			" 	- horizzontal selection

			if (l:point_a_details == l:point_b_details)
				"- single point selection
				"call self.logMsg("single point selection")
			elseif (l:point_a_details["col"] == l:point_b_details["col"] && l:point_a_details["lnum"] != l:point_b_details["lnum"] )
				"- vertical selection
				"call self.logMsg("vertical selection")
			elseif (l:point_a_details["lnum"] != l:point_b_details["lnum"])
				"- horizzontal selection
				"call self.logMsg("horizzontal selection")
			endif

			call self.logMsg("point a (x,y) -> (" . string(l:point_a_details["col"]) . "," . string(l:point_a_details["lnum"]) . ")")
			call self.logMsg("point b (x,y) -> (" . string(l:point_b_details["col"]) . "," . string(l:point_b_details["lnum"]) . ")")

			return 1
		endfunction
		" }}}

		" Function to retrieve all saved cursor coords
		" - switch to previously coords window buffer
		" - read all line with :getline(1, '$')
		" - switch to previously window
		" - return list of all lines
		" {{{
		function multiple_cursors#cursors_wrapper#cursorsWrapper.getSavedCoords()

			" switching to coords list window
			exe bufwinnr(self.coords_window_buffer_id) . "wincmd w"

			" clear var to saving the cursor coords
			if !exists("l:cursor_coords")
				let l:cursor_coords = []
			endif
			let l:cursor_coords = getline(1, "$")

			" switching to previously window
			exe bufwinnr(self.base_window_buffer_id) . "wincmd w"

			return l:cursor_coords
		endfunction
		" }}}

		" Functions to cast list of coords inside dictionary,
		" further order values of this new dictionary crated {{{
		function multiple_cursors#cursors_wrapper#cursorsWrapper.castCoordsListIntoDictionary()

			" NOTE: Casting a list of coords into dictionary, like this:
			"
			" ------------------- FROM ---------------------
			" ['137,1', '123,12', '137,5', '112,9', '137,8']
			"
			" ------------------- TO -----------------------
			" { 'row_list' : [137, 123, 112], '137' : [12, 8, 1], '123' : [12], '112' : [9] }
			"
			" in shortly, all rows are grouped and become the keys of a dictionary, every row contain a list of cols.
			" The first dictionary's key (row_list) contains a list of all row retrieved. 
			" Next, all lists inside the dictionary (both rows list than col list) will be ordered from bigger to lower
			" to ensures the consistency of the saved coords 

			" retrieving all saved coords
			if !exists("l:coords_list")
				let l:coords_list = []
			endif
			let l:cursor_coords = self.getSavedCoords()

			" init of dictionary
			if !exists("l:coords_dictionary")
				let l:coords_dictionary = {}
			endif

			" init of 'row_list' key
			if !exists("l:coords_dictionary['row_list']")
				let l:coords_dictionary['row_list'] = []
			endif

			" casting list into dictionary, as described above
			for coord in l:cursor_coords
				if coord
					"[0] row, [1] col
					let l:single_coordinate_list = split(coord, ',')

					if !exists("l:coords_dictionary[l:single_coordinate_list[0]]")
						let l:coords_dictionary[l:single_coordinate_list[0]] = []
					endif

					" filling of first key 'row_list' with current row,
					" but if only NOT already exists
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

		" Function to compare two elements inside a list
		" http://vimdoc.sourceforge.net/htmldoc/eval.html - *sort()* *E702* {{{
		function multiple_cursors#cursors_wrapper#CompareListItems(i1, i2)

			" this ensures that will be compared two numbers
			let l:num1 = str2nr(a:i1)
			let l:num2 = str2nr(a:i2)

			return l:num1 == l:num2 ? 0 : l:num1 < l:num2 ? 1 : -1
		endfunction
		" }}}

		" Function to order all coords dictionary lists in descending order, this ensures
		" the consistency of the saved coords {{{
		function multiple_cursors#cursors_wrapper#cursorsWrapper.orderListsInsideCoordsDictionary(coordsDictionary)

			call self.logMsg("Ordering all lists inside dictionary: " . string(a:coordsDictionary))

			" ordering rows list
			let a:coordsDictionary['row_list'] = sort(a:coordsDictionary['row_list'], "multiple_cursors#cursors_wrapper#CompareListItems")

			" ordering all lists inside dictionary
			for coord in a:coordsDictionary['row_list']
				if coord
					let a:coordsDictionary[coord] = sort(a:coordsDictionary[coord], "multiple_cursors#cursors_wrapper#CompareListItems")
				endif
			endfor

			call self.logMsg("Lists inside dictionary successfully ordere: " . string(a:coordsDictionary))

			return a:coordsDictionary
		endfunction
		" }}}

		" Function to cast coords list into dictionary and orders keys and value {{{
		function multiple_cursors#cursors_wrapper#cursorsWrapper.castAndOrderCoordsList()

			if !exists("l:coords_dictionary_ordered")
				let l:coords_dictionary_ordered = {}
			endif
			let l:coords_dictionary_ordered = self.orderListsInsideCoordsDictionary(self.castCoordsListIntoDictionary())

			return l:coords_dictionary_ordered
		endfunction
		" }}}

		" Function to write (or append) the cursor coords (X and Y) inside coords buffer {{{
		function multiple_cursors#cursors_wrapper#cursorsWrapper.saveCursorXY()

			if !exists("l:coords_xy")
				let l:coords_xy = ""
			endif
			let l:coords_xy = self.getCursorXY()
			call self.logMsg("string retrived: ". string(l:coords_xy))

			"if current buffer is equal to base window buffer id, then the cursor coords could be saved
			if winbufnr(0) == self.base_window_buffer_id

				" switching to coords list window and append to coords list the new coords retrieved 
				exe bufwinnr(self.coords_window_buffer_id) . "wincmd w"
				call append(0, l:coords_xy)

				" return to base window
				exe bufwinnr(self.base_window_buffer_id) . "wincmd w"
			endif

		endfunction
		" }}}
	" }}} Prototype methods end
" }}} cursorsWrapper prototype end

let cursorsWrapperLoaded = 1
