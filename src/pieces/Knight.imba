import Piece from './Piece'
import Squares from '../Global'

var Square = Squares

export class Knight < Piece

	def initialize player 
		super player, (player === 1 ? "https://upload.wikimedia.org/wikipedia/commons/7/70/Chess_nlt45.svg" : "https://upload.wikimedia.org/wikipedia/commons/e/ef/Chess_ndt45.svg")
		type = "knight"
		paths = [-25, -23, -14, -10, 10, 14, 23, 25]

	def getAction position

		action = {moves: [], attacks: [], defenses: []}

		for path in paths
			let index = position+path

			if Square[index] !== "margin"
				unless Square[index]
					action:moves.push(index)
				else if Square[index].player !== player
					action:attacks.push(index)
					if Square[index].type === "king" 
						getRestriction(position, index, path).forEach do |move| checkMoves.push(move) unless checkMoves.includes(move)
				else
					action:defenses.push(index)				

		action = verifyPinMoves(action)