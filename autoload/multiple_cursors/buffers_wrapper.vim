"=============================================================================================
"	vim-multiple-cursors package - Buffers and windows wrapper prototype
"	Last Change: 2013 July 17
"	Maintainer: makiavelli <name@mail.org>
"	License: This file is placed in the public domain.
"	Version: 0.1.0
"
" 	Prototype's features available:
" 	- Function to save/get working window buffer id
" 	- Function to save/get coords window buffer id
" 	- Function to save/get common text window  id
"=============================================================================================

" Avoids further load
if exists('buffersWrapperLoaded')
	finish
endif

" buffersWrapper prototype {{{

	"==================================================
	" To retrieve a NEW instance of this prototype call: multiple_cursors#buffers_wrapper#buffersWrapper.New()
	"
	" es. let s:my_fucking_obj = multiple_cursors#buffers_wrapper#buffersWrapper.New()
	" now if you try to do:
	"
	" echo s:my_fucking_obj.test_msg
	" >multiple_cursors#buffers_wrapper#buffersWrapper: Fuck the world!
	"==================================================

	" start the prototype
	let multiple_cursors#buffers_wrapper#buffersWrapper = {}

	" Prototype methods {{{

		" Function to retrieve a new instance of current prototype {{{
		function multiple_cursors#buffers_wrapper#buffersWrapper.New()

			" Extends oopHandler to give base methods to this prototype
			let l:buffWrapp = extend(copy(self), g:oop_framework#oop_base#oopHandler.New(), "keep")

			" ### OVERRIDING PROPERTIES AND METHODS FROM oopHandler HERE ###

			" Prototype fields {{{

				" current prototype name
				let l:buffWrapp["class_name"] = "multiple_cursors#buffers_wrapper#buffersWrapper"

				" field to show if this prototype was already sourced
				let l:buffWrapp["loaded"] = 1

				" specific fields for current prototype
				let l:buffWrapp["base_window_buffer_id"] = ""
				let l:buffWrapp["coords_window_buffer_id"] = ""
				let l:buffWrapp["common_text_window_buffer_id"] = ""
			" }}} Prototype fields end

			return l:buffWrapp
		endfunction
		" }}}
	" }}} Prototype methods end
	" Prototype properties (getter/setter) {{{

		"==================================================
		" Current working window functions
		"==================================================

		" Function to get/set current working window buffer id {{{
		function multiple_cursors#buffers_wrapper#buffersWrapper.baseWindowBufferId(...)

			if a:0 == 1
				" TODO: must be a number
				let self.base_window_buffer_id = a:1
			endif

			return self.base_window_buffer_id
		endfunction
		" }}}

		"==================================================
		" Coords window functions
		"==================================================

		" Function to get/set coords window buffer id {{{
		function multiple_cursors#buffers_wrapper#buffersWrapper.coordsWindowBufferId(...)

			if a:0 == 1
				" TODO: must be a number
				let self.coords_window_buffer_id = a:1
			endif

			return self.coords_window_buffer_id
		endfunction
		" }}}

		"==================================================
		" Common text window functions
		"==================================================

		" Function to get/set common window buffer id {{{
		function multiple_cursors#buffers_wrapper#buffersWrapper.commonTextWindowBufferId(...)

			if a:0 == 1
				" TODO: must be a number
				let self.common_text_window_buffer_id = a:1
			endif

			return self.common_text_window_buffer_id
		endfunction 
		" }}}
	" }}}
" }}} buffersWrapper prototype end

let buffersWrapperLoaded = 1
