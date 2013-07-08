"=============================================================================================
"	Vim MultipleCursors package - Buffers and windows wrapper object
"	Last Change: 2013 July 8
"	Maintainer: Name Surname <name@mail.org>
"	License: This file is placed in the public domain.
"	Version: 0.1.0
"
" 	Features available:
" 	- Saving working window buffer id
" 	- Retrieving working window buffer id
" 	- Saving coords window buffer id
" 	- Retrieving coords window buffer id
" 	- Saving common text window buffer id
" 	- Retrieving common text window buffer id
"=============================================================================================

if exists("BW_loaded")
	delfun buffersWrapper.setBaseWindowBufferId
	delfun buffersWrapper.getBaseWindowBufferId
	delfun buffersWrapper.setCoordsWindowBufferId
	delfun buffersWrapper.getCoordsWindowBufferId
	delfun buffersWrapper.setCommonTextWindowBufferId
	delfun buffersWrapper.getCommonTextWindowBufferId
endif

let buffersWrapper = {}

function buffersWrapper.setBaseWindowBufferId() dict
	" Function to set current working window buffer id into global var

	if !exists("g:base_window_buffer_id")
		let g:base_window_buffer_id = 0
	endif
	let g:base_window_buffer_id = winbufnr(0)
endfunction

function buffersWrapper.getBaseWindowBufferId() dict
	" Function to retrieve the working window buffer id

	return g:base_window_buffer_id
endfunction

" Coords window functions
function buffersWrapper.setCoordsWindowBufferId() dict
	" Function to set coords window buffer id into global var

	if !exists("g:coords_list_bufnr")
		let g:coords_list_bufnr = 0
	endif
	let g:coords_list_bufnr = winbufnr(0)
endfunction

function buffersWrapper.getCoordsWindowBufferId() dict
	" Function to get coords window buffer id

	return g:coords_list_bufnr
endfunction

" Common text window functions
function buffersWrapper.setCommonTextWindowBufferId() dict
	" Function to set common window buffer id into global var

	if !exists("g:common_text_bufnr")
		let g:common_text_bufnr = 0
	endif
	let g:common_text_bufnr = winbufnr(0)
endfunction

function buffersWrapper.getCommonTextWindowBufferId() dict
	" Function to get common text window buffer id

	return g:common_text_bufnr
endfunction

let BW_loaded = 1
