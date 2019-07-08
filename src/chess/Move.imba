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
			Square[source].doEnPassant(source, target)
			Square[source].verifyEnPassant(source, target)

	def move player
		if action:moves.includes(target) or action:attacks.includes(target)
			pawnEspecials(source, target)
			moved()
			Square[target] = Square[source]
			Square[source] = null
		else if Square[source]
			action = Square[source].player === player ? Square[source].getAction(source) : {moves: [], attacks: [], defenses: []}





	