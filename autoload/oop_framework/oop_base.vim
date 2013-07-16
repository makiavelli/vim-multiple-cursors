"=============================================================================================
"	vim-multiple-cursors package - Prototype-based programming framework
"	Last Change: 2013 July 12
"	Maintainer: makiavelli <name@mail.org>
"	License: This file is placed in the public domain.
"	Version: 0.1.0
"
" 	Features available:
" 	- Base fields for class
" 	- Custom logging for classes
"=============================================================================================

" Exit if this script was already loaded
if exists('oopHandlerLoaded')
	finish
endif

" oopHandler class {{{

	"==================================================
	" Uses this class to extend the functionality of another class
	"
	" es. let s:my_fucking_obj = oop_framework#oop_base#oopHandler.New()
	" now if you try to do:
	"
	" echo s:my_fucking_obj.test_msg
	" >oop_framework: Fuck the world!
	"==================================================

	let oop_framework#oop_base#oopHandler = {}

	" Class properties (getter/setter) {{{
	" }}}

	" Function to retrieve a new instance of current class {{{
	function oop_framework#oop_base#oopHandler.New()

		let l:oopBaseInstance = copy(self)

		" Class fields {{{
			" settings base fields of this class, all fields of
			" this class are listed here. NB: this fields WILL BE OVERWRITTEN if
			" another class extends oopHandler and define
			" her own fields

			" class name
			let l:oopBaseInstance["class_name"] = "oop_framework#oop_base#oopHandler"

			" field to show if this object is already sourced
			let l:oopBaseInstance["loaded"] = 0

			" current obj status message
			let l:oopBaseInstance["obj_msg"] = "No messages defined..."

			" obj test message
			let l:oopBaseInstance["test_msg"] = "Fuck the world!"

			" current obj status flag
			" 1 -> class successfully instantiated
			let l:oopBaseInstance["status"] = 1

			" current obj error flag
			" 0 -> no error
			" 1 -> error encountered
			let l:oopBaseInstance["error"] = 0

			" field to handle last error retrieved TODO
			let l:oopBaseInstance["handler_error"] = ""
		" }}} Class fields end

		return l:oopBaseInstance
	endfunction
	" }}}

	" Class methods {{{
		" Function to log a message like this -> className: log message
		" At the log message will be prepended the class name
		" that {{{
		function oop_framework#oop_base#oopHandler.logMsg(...)

			if a:0 == 1
				echom self.class_name . ": ". string(a:1)
			endif
		endfunction
		" }}}
	" }}} Class methods end
" }}} oopHandler class end

let oopHandlerLoaded = 1
