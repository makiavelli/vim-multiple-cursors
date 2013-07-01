"MultipleCursor plugin - Main file

"Function list
"	MultipleCursors() -> function to start the multiple cursors plugin
"	MultipleCursorsOff() -> function to power-off the multiple cursors plugin
"	GetCursorXY() -> function to get current coords of cursor
"	SaveCursorXY() -> function to save the current cursor position into coords window

"Global vars
	" base window buffer id

" Current working window functions
	function! SetBaseWindowBufferId()
		" Function to set current working window buffer id into global var

		if !exists("g:base_window_buffer_id")
			let g:base_window_buffer_id = 0
		endif
		let g:base_window_buffer_id = winbufnr(0)
	endfunction

	function! GetBaseWindowBufferId()
		" Function to retrieve the working window buffer id

		return g:base_window_buffer_id
	endfunction

" Coords window functions
	function! SetCoordsWindowBufferId()
		" Function to set coords window buffer id into global var

		if !exists("g:coords_list_bufnr")
			let g:coords_list_bufnr = 0
		endif
		let g:coords_list_bufnr = winbufnr(0)
	endfunction

	function! GetCoordsWindowBufferId()
		" Function to get coords window buffer id

		return g:coords_list_bufnr
	endfunction

" Common text window functions
	function! SetCommonTextWindowBufferId()
		" Function to set common window buffer id into global var

		if !exists("g:common_text_bufnr")
			let g:common_text_bufnr = 0
		endif
		let g:common_text_bufnr = winbufnr(0)
	endfunction

	function! GetCommonTextWindowBufferId()
		" Function to get common text window buffer id

		return g:common_text_bufnr
	endfunction

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

function! GetCursorXY()
	" Function to get the current coord of cursor

	" [bufnum, lnum, col, off]
	" retrieve current cursor position in base window
	let l:current_cursor_position = getpos(".")

	" convert list of position retrieved in a string like this, "line,column
	let l:coords_string = l:current_cursor_position[1] . "," . l:current_cursor_position[2]

	return l:coords_string
endfunction
"call GetCursorXY()

function! GetSavedCoords()
	" Function to retrieve the buffer from the coords window

	" - switching to previously coords window buffer (GetCoordsWindowBufferId())
	" - read all line with getline(1, \"$\")
	" - switching to previously window
	" - return list of all lines
	" saving current windows number
	" let g:current_window_number = winnr()

	" switching to coord list window
	exe bufwinnr(GetCoordsWindowBufferId()) . "wincmd w"

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
	exe bufwinnr(GetBaseWindowBufferId()) . "wincmd w"

	return l:cursor_coords
endfunction

	" Functions to cast list of coords inside dictionary and order key and value of the new dictionary
function! CastCoordsListIntoDictionary()
	" Function to cast list of coords inside dictionary

	" retrieving all saved coords
	if !exists("l:coords_list")
		let l:coords_list = []
	endif
	let l:cursor_coords = GetSavedCoords()

	" casting list of coords into dictionary, like this:
	" ['137,1', '123,12', '137,5', '112,9', '137,8']
	"
	" ------------------- TO -----------------------
	"
	" { '137' : [12, 8, 1], '123' : [12], '112' : [9] }
	" in shortly, all rows become the keys of a dictionary, every row contain a list of cols.
	" both keys and list, respectively rows cols, are sorted in descending order,
	" this ensures the consistency of the coords saved

	if !exists("l:coords_dictionary")
		let l:coords_dictionary = {}
	endif

	" casting list to dictionary
	for coord in l:cursor_coords
		if coord
			"[0] row, [1] col
			let l:single_coordinate_list = split(coord, ',')

			" init the key with row and list of cols related to the row
			if !exists("l:coords_dictionary[l:single_coordinate_list[0]]")
				let l:coords_dictionary[l:single_coordinate_list[0]] = []
			endif

			" filling rows with every col found, this will produce a list of rows for every col
			" es. '173' : [1,32,7]
			let l:coords_dictionary[l:single_coordinate_list[0]] = add(l:coords_dictionary[l:single_coordinate_list[0]], l:single_coordinate_list[1])
		endif
	endfor

	return l:coords_dictionary
endfunction

function! OrderCoordsDictionary(coordsDictionary)
	" Function to order a coords dictionary to ensures the consistency of the coords saved

	" TODO: order coords dictionary
	echo a:coordsDictionary

	return a:coordsDictionary
endfunction

function! CastAndOrderCoordsList()
	" Function to cast coords list into dictionary and orders keys and value

	if !exists("l:coords_dictionary_ordered")
		let l:coords_dictionary_ordered = {}
	endif
	let l:coords_dictionary_ordered =  OrderCoordsDictionary(CastCoordsListIntoDictionary())

	return l:coords_dictionary_ordered
endfunction

function! SaveCursorXY()
	" Function to write (or append) the cursor X(col) and Y(row) inside coords buffer

	if !exists("l:coords_xy")
		let l:coords_xy = ""
	endif
	let l:coords_xy = GetCursorXY()
	echo "string retrived: ". l:coords_xy

	"if current buffer is equal to  base window buffer id, then cursor coords could be saved
	if winbufnr(0) == GetBaseWindowBufferId()
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
		exe bufwinnr(GetCoordsWindowBufferId()) . "wincmd w"
		call append(0, l:coords_xy)
		" call add(l:saved_coords_list, l:coords_xy)

		" return to base window
		exe bufwinnr(GetBaseWindowBufferId()) . "wincmd w"
	endif

	" echo \"current buff id: " . b:current_window_bufnr
	" echo \"cursor window buff id: " . GetCoordsWindowBufferId()

endfunction
"call SaveCursorXY()

function! GetCommonText()
	" Function to retrieve common text

	" moving to common text window
	exe bufwinnr(GetCommonTextWindowBufferId()) . "wincmd w"

	" retrieving common text (only the first line)
	if !exists("l:common_text")
		let l:common_text = ""
	endif
	let l:common_text = getline(1)

	" moving to base window
	exe bufwinnr(GetBaseWindowBufferId()) . "wincmd w"

	return l:common_text
endfunction

function! WriteCommonText()
	" Function to write common text in all of saved coords

	" TODO: for a corret writing the coords must be reordered, from biggest to smaller, in this way the coords
	" 	number continue to be consistent

	" retrieving common text
	if !exists("l:common_text")
		let l:common_text = ""
	endif
	let l:common_text = GetCommonText()

	" loopping inside all cursor coords and write common text in every coord
	for coord in GetSavedCoords()
		if coord
			call WriteStrOnCoordinates(l:common_text, coord)
			" echo \"common text: " .  l:common_text
			" echo coord
		endif
	endfor
endfunction

function! WriteStrOnCoordinates(stringToWrite, coordinates)
	" Function to write the string 'stringToWrite' starting from the coordinates 'coordinates'

	" split coordinates string 'row,col', inside a list
	if !exists("l:single_coordinates_list")
		let l:single_coordinates_list = []
	endif
	let l:single_coordinates_list = split(a:coordinates, ',')

	" switching to base window
	exe bufwinnr(GetBaseWindowBufferId()) . "wincmd w"

	"echo \"Writing of " . a:stringToWrite
	"echo l:single_coordinates_list[0]
	"echo l:single_coordinates_list[1]
	"echo \"-----------------"

	" moving cursor to column and row retrieved
	call setpos(".", [0, l:single_coordinates_list[0], l:single_coordinates_list[1], 0])


	" writing string 'stringToWrite' starting from column and row retrieved
	exe "normal i" . a:stringToWrite . "\<Esc>" 
	
endfunction

function! ClearMultipleCursors()
	" TODO: Function to clear coords window/buffer and common text window/buffer
endfunction

function! InitMultipleCursorPlugin()
	" Function to init the MultipleCursorPlugin

	call SetBaseWindowBufferId()
	call MultipleCursors()
endfunction
