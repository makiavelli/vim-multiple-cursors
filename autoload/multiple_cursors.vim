"=============================================================================================
"	vim-multiple-cursors package - Main file
"	Last Change: 2013 July 11
"	Maintainer: Name Surname <name@mail.org>
"	License: This file is placed in the public domain.
"	Version: 0.1.0
"
"	If you want to write the same text in different points inside a file,
"	this plugin help you to do the trick.
"
"						*multiplecursor-settings*
"	to skipping the auto key mapping:
"		let g:multiple_cursors_map_keys = 0
"
"
" 	Features available:
"	- function to start the multiple cursors plugin
"	- function to power-off the multiple cursors plugin
"	- function to clear coords window/buffer and common text window/buffer
"=============================================================================================

"	Mappings:
	if !exists('g:multiple_cursors_map_keys')
		let g:multiple_cursors_map_keys = 1
	endif

	if g:multiple_cursors_map_keys
		" internal mapping
		nnoremap <C-F3> :call multipleCursors.init()<CR>
	endif

"	Commands:
"		Init 'vim-multiple-cursors' plugin:
"		:multipleCursors.init()
"


if exists('multiple_cursors#multipleCursors["loaded"]')

	finish
	" all methods of this class are listed here
	" delfun s:multipleCursors.init
	" delfun s:multipleCursors.clearMultipleCursors
	" delfun s:multipleCursors.initMultipleCursorPlugin
endif

" multipleCursors class {{{

	"==================================================
	" To retrieve a NEW instance of this object call: buffers_wrapper#getObject()
	"
	" es. let s:my_fucking_obj = multiple_cursors#getObject()
	" now if you try to do:
	"
	" echo s:my_fucking_obj.test_msg
	" >multiple_cursors: Fuck the world!
	"==================================================

	let multiple_cursors#multipleCursors = {}

	" Class fields {{{
		if exists("multiple_cursors#multipleCursors")
			" settings base fields of this class, all fields of
			" this class are listed here

			" field to show if this object is already sourced
			let multiple_cursors#multipleCursors["loaded"] = 1

			" current obj status message
			let multiple_cursors#multipleCursors["obj_msg"] = "No messages defined..."

			" obj test message, to try call this field to check
			" if you have instantiated correctly this object
			let multiple_cursors#multipleCursors["test_msg"] = "multiple_cursors: Fuck the world!"

			" current obj status flag
			let multiple_cursors#multipleCursors["status"] = 1

			" current obj error flag
			let multiple_cursors#multipleCursors["error"] = 0

			" field to handle last error retrieved TODO
			let multiple_cursors#multipleCursors["handler_error"] = ""

			" specific fields for current object
			" TODO
		endif
	" }}}

	" Class methods {{{
		" Function to retrieve a new instance of current object {{{
		function! multiple_cursors#getObject()
			return copy(g:multiple_cursors#multipleCursors)
		endfunction
		" }}}

		" Function to create coords window and common text window {{{
		function! multiple_cursors#MultipleCursors_init(buffers_obj)

			echo "init---"
			" Saving base window buffer id
			"call s:buff_obj.baseWindowBufferId(winbufnr(0))

			" creating coords window and saving buffer number associated with new window created
			8new
			"let l:buff_obj = copy(buffers_wrapper#GetObject())
			"echo \"obj loaded: ".l:buff_obj.obj_msg
			"let wrapper_loaded = l:buff_wrapper.obj_msg();
			"echo \"wrapper loaded: \" . multipleCursors["loaded"]
			" Saving coords window buffer id
			"call s:buff_obj.coordsWindowBufferId(winbufnr(0))

			" creating common text window and save buffer number associated with new window created
			"exe \":100vne"
			"call SetCommonTextWindowBufferId()
			" Saving common text window buffer id
			"call s:buff_obj.commonTextWindowBufferId(winbufnr(0))

			" Move cursor to base window
			"exe bufwinnr(s:buff_obj.baseWindowBufferId()) . \"wincmd w"
		endfunction
		" }}}

		" TODO: Function to clear coords window/buffer and common text window/buffer {{{
		function multiple_cursors#multipleCursors.clearMultipleCursors() dict
			echo "Not yet iplemented"
		endfunction
		" }}}

		" Function to init the MultipleCursorPlugin {{{
		function multiple_cursors#multipleCursors.initMultipleCursorPlugin() dict

			call SetBaseWindowBufferId()
			call MultipleCursors()
		endfunction
		" }}}
	" }}} Class methods end
" }}} multipleCursors class end
