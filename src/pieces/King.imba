import Piece from './Piece'
import Squares from '../Global'

var Square = Squares

export class King < Piece

	prop castlingCondition
	prop castlingSquares default: {
		right: [0, -1, -2, -3, -4]
		left: [0, 1, 2, 3]
	}

	def initialize player 
		super player, (player === 1 ? "https://upload.wikimedia.org/wikipedia/commons/4/42/Chess_klt45.svg" : "https://upload.wikimedia.org/wikipedia/commons/f/f0/Chess_kdt45.svg")
		@type = "king"
		@paths = [-13, -12, -11, -1, 1, 11, 12, 13]

	def verifyCastling source, allEnemyMoves
		if unmoved
			[[0, -1, -2, -3, -4], [0, 1, 2, 3]].forEach(do |paths|
				let rookCondition = true
				rookCondition = false if typeof Square[source+paths.last] !== "object" or Square[source+paths.last].type !== "rook" or !Square[source+paths.last].unmoved  
				let unattacked = true
				for path in paths
					if allEnemyMoves.includes(source+path)  
						unattacked = false
						break
				let moved = true
				for path in paths.slice(1,-1)
					if Square[source+path]
						moved = false
						break 
				if moved and unattacked and rookCondition
					castlingCondition = true
					moves:displacement.push(source+paths[2])
			)

	def doCastling source, target
		if @castlingCondition
			[[-1, -2, -4], [1, 2, 3]].forEach(do |paths|
				if target === (source + paths[1])
					Square[source+paths[0]] = Square[source+paths[2]]
					Square[source+paths[2]] = undefined
			)

	def getAllOpponentMoves
		let allOpponentMoves = []

		for square, index in Squares
			let opponentMoves = Array.new
			if typeof square === "object" and square.player !== player
				if !(square.type === "king") and !(square.type === "pawn") 
					opponentMoves = [*square.moves:displacement, *square.moves:defense]
				else if square.type === "king"
					for path in @paths
						opponentMoves.push(index+path)
				else
					opponentMoves = square.moves:defense
				for move in opponentMoves
					unless allOpponentMoves.includes(move)
						allOpponentMoves.push(move)

		return allOpponentMoves

	def verifyRestriction allOpponentMoves
		for type of moves
			let legalMoves = []
			for move in moves[type]
				unless allOpponentMoves.includes(move)
					legalMoves.push(move)
			moves[type] = legalMoves

	def getMoves position 

		self.getStandard(position)	

		let allOpponentMoves = self.getAllOpponentMoves

		self.verifyRestriction(allOpponentMoves)
		self.verifyCastling(position, allOpponentMoves)