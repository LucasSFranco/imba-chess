import Piece from './Piece'
import Squares from '../Squares'
var Square = Squares

export class Pawn < Piece

	def initialize type, player 
		super type, player, (player === 1 ? "https://upload.wikimedia.org/wikipedia/commons/4/45/Chess_plt45.svg" : "https://upload.wikimedia.org/wikipedia/commons/c/c7/Chess_pdt45.svg")
	
	prop enPassantAttack

	prop paths default: {
		1: [-12, -13,  -11]
		2: [12,  13,  11]
	}

	prop enPassantPaths default: {
		1: -12
		2: 12
	}

	def doEnPassant position, target
		if target === enPassantAttack
			Square[enPassantAttack] = Square[position]
			Square[enPassantAttack+enPassantPaths[player]*(-1)] = null


	def verifyEnPassant position, target
		let index = enPassantPaths[player]
		if unmoved and target === position+2*index
			if Square[target - 1]
				Square[target - 1].enPassantAttack = position+index
			if Square[target + 1] 
				Square[target + 1].enPassantAttack = position+index

		
	def getAction position
		let action = {moves: [], attacks: [], defenses: []}

		# Attacks and defenses
		let indexes = paths[player].slice(-2)
		for index in indexes
			if typeof Square[position+index] === "object" and Square[position+index].player !== player
				action:attacks.push(position+index)
			action:defenses.push(position+index)
		if enPassantAttack
			action:attacks.push(enPassantAttack) 

		# Moves
		let index = paths[player].slice(0,1).pop
		unless Square[position+index]
			action:moves.push(position+index)
			if !Square[position+2*index] and unmoved
				action:moves.push(position+2*index)

		return action



