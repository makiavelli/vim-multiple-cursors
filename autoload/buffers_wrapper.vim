"=============================================================================================
"	vim-multiple-cursors package - Buffers and windows wrapper object
"	Last Change: 2013 July 16
"	Maintainer: makiavelli <name@mail.org>
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

if exists('buffersWrapperLoaded')
	finish
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

	" start the prototype
	let buffers_wrapper#buffersWrapper = {}

	" Class methods {{{

		" Function to retrieve a new instance of current class {{{
		function buffers_wrapper#buffersWrapper.New()

			" Extends oopHandler to give base methods to this class
			let l:buffWrapp = extend(copy(self), g:oop_framework#oop_base#oopHandler.New(), "keep")

			" ### OVERRIDING CLASSES AND METHODS OF oopHandler HERE ###
			" Class fields {{{
				" current class name
				let l:buffWrapp["class_name"] = "buffers_wrapper#buffersWrapper"

				" field to show if this object is already sourced
				let l:buffWrapp["loaded"] = 1

				" specific fields for current object
				let l:buffWrapp["base_window_buffer_id"] = ""
				let l:buffWrapp["coords_window_buffer_id"] = ""
				let l:buffWrapp["common_text_window_buffer_id"] = ""
			" }}} Class fields end

			return l:buffWrapp
		endfunction
		" }}}
	" }}} Class methods end
	" Class properties (getter/setter) {{{

		"==================================================
		" Current working window functions
		"==================================================

		" Function to get/set current working window buffer id into current object {{{
		function buffers_wrapper#buffersWrapper.baseWindowBufferId(...)

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
		function buffers_wrapper#buffersWrapper.coordsWindowBufferId(...)

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
		function buffers_wrapper#buffersWrapper.commonTextWindowBufferId(...)

			if a:0 == 1
				" TODO: check, must be a number
				let self.common_text_window_buffer_id = a:1
			endif

			return self.common_text_window_buffer_id
		endfunction 
		" }}}
	" }}}
" }}} buffersWrapper class end

let buffersWrapperLoaded = 1
