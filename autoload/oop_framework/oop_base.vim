"=============================================================================================
"	vim-multiple-cursors package - Object oriented programming framework
"	Last Change: 2013 July 12
"	Maintainer: Name Surname <name@mail.org>
"	License: This file is placed in the public domain.
"	Version: 0.1.0
"
" 	Features available:
" 	- Base fields for class
" 	- Custom logging for classes
"=============================================================================================

" Exit if this script was already loaded
"if exists('oop_framework#oop_base#oopHandler["loaded"]')
"	finish
"endif

" oopHandler class {{{

	"==================================================
	" Uses this class to extend the functionality of another class
	"
	" es. let s:my_fucking_obj = oop_framework#oop_base#getObject()
	" now if you try to do:
	"
	" echo s:my_fucking_obj.test_msg
	" >oop_framework: Fuck the world!
	"==================================================

	let oop_framework#oop_base#oopHandler = {}

	" Class properties (getter/setter) {{{
	" }}}

	" Class fields {{{
		if exists("oop_framework#oop_base#oopHandler")
			" settings base fields of this class, all fields of
			" this class are listed here

			" class name, this field WILL BE OVERWRITTEN when
			" another class extends oopHandler
			let oop_framework#oop_base#oopHandler["class_name"] = "oop_framework#oop_base#oopHandler"

			" field to show if this object is already sourced
			let oop_framework#oop_base#oopHandler["loaded"] = 0

			" current obj status message
			let oop_framework#oop_base#oopHandler["obj_msg"] = "No messages defined..."

			" obj test message
			let oop_framework#oop_base#oopHandler["test_msg"] = "Fuck the world!"

			" current obj status flag
			" 1 -> class successfully instantiated
			let oop_framework#oop_base#oopHandler["status"] = 1

			" current obj error flag
			" 0 -> no error
			" 1 -> error encountered
			let oop_framework#oop_base#oopHandler["error"] = 0

			" field to handle last error retrieved TODO
			let oop_framework#oop_base#oopHandler["handler_error"] = ""
		endif
	" }}}

	" Class methods {{{
		" Function to retrieve a new instance of current object {{{
		function! oop_framework#oop_base#getObject()
			return copy(g:oop_framework#oop_base#oopHandler)
		endfunction
		" }}}

		" Function to log a message like this -> className: log message
		" At the log message will be prepended the class name
		" that {{{
		function oop_framework#oop_base#oopHandler.logMsg(...) dict

			if a:0 == 1
				return self.class_name . ": ". a:1
			endif
		endfunction
		" }}}

	" }}} Class methods end
" }}} oopHandler class end
