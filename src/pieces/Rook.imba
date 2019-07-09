import Piece from './Piece'
import Squares from '../Global'

var Square = Squares

export class Rook < Piece

	prop pinnedPiece

	def initialize player 
		super player, (player === 1 ? "https://upload.wikimedia.org/wikipedia/commons/7/72/Chess_rlt45.svg" : "https://upload.wikimedia.org/wikipedia/commons/f/ff/Chess_rdt45.svg")
		type = "rook"
		paths = [-12, -1, 1, 12]

	def getAction position

		action = {moves: [], attacks: [], defenses: []}

		for path in paths
			for multiplier in multipliers
				let index = position+path*multiplier

				if Square[index] !== "margin"
					unless Square[index]
						action:moves.push(index)
					else if Square[index].player !== player
						action:attacks.push(index)
						if Square[index].type === "king" 
							action:defenses.push(index+path)
							getRestriction(position, index, path).forEach( do |move|
								if typeof checkMoves.first === "string"
									checkMoves.push(move)
								else
									checkMoves.splice(0, checkMoves:length, "NaN")
							)
							checkMoves.shift if typeof checkMoves.first === "string"
						unless pinnedPiece

							let opponent = index
												
							if pinnedPiece 
								Square[pinnedPiece].pinMoves = undefined
								pinnedPiece = undefined 	
							for el in Array.new(8)
								index+=path
								if typeof Square[index] === "object"
									if Square[index].player !== player and Square[index].type === "king"
										Square[opponent].pinMoves = getRestriction(position, index, path)
										pinnedPiece = opponent	
										break
									else if Square[index].type !== "king"
										break
						break
					else
						action:defenses.push(index)			
						break
				else
					break

		action = verifyPinMoves(action)
