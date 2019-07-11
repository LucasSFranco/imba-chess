import Squares, CheckMoves from '../Global'

var Square = Squares

export class Piece

	prop unmoved default: true

	prop pinMoves
	prop checkMoves default: CheckMoves
	prop moves default: {displacement: [], attack: [], defense: []}

	prop type
	prop paths
	prop style
	prop player

	def initialize player, image
		@player = player
		@style = image

	def clearEnpassantCondition
		for square in Squares
			if typeof square === :object and square.type === :pawn and square.enpassantAttack
				square.enpassantAttack = undefined

	def getTrajectory piece, king, path
		let trajectory = []

		if piece > king
			while piece > king
				trajectory.push(piece)
				piece+=path
		else
			while piece < king
				trajectory.push(piece)
				piece+=path

		return trajectory

	def verifyRestriction restriction
		for category of moves
			let legalMoves = []
			for move in moves[category]
				if type === :king
					unless restriction.includes(move)
						legalMoves.push(move)
				else
					if restriction.includes(move)
						legalMoves.push(move)
			moves[category] = legalMoves

	def verifyPin	
		if pinMoves
			self.verifyRestriction(pinMoves)
		pinMoves = undefined

	def verifyCheck
		if checkMoves:length > 1
			checkMoves.splice(0, checkMoves:length, [])
		if checkMoves:length === 1 and type !== :king
			self.verifyRestriction(checkMoves.content)

	def getStandard position
		moves = {displacement: [], attack: [], defense: []}
		
		let attackPaths = []
		for path in paths
			let index = position+path
			while typeof Square[index] !== :string
				if !Square[index]
					moves:displacement.push(index)
					break if [:king, :knight].includes(type)
				else if Square[index].player !== player
					moves:attack.push(index)
					attackPaths.push(path)
					break
				else
					moves:defense.push(index)			
					break
				index+=path

		return attackPaths

	def getOverpass index, path	
		if Square[index].type === :king 
			moves:defense.push(index+path)

	def getCheck position, index, path
		if Square[index].type === :king 
			if checkMoves:length === 0
				checkMoves.push(getTrajectory(position, index, path))
			else
				let unrepeatedMoves = []
				for move in getTrajectory(position, index, path)
					unless checkMoves.content.includes(move)
						unrepeatedMoves.push(move)
				checkMoves.push(unrepeatedMoves) if typeof unrepeatedMoves.content === :number

	def getPin position, index, path
		let piece = index

		while typeof Square[index] !== :string
			index+=path
			if typeof Square[index] === :object
				if Square[index].player !== player and Square[index].type === :king
					Square[piece].pinMoves = getTrajectory(position, index, path)
				break