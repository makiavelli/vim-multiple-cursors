"=============================================================================================
"	vim-oop-base package - Prototype-based programming framework for VIM
"	Last Change: 2013 July 17
"	Maintainer: makiavelli <name@mail.org>
"	License: This file is placed in the public domain.
"	Version: 0.1.0
"
"	This file is intended as base handler of your prototypes.
"	To extends your existing prototypes do the follow two steps:
"
"	..................................................
"	1) DEFINE YOUR PROTOTYPE
"		let myFuckingPrototype = {}
"
"		Create a constructor for your prototype, like this
"		function myFuckingPrototype.New()
"			let l:myNewPrototype = extend(copy(self), g:oop_framework#oop_base#oopHandler.New(), 'keep')
"
"			return l:myNewPrototype
"		endfunction
"
"
"	2) USE YOUR PROTOTYPE
"		let aNewPrototype = myFuckingPrototype.New()
"
"
"	NOW IF YOU TRY TO DO
"		echo aNewPrototype.test_msg
"
""	YOU WILL SEE SOMETHING LIKE THIS
"		'Fuck the world!'
"
"		
"	Now your new prototype 'aNewPrototype' inherited all base methods and
"	properties from oopHandler
"	..................................................
"
" 	Prototype's features available:
" 	- Function to log message
" 	- TODO: Function to handler exceptions
"=============================================================================================

" Avoids further load
if exists('oopHandlerLoaded')
	finish
endif

" oopHandler prototype {{{

	"==================================================
	"
	" Uses this prototype to extend the functionality of another prototype
	"
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

			" field to show if this prototype was already sourced
			let l:oopBaseInstance["loaded"] = 0

			" status message
			let l:oopBaseInstance["obj_msg"] = "No messages defined..."

			" test message
			let l:oopBaseInstance["test_msg"] = "Fuck the world!"

			" status flag
			" 1 -> prototype successfully instantiated
			let l:oopBaseInstance["status"] = 1

			" error flag
			" 0 -> no error
			" 1 -> error encountered
			let l:oopBaseInstance["error"] = 0

			" TODO: field to handle last error retrieved
			let l:oopBaseInstance["handler_error"] = ""
		" }}} Prototype fields end

		return l:oopBaseInstance
	endfunction
	" }}}

	" Prototype methods {{{

		" Function to log a message like this -> 'prototypeName: your log message'
		" The log message will be prepended with the class name {{{
		function oop_framework#oop_base#oopHandler.logMsg(...)

			if a:0 == 1
				echom self.class_name . ": ". string(a:1)
			endif
		endfunction
		" }}}
	" }}} Prototype methods end
" }}} oopHandler prototype end

let oopHandlerLoaded = 1
