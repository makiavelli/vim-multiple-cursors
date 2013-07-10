"=============================================================================================
"	vim-multiple-cursors package - Common text wrapper object
"	Last Change: 2013 July 8
"	Maintainer: Name Surname <name@mail.org>
"	License: This file is placed in the public domain.
"	Version: 0.1.0
"
" 	Features available:
" 	- Retrieving comon text from common text buffer
" 	- Writing of common text inside working buffer
"=============================================================================================

" Init of current object
if exists('commonTextWrapper["loaded"]')
	delfun commonTextWrapper.getCommonText
	delfun commonTextWrapper.writeCommonText
	delfun commonTextWrapper.writeStrOnCoordinates
endif

let commonTextWrapper = {}

function commonTextWrapper.getCommonText() dict
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

function commonTextWrapper.writeCommonText() dict
	" Function to write common text in all of saved coords

	" retrieving common text
	if !exists("l:common_text")
		let l:common_text = ""
	endif
	let l:common_text = GetCommonText()

	" for a corret writing the coords must be reordered, from biggest to smaller,
	" in this way the coords number continue to be consistent
	let l:coords_dictionary_ordered = CastAndOrderCoordsList()

	" loopping inside all cursor coords and write common text in every coord
	for rows in l:coords_dictionary_ordered['row_list']
		for cols in l:coords_dictionary_ordered[rows]
			call WriteStrOnCoordinates(l:common_text, rows . ',' . cols)
			" echo \"col: \" . cols . \" | row: " . rows
			" echo \"common text: " .  l:common_text
			" echo coord
		endfor
	endfor
endfunction

function commonTextWrapper.writeStrOnCoordinates(stringToWrite, coordinates) dict
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
	exe "normal! i" . a:stringToWrite . "\<Esc>" 

endfunction

if exists("commonTextWrapper")
	" successfully init of current object
	let commonTextWrapper["loaded"] = 1
endif
