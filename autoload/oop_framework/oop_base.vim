"=============================================================================================
"	vim-oop-base package - Prototype-based programming framework for VIM
"	Last Change: 2013 July 16
"	Maintainer: makiavelli <name@mail.org>
"	License: This file is placed in the public domain.
"	Version: 0.1.0
"
"	This file is intended as base handler of your prototype.
"	To extends your existing prototypes do it this way:
"
"	let l:myNewPrototype = extend(copy(l:myNewPrototype), g:oop_framework#oop_base#oopHandler.New(), 'keep')
"
"	Now your new prototype 'l:myNewPrototype' inherited methods and
"	properties from oopHandler
"
" 	Features available:
" 	- Function to log message
" 	- TODO: Function to handler exceptions
"=============================================================================================

" Avoids further load
if exists('oopHandlerLoaded')
	finish
endif

" oopHandler prototype {{{

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

	" Prototype properties (getter/setter) {{{
	" }}}

	" Function to retrieve a new instance of current prototype {{{
	function oop_framework#oop_base#oopHandler.New()

		let l:oopBaseInstance = copy(self)

		" Prototype fields {{{
			" Base fields of this prototype. NB: this fields WILL BE OVERWRITTEN if
			" another prototype extends oopHandler and define
			" her own fields

			" prototype name
			let l:oopBaseInstance["class_name"] = "oop_framework#oop_base#oopHandler"

			" field to show if this object is already sourced
			let l:oopBaseInstance["loaded"] = 0

			" status message
			let l:oopBaseInstance["obj_msg"] = "No messages defined..."

			" test message
			let l:oopBaseInstance["test_msg"] = "Fuck the world!"

			" status flag
			" 1 -> prototype successfully instantiated
			let l:oopBaseInstance["status"] = 1

			"  error flag
			" 0 -> no error
			" 1 -> error encountered
			let l:oopBaseInstance["error"] = 0

			" field to handle last error retrieved TODO
			let l:oopBaseInstance["handler_error"] = ""
		" }}} Prototype fields end

		return l:oopBaseInstance
	endfunction
	" }}}

	" Prototype methods {{{
		" Function to log a message like this -> className: log message
		" At the log message will be prepended the class name
		" that {{{
		function oop_framework#oop_base#oopHandler.logMsg(...)

			if a:0 == 1
				echom self.class_name . ": ". string(a:1)
			endif
		endfunction
		" }}}
	" }}} Prototype methods end
" }}} oopHandler prototype end

let oopHandlerLoaded = 1
