"=============================================================================================
"	vim-oop-base package - Prototype to manage selections and matches
"	Creation Date: 2013 August 10
"	Last Change: 2013 August 10
"	Maintainer: makiavelli <https://github.com/makiavelli/vim-multiple-cursors>
"	License: This file is placed in the public domain.
"	Version: 0.1.0
"
" 	Prototype's features available:
" 	- Function to detect visal mode (single char, line or block)
" 	- Function to retrieve cursor start and finish about current visual
" 	  mode
"=============================================================================================

" Avoids further load
"if exists('s:prototypeLoaded')
"	finish
"endif

" Prototype {{{

	"==================================================
	" To retrieve a NEW instance of this prototype call: oop_framework#selections_prototype#selectionsPrototype.New()
	"
	" es. let s:my_fucking_obj = oop_framework#selections_prototype#selectionsPrototype.New()
	" now if you try to do:
	"
	" echo s:my_fucking_obj.test_msg
	" >oop_framework#selections_prototype#selectionsPrototype: Fuck the world!
	"==================================================

	" start the prototype
	let oop_framework#selections_prototype#selectionsPrototype = {}

	" Prototype methods {{{

		" Function to retrieve a new instance of current prototype {{{
		function oop_framework#selections_prototype#selectionsPrototype.New()

			" Extends oopHandler to give base methods to this prototype
			let l:prototype = extend(copy(self), g:oop_framework#oop_base#oopHandler.New(), "keep")

			" ### OVERRIDING PROPERTIES AND METHODS FROM oopHandler HERE ###

			" Prototype fields {{{

				" current prototype name
				let l:prototype["class_name"] = "oop_framework#selections_prototype#selectionsPrototype"

				" field to show if this prototype was already sourced
				let l:prototype["loaded"] = 1

				" enable debug mode
				let l:prototype["debug"] = 1

				" specific fields for current prototype

				" visual mode constants
				let l:prototype["char_visual_mode"] = "char"
				let l:prototype["line_visual_mode"] = "line"
				let l:prototype["block_visual_mode"] = "block"

				" current selection mode
				let l:prototype["current_visual_mode"] = ""

				" dictionary for visual mode name
				let l:prototype["visual_mode_map"] = { "v" : l:prototype["char_visual_mode"], "V" : l:prototype["line_visual_mode"], "" : l:prototype["block_visual_mode"] }

				" limits retrieved
				let l:prototype["point1_x"] = ""
				let l:prototype["point1_y"] = ""
				let l:prototype["point2_x"] = ""
				let l:prototype["point2_y"] = ""

			" }}} Prototype fields end
			return l:prototype
		endfunction
		" }}}

		" Function to detect visual selection mode {{{
		function oop_framework#selections_prototype#selectionsPrototype.__SetVisualMode()

			" clear saved limits and current visual mode flag
			call self.__ClearSavedLimitsData()

			" setting current selection mode
			let self.current_visual_mode = self.visual_mode_map[visualmode()]

			call self.logMsg("current selection mode retrieved: " . self.current_visual_mode)

			return 1
		endfunction
		" }}}

		" Function to clear all limits saved and current visual mode flag {{{
		function oop_framework#selections_prototype#selectionsPrototype.__ClearSavedLimitsData()

			" clear all limits saved
			let self.point1_x = ""
			let self.point1_y = ""
			let self.point2_x = ""
			let self.point2_y = ""

			" clear visual mode flag
			let self.current_visual_mode = ""

			return 1
		endfunction
		" }}}

		" Function to retrieve cursor start and finish {{{
		function oop_framework#selections_prototype#selectionsPrototype.__SetSelectionLimits()

			" setting current visual mode inside prototype
			let l:visual_mode = self.__SetVisualMode()

			" retrieving cursors positions
			let l:point_a = getpos("'<") " -> [bufnum, lnum, col, off]
			let l:point_b = getpos("'>") " -> [bufnum, lnum, col, off]

			let l:point_a_details = {"bufnum" : l:point_a[0], "lnum" : l:point_a[1], "col" : l:point_a[2], "off" : l:point_a[3]}
			let l:point_b_details = {"bufnum" : l:point_b[0], "lnum" : l:point_b[1], "col" : l:point_b[2], "off" : l:point_b[3]}

			" settings all limits inside this prototype
			let self.point1_x = l:point_a_details["col"]
			let self.point1_y = l:point_a_details["lnum"]

			" if self.current_visual_mode == line
			" 	then the x of second cursor tends to '$'
			if self.current_visual_mode == self.line_visual_mode
				let self.point2_x = "$"
			elseif
				let self.point2_x = l:point_b_details["col"]
			endif

			let self.point2_y = l:point_b_details["lnum"]

			call self.logMsg("point a (x,y) -> (" . string(l:point_a_details["col"]) . "," . string(l:point_a_details["lnum"]) . ")")
			call self.logMsg("point b (x,y) -> (" . string(l:point_b_details["col"]) . "," . string(l:point_b_details["lnum"]) . ")")
		endfunction
		" }}}

	" }}} Prototype methods end
	" Prototype properties (getter/setter) {{{
		" Function to get current visual mode {{{
		function oop_framework#selections_prototype#selectionsPrototype.GetVisualMode()

			" setting current visual mode
			call self.__SetVisualMode()

			return self.current_visual_mode
		endfunction
		" }}}

		" Function to retrieve cursors limit about visual mode.
		" This function return a dictionary like this:
		" Example of dictionary retrieved:
		" 	{ 
		" 		'point1_x' : 3,
		" 		'point1_y' : 7,
		" 		'point2_x' : 7,
		" 		'point2_y' : 7,
		" 		'visual_mode_name' : 'char'
		" 	 }
		" {{{
		function oop_framework#selections_prototype#selectionsPrototype.GetVisualModeLimits()

			" setting visual mode and cursors limit inside this prototype
			call self.__SetSelectionLimits()

			" TODO: make a dictionary like the example ones
			let l:limits_dictionary = { 'point1_x' : self.point1_x, 'point1_y' : self.point1_y, 'point2_x' : self.point2_x, 'point2_y' : self.point2_y, 'visual_mode_name' : self.current_visual_mode }

			return l:limits_dictionary
		endfunction
		" }}}
	" }}}
" }}} Prototype prototype end

let s:prototypeLoaded = 1
