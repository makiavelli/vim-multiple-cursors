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
		nnoremap <C-F3> :call InitPlugin()<CR>
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

function! InitPlugin()

	" Playing with buffer_wrapper class
	if exists("s:buff_obj")
		let s:buff_obj = {}
	endif

	if exists("s:buff_obj_new")
		let s:buff_obj_new = {}
	endif

	let s:mult_cursor = multiple_cursors#getObject()
	"echo \"aaa: " . s:mult_cursor.obj_msg

	let s:buff_obj = buffers_wrapper#getObject()
	let s:buff_obj_new = buffers_wrapper#getObject()

	echo "Ms (buff_obj): " . s:buff_obj.obj_msg
	echo "NEW Ms (buff_obj): " . s:buff_obj_new.obj_msg
	call multiple_cursors#MultipleCursors_init(s:buff_obj)
	echo "After (buff_obj): " . s:buff_obj.obj_msg
	echo "NEW After (buff_obj): " . s:buff_obj_new.obj_msg

	call s:buff_obj.baseWindowBufferId(12)

	echo "Base window buff id saved: " . s:buff_obj.base_window_buffer_id
	echo "NEW window buff id saved: " . s:buff_obj_new.base_window_buffer_id
endfunction
