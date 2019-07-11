import Piece from './Piece'
import Squares from '../Global'

var Square = Squares

export class King < Piece

	prop canCastle
	prop castleSquares default: [[0, -1, -2, -3, -4], [0, 1, 2, 3]]

	def initialize player 
		super player, (player === 1 ? "https://bit.ly/32hXR8f" : "https://bit.ly/2S5DIxA")
		@type = :king
		@paths = [-13, -12, -11, -1, 1, 11, 12, 13]

	def verifyCastle position, allOpponentMoves
		if unmoved
			for side in castleSquares
				let conditions = []
				let rook = position+side.last
				if typeof Square[rook] !== :object or Square[rook].type !== :rook or !Square[rook].unmoved  
					conditions.push(false) 
				for square in side
					if allOpponentMoves.includes(position+square)  
						conditions.push(false)
						break
				let moved = true
				for square in side.slice(1,-1)
					if Square[position+square]
						conditions.push(false)
						break 
				if conditions.every(do |condition| condition)
					canCastle = true
					moves:displacement.push(position+side[2])

	def doCastle source, target
		if canCastle
			for side in castleSquares
				if target === (source + side[2])
					Square[source+side[1]] = Square[source+side.last]
					Square[source+side.last] = undefined

	def getAllOpponentMoves
		let allOpponentMoves = []

		for square, index in Squares
			let opponentMoves = []
			if typeof square === :object and square.player !== player
				if !(square.type === :king) and !(square.type === :pawn) 
					opponentMoves = [*square.moves:displacement, *square.moves:defense]
				else if square.type === :king
					for path in paths
						opponentMoves.push(index+path)
				else
					opponentMoves = square.moves:defense

				for move in opponentMoves
					unless allOpponentMoves.includes(move)
						allOpponentMoves.push(move)

		return allOpponentMoves

	def getMoves position 

		self.getStandard(position)	

		let allOpponentMoves = self.getAllOpponentMoves

		self.verifyRestriction(allOpponentMoves)
		self.verifyCastle(position, allOpponentMoves)