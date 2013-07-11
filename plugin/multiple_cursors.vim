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


"===========================================
"
" vim-multiple-cursors plugin main functions
"
"===========================================
"
if exists('s:multipleCursors["loaded"]')
	delfun s:multipleCursors.init
	delfun s:multipleCursors.clearMultipleCursors
	delfun s:multipleCursors.initMultipleCursorPlugin
endif

let s:multipleCursors = {}

function s:multipleCursors.init(buffers_obj) dict
	" - Function to create coords window and common text window

	echo "multipleCursors.init called"
	" creating coords window and saving buffer number associated with new window created
	"exe \":8new"
	"let l:buff_obj = copy(buffers_wrapper#GetObject())
	"echo \"obj loaded: ".l:buff_obj.obj_msg
	"let wrapper_loaded = l:buff_wrapper.obj_msg();
	"echo \"wrapper loaded: \" . buffersWrapper["loaded"]
	let a:buffers_obj["obj_msg"] = "success"

	" creating common text window and save buffer number associated with new window created
	"exe \":100vne"
	"call SetCommonTextWindowBufferId()

	" move cursor to base window
	"exe bufwinnr(GetBaseWindowBufferId()) . \"wincmd w"
endfunction

function s:multipleCursors.clearMultipleCursors() dict
	" TODO: Function to clear coords window/buffer and common text window/buffer
endfunction

function s:multipleCursors.initMultipleCursorPlugin() dict
	" Function to init the MultipleCursorPlugin

	call SetBaseWindowBufferId()
	call MultipleCursors()
endfunction

if exists("s:multipleCursors")
	" successfully init of current object
	let s:multipleCursors["loaded"] = 1
endif

if exists("s:buff_obj")
	let s:buff_obj = {}
endif

" Playing with buffer_wrapper class
let s:buff_obj = buffers_wrapper#getObject()
let s:buff_obj_new = buffers_wrapper#getObject()

echo "Ms (buff_obj): " . s:buff_obj.obj_msg
echo "NEW Ms (buff_obj): " . s:buff_obj_new.obj_msg
call s:multipleCursors.init(s:buff_obj)
echo "After (buff_obj): " . s:buff_obj.obj_msg
echo "NEW After (buff_obj): " . s:buff_obj_new.obj_msg

call s:buff_obj.baseWindowBufferId(12)

echo "Base window buff id saved: " . s:buff_obj.base_window_buffer_id
echo "NEW window buff id saved: " . s:buff_obj_new.base_window_buffer_id
