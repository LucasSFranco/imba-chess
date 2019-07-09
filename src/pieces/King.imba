import Piece from './Piece'
import Squares from '../Global'

var Square = Squares

export class King < Piece

	prop castlingCondition

	def initialize player 
		super player, (player === 1 ? "https://upload.wikimedia.org/wikipedia/commons/4/42/Chess_klt45.svg" : "https://upload.wikimedia.org/wikipedia/commons/f/f0/Chess_kdt45.svg")
		type = "king"
		paths = [-13, -12, -11, -1, 1, 11, 12, 13]

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
					action:moves.push(source+paths[2])
			)

	def doCastling source, target
		if castlingCondition
			[[-1, -2, -4], [1, 2, 3]].forEach(do |paths|
				if target === (source + paths[1])
					Square[source+paths[0]] = Square[source+paths[2]]
					Square[source+paths[2]] = undefined
			)


	def getAllEnemyMoves
		let allEnemyMoves = []

		for square, index in Squares
			let enemyMoves = []
			if typeof square === "object" and square.player !== player
				if !(square.type === "king") and !(square.type === "pawn") 
					enemyMoves = [*square.action:moves, *square.action:defenses]
				else if square.type === "king"
					for path in paths
						enemyMoves.push(index+path)
				else
					enemyMoves = square.action:defenses
				for move in enemyMoves
					unless allEnemyMoves.includes(move)
						allEnemyMoves.push(move)
		return allEnemyMoves

	def getAction position
		action = {moves: [], attacks: [], defenses: []} 

		let allEnemyMoves = getAllEnemyMoves()

		for path in paths
			let index = position+path

			if Square[index] !== "margin"
				unless Square[index]
					action:moves.push(index)
				else if Square[index].player !== player
					action:attacks.push(index)
				else
					action:defenses.push(index)			

		for key of action
			let legalMoves = []
			for move in action[key]
				unless allEnemyMoves.includes(move)
					legalMoves.push(move)
			action[key] = legalMoves

		verifyCastling(position, allEnemyMoves)