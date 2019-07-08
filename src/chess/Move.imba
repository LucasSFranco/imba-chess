import Squares from '../Squares'

var Square = Squares

export class Move
	
	prop source
	prop target
	prop action default: {moves: [], attacks: [], defenses: []}

	def initialize index
		source = index

	def moved
		if Square[source].unmoved
			Square[source].unmoved = false

	def pawnEspecials source, target
		if Square[source].type === :pawn
			Square[source].doPromotion(source, target)
			Square[source].doEnPassant(source, target)
			Square[source].verifyEnPassant(source, target)

	def clear
		target = undefined
		source = undefined

	def move player
		if target
			pawnEspecials(source, target)
			moved()
			Square[target] = Square[source]
			Square[source] = undefined
			clear()
			return true
		else if source
			action = Square[source].player === player ? Square[source].getAction(source) : {moves: [], attacks: [], defenses: []}
			return false





	