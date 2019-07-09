import checkMoves from '../Global'

export class Piece

	prop paths
	prop unmoved default: true
	prop pinMoves
	prop checkMoves default: checkMoves
	prop action default: {moves: [], attacks: [], defenses: []}
	prop multipliers default: [1, 2, 3, 4, 5, 6, 7, 8]
	
	prop type
	prop player
	prop style

	def initialize player, image
		@player = player
		@style = image

	def getRestriction piece, king, path
		let restriction = []
		if piece > king
			while piece > king
				restriction.push(piece)
				piece+=path
		else
			while piece < king
				restriction.push(piece)
				piece+=path
		return restriction

	def verifyPinMoves	
		if pinMoves
			for key of action
				let legalMoves = []
				for move in action[key]
					if pinMoves.includes(move)
						legalMoves.push(move)
				action[key] = legalMoves
		return action