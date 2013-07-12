"=============================================================================================
"	vim-multiple-cursors package - Buffers and windows wrapper object
"	Last Change: 2013 July 12
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

" TODO: understand understand what to do here
if exists('buffers_wrapper#buffersWrapper["loaded"]')

	finish
	" all methods of this class are listed here
	"delfun buffers_wrapper#buffersWrapper.baseWindowBufferId
	"delfun buffers_wrapper#buffersWrapper.coordsWindowBufferId
	"delfun buffers_wrapper#buffersWrapper.commonTextWindowBufferId
endif

" buffersWrapper class {{{

	"==================================================
	" To retrieve a NEW instance of this object call: buffers_wrapper#getObject()
	"
	" es. let s:my_fucking_obj = buffers_wrapper#getObject()
	" now if you try to do:
	"
	" echo s:my_fucking_obj.test_msg
	" >buffers_wrapper: Fuck the world!
	"==================================================

	let buffers_wrapper#buffersWrapper = {}

	" Extends oopHandler to give base methods to this class
	let s:oopHandlerClass = oop_framework#oop_base#getObject()
	let buffers_wrapper#buffersWrapper = extend(buffers_wrapper#buffersWrapper, s:oopHandlerClass, "keep")

	" Class fields {{{
		if exists("buffers_wrapper#buffersWrapper")
			" settings base fields of this class, all fields of
			" this class are listed here

			" current class name
			let buffers_wrapper#buffersWrapper["class_name"] = "buffers_wrapper#buffersWrapper"

			" field to show if this object is already sourced
			let buffers_wrapper#buffersWrapper["loaded"] = 1

			" specific fields for current object
			let buffers_wrapper#buffersWrapper["base_window_buffer_id"] = ""
			let buffers_wrapper#buffersWrapper["coords_window_buffer_id"] = ""
			let buffers_wrapper#buffersWrapper["common_text_window_buffer_id"] = ""
		endif
	" }}}

	" Class properties (getter/setter) {{{

		"==================================================
		" Current working window functions
		"==================================================

		" Function to get/set current working window buffer id into current object {{{
		function buffers_wrapper#buffersWrapper.baseWindowBufferId(...) dict

			if a:0 == 1
				" TODO: check, must be a number
				let self.base_window_buffer_id = a:1
			endif

			return self.base_window_buffer_id
		endfunction
		" }}}

		"==================================================
		" Coords window functions
		"==================================================

		" Function to get/set coords window buffer id into current object {{{
		function buffers_wrapper#buffersWrapper.coordsWindowBufferId(...) dict

			if a:0 == 1
				" TODO: check, must be a number
				let self.coords_window_buffer_id = a:1
			endif

			return self.coords_window_buffer_id
		endfunction
		" }}}

		"==================================================
		" Common text window functions
		"==================================================

		" Function to get/set common window buffer id into current object {{{
		function buffers_wrapper#buffersWrapper.commonTextWindowBufferId(...) dict

			if a:0 == 1
				" TODO: check, must be a number
				let self.common_text_window_buffer_id = a:1
			endif

			return self.common_text_window_buffer_id
		endfunction 
		" }}}
	" }}}

	" Class methods {{{
		" Function to retrieve a new instance of current object {{{
		function! buffers_wrapper#getObject()
			return copy(g:buffers_wrapper#buffersWrapper)
		endfunction
		" }}}
	" }}} Class methods end
" }}} buffersWrapper class end
