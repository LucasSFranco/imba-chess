import Piece from './Piece'
import Queen from './Queen'
import Squares from '../Global'

var Square = Squares

export class Pawn < Piece

	def initialize player 
		super player, (player === 1 ? "https://upload.wikimedia.org/wikipedia/commons/4/45/Chess_plt45.svg" : "https://upload.wikimedia.org/wikipedia/commons/c/c7/Chess_pdt45.svg")
		type = "pawn"
		paths = {1: [-12, -13,  -11], 2: [12,  13,  11]}

	prop enPassantAttack

	prop promotionSquares default: {
		1: [26, 27, 28, 29, 30, 31, 32, 33]
		2: [110, 111, 112, 113, 114, 115, 116, 117]
	}

	def doPromotion position, target
		if promotionSquares[player].includes(target)
			Square[position] = Queen.new player

	def doEnPassant position, target
		if target === enPassantAttack
			let index = paths[player][0]*(-1)
			Square[enPassantAttack+index] = undefined

	def verifyEnPassant position, target
		let index = paths[player][0]
		if unmoved and target === position+2*index
			if typeof Square[target - 1] === "object" and Square[target - 1].type === "pawn"
				Square[target - 1].enPassantAttack = position+index
			if typeof Square[target + 1] === "object" and Square[target - 1].type === "pawn"
				Square[target + 1].enPassantAttack = position+index

	def getAction position

		action = {moves: [], attacks: [], defenses: []}

		let indexes = paths[player].slice(-2)
		for index in indexes
			if typeof Square[position+index] === "object" and Square[position+index].player !== player
				action:attacks.push(position+index)
				if Square[position+index].type === "king"
					getRestriction(position, position+index, index).forEach do |move| checkMoves.push(move) unless checkMoves.includes(move)
			action:defenses.push(position+index)

		if enPassantAttack
			action:attacks.push(enPassantAttack)

		let index = paths[player][0]
		unless Square[position+index]
			action:moves.push(position+index)
			if !Square[position+2*index] and unmoved
				action:moves.push(position+2*index)

		action = verifyPinMoves(action)





