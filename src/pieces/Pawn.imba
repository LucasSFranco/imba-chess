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
			if typeof Square[target + 1] === "object" and Square[target + 1].type === "pawn"
				Square[target + 1].enPassantAttack = position+index

	def getMoves position

		moves = {displacement: [], attack: [], defense: []}

		let indexes = paths[player].slice(-2)
		for index in indexes
			if typeof Square[position+index] === "object" and Square[position+index].player !== player
				moves:attack.push(position+index)
				if Square[position+index].type === "king"
					if checkMoves:length === 0
						checkMoves.push(getRestriction(position, index, index))
					else if checkMoves:length > 0
						let legalMoves = []
						for move in getRestriction(position, index, index)
							unless checkMoves.first.includes(move)
								legalMoves.push(move)
						
						checkMoves.push(legalMoves) if typeof legalMoves.first === "number" 
			moves:defense.push(position+index)

		if enPassantAttack
			moves:attack.push(enPassantAttack)

		let index = paths[player][0]
		unless Square[position+index]
			moves:displacement.push(position+index)
			if !Square[position+2*index] and unmoved
				moves:displacement.push(position+2*index)

		self.verifyPin

