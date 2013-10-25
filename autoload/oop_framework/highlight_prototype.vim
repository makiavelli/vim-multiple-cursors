"=============================================================================================
"	vim-oop-base package - Prototype to manage highlights and matches
"	Creation Date: 2013 August 10
"	Last Change: 2013 August 10
"	Maintainer: makiavelli <https://github.com/makiavelli/vim-multiple-cursors>
"	License: This file is placed in the public domain.
"	Version: 0.1.0
"
" 	Prototype's features available:
" 	- Function to highlight a specific match
" 	- Function to clear all highlights created
"=============================================================================================

" Avoids further load
if exists('highlightPrototypeLoaded')
	finish
endif

" highlightPrototype prototype {{{

	"==================================================
	" To retrieve a NEW instance of this prototype call: oop_framework#highlight_prototype#highlightPrototype.New()
	"
	" es. let s:my_fucking_obj = oop_framework#highlight_prototype#highlightPrototype.New()
	" now if you try to do:
	"
	" echo s:my_fucking_obj.test_msg
	" >oop_framework#highlight_prototype#highlightPrototype: Fuck the world!
	"==================================================

	" start the prototype
	let oop_framework#highlight_prototype#highlightPrototype = {}

	" Prototype methods {{{

		" Function to retrieve a new instance of current prototype {{{
		function oop_framework#highlight_prototype#highlightPrototype.New()

			" Extends oopHandler to give base methods to this prototype
			let l:highlightPrototype = extend(copy(self), g:oop_framework#oop_base#oopHandler.New(), "keep")

			" ### OVERRIDING PROPERTIES AND METHODS FROM oopHandler HERE ###

			" Prototype fields {{{

				" current prototype name
				let l:highlightPrototype["class_name"] = "oop_framework#highlight_prototype#highlightPrototype"

				" field to show if this prototype was already sourced
				let l:highlightPrototype["loaded"] = 1

				" enable debug mode
				let l:highlightPrototype["debug"] = 1

				" specific fields for current prototype
				" highlight group name
				let l:highlightPrototype["highlight_group_name"] = "oop_framework_highlight_group"

				" highlight group ctermbg value (default = green)
				let l:highlightPrototype["highlight_group_ctermbg"] = "green"

				" highlight group guibg value (default = green)
				let l:highlightPrototype["highlight_group_guibg"] = "green"

				" start/end highlight points
				let l:highlightPrototype["point1_x"] = ""
				let l:highlightPrototype["point1_y"] = ""
				let l:highlightPrototype["point2_x"] = ""
				let l:highlightPrototype["point2_y"] = ""

				" highlight type: char/line/block, default empty string
				let l:highlightPrototype["highlight_type"] = ""

				" highlight consts: char/line/block
				let l:highlightPrototype["highlight_type_constants"] = { "v" : "char", "V" : "line", "" : "block" }

			" }}} Prototype fields end
			return l:highlightPrototype
		endfunction
		" }}}

		" Function to create an highlight group
		function oop_framework#highlight_prototype#highlightPrototype.CreateHighlightGroup()

			call self.logMsg("normal! :highlight " . self.highlight_group_name . " ctermbg=" . self.highlight_group_ctermbg . " guibg=" . self.highlight_group_guibg . "\<Esc>")
			exe "normal! :highlight " . self.highlight_group_name . " ctermbg=" . self.highlight_group_ctermbg . " guibg=" . self.highlight_group_guibg . "\<Esc>"
			return 1
		endfunction

		" Function to clear saved start/end points inside this prototype
		function oop_framework#highlight_prototype#highlightPrototype.__ResetStartEndPoints()

			self.point1_x = ""
			self.point1_y = ""
			self.point2_x = ""
			self.point2_y = ""

			return 1
		endfunction

		" Function to setting start/end points inside this prototype
		function oop_framework#highlight_prototype#highlightPrototype.__SetStartEndPoints(pointsDictionary)

			" reset saved start/end points
			call self.__ResetStartEndPoints()

			if a:pointsDictionary["point1_x"]
				self.point1_x = a:pointsDictionary["point1_x"]
			endif

			if a:pointsDictionary["point1_y"]
				self.point1_y = a:pointsDictionary["point1_y"]
			endif

			if a:pointsDictionary["point2_x"]
				self.point2_x = a:pointsDictionary["point2_x"]
			endif

			if a:pointsDictionary["point2_y"]
				self.point2_y = a:pointsDictionary["point2_y"]
			endif

			return 1
		endfunction

		" Function to setting highlight type for this prototype
		function oop_framework#highlight_prototype#highlightPrototype.__SetHighlightType(highlightType)

			let self.highlight_type = ""

			if a:highlightType
				self.highlight_type = a:highlightType
			endif

			return 1
		endfunction

		" TODO: Function to create a new match starting from one line and one column,
		"	this will create a single point selection
		function oop_framework#highlight_prototype#highlightPrototype.CreateSinglePointSelection(row, col)

			" creating highlight group
			call self.CreateHighlightGroup()

			" adding a new single point selection
			call matchadd(self.highlight_group_name, '\%' . a:row . 'l\%' . a:col . 'c') 

			return 1
		endfunction

		" TODO: Function to create a new line selection
		function oop_framework#highlight_prototype#highlightPrototype.CreateLineSelection(col, fromRow, toRow)

			" creating highlight group
			call self.CreateHighlightGroup()

			" adding a new single point selection
			call matchadd(self.highlight_group_name, '\%>' . a:fromRow . 'l\%<' . a:toRow . 'l\%<' . a:col . 'c') 

			return 1
		endfunction

		" TODO: Function to create a new block selection
		function oop_framework#highlight_prototype#highlightPrototype.CreateBlockSelection(fromCol, toCol, row)

			" creating highlight group
			call self.CreateHighlightGroup()

			" adding a new single point selection
			call matchadd(self.highlight_group_name, '\%' . a:row . 'l\%<' . a:fromCol . 'c') 

			return 1
		endfunction

		" TODO: Function to create a new match starting from one or more line and one or more column,
		"	this will create a 2d selection, for example a square selection
		function oop_framework#highlight_prototype#highlightPrototype.Create2dSelection(fromCol, toCol, fromRow, toRow)

			" creating highlight group
			call self.CreateHighlightGroup()

			" adding a new single point selection
			call matchadd(self.highlight_group_name, '\%' . row . 'l\%' . col . 'c')

			return 1
		endfunction

		" TODO: Function to clear all highlight
		function oop_framework#highlight_prototype#highlightPrototype.ClearAllSelections()
			call clearmatches()

			return 1
		endfunction
	" }}} Prototype methods end
	" Prototype properties (getter/setter) {{{

	" }}}
" }}} highlightPrototype prototype end

let highlightPrototypeLoaded = 1
