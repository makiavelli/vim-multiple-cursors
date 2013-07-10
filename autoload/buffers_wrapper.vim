"=============================================================================================
"	vim-multiple-cursors package - Buffers and windows wrapper object
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

" Init of current object
if exists('buffers_wrapper#buffersWrapper["loaded"]')
	echo "del all fun"
	delfun buffers_wrapper#buffersWrapper.setBaseWindowBufferId
	delfun buffers_wrapper#buffersWrapper.getBaseWindowBufferId
	delfun buffers_wrapper#buffersWrapper.setCoordsWindowBufferId
	delfun buffers_wrapper#buffersWrapper.getCoordsWindowBufferId
	delfun buffers_wrapper#buffersWrapper.setCommonTextWindowBufferId
	delfun buffers_wrapper#buffersWrapper.getCommonTextWindowBufferId
endif

let buffers_wrapper#buffersWrapper = {}

function buffers_wrapper#buffersWrapper.setBaseWindowBufferId() dict
	" Function to set current working window buffer id into global var

	if !exists("g:base_window_buffer_id")
		let g:base_window_buffer_id = 0
	endif
	let g:base_window_buffer_id = winbufnr(0)
endfunction

function buffers_wrapper#buffersWrapper.getBaseWindowBufferId() dict
	" Function to retrieve the working window buffer id

	return g:base_window_buffer_id
endfunction

" Coords window functions
function buffers_wrapper#buffersWrapper.setCoordsWindowBufferId() dict
	" Function to set coords window buffer id into global var

	if !exists("g:coords_list_bufnr")
		let g:coords_list_bufnr = 0
	endif
	let g:coords_list_bufnr = winbufnr(0)
	
	echo "setCoordsWindowBufferId: "
	echo g:coords_list_bufnr
endfunction

function buffers_wrapper#buffersWrapper.getCoordsWindowBufferId() dict
	" Function to get coords window buffer id

	return g:coords_list_bufnr
endfunction

" Common text window functions
function buffers_wrapper#buffersWrapper.setCommonTextWindowBufferId() dict
	" Function to set common window buffer id into global var

	if !exists("g:common_text_bufnr")
		let g:common_text_bufnr = 0
	endif
	let g:common_text_bufnr = winbufnr(0)
endfunction

function buffers_wrapper#buffersWrapper.getCommonTextWindowBufferId() dict
	" Function to get common text window buffer id

	return g:common_text_bufnr
endfunction

function! buffers_wrapper#GetObject()
	return copy(s:buffersWrapper)
endfunction

function! buffers_wrapper#IsLoaded()
	" Function to check if this object is loaded with success
	return s:buffersWrapper["loaded"]
endfunction

if exists("buffers_wrapper#buffersWrapper")
	" successfully init of current object
	let buffers_wrapper#buffersWrapper["loaded"] = 1
	let buffers_wrapper#buffersWrapper["obj_msg"] = "No messages defined..."
	let buffers_wrapper#buffersWrapper["status"] = 1
	let buffers_wrapper#buffersWrapper["error"] = 0
	let buffers_wrapper#buffersWrapper["handler_error"] = ""
endif

