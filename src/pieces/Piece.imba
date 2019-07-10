import Squares, CheckMoves from '../Global'

var Square = Squares

export class Piece

	prop paths
	prop unmoved default: true
	prop pinMoves
	prop checkMoves default: CheckMoves
	prop moves default: {displacement: [], attack: [], defense: []}
	
	prop type
	prop player
	prop style

	def initialize player, image
		@player = player
		@style = image

	def getTrajectory piece, king, path
		let trajectory = Array.new
		if piece > king
			while piece > king
				trajectory.push(piece)
				piece+=path
		else
			while piece < king
				trajectory.push(piece)
				piece+=path
		return trajectory

	def verifyPin	
		if pinMoves
			for key of moves
				let legalMoves = []
				for move in moves[key]
					if pinMoves.includes(move)
						legalMoves.push(move)
				moves[key] = legalMoves
		pinMoves = undefined

	def check
		if checkMoves:length > 1
			checkMoves.splice(0)
			checkMoves.push([])
		if checkMoves:length === 1 and type !== "king"
			for key of moves 
				let legalMoves = []
				for move in moves[key]
					legalMoves.push(move) if checkMoves.first.includes(move)
				moves[key] = legalMoves

	def getStandard position
		@moves = {displacement: [], attack: [], defense: []}
		
		let attackPaths = Array.new
		for path in @paths
			let index = position+path
			while typeof Square[index] !== "string"
				unless Square[index]
					@moves:displacement.push(index)
					break if ["king", "knight"].includes(type)
				else if Square[index].player !== player
					@moves:attack.push(index)
					attackPaths.push(path)
					break
				else
					@moves:defense.push(index)			
					break
				index+=path

		return attackPaths

	def getOverpass index, path	
		if Square[index].type === "king" 
			@moves:defense.push(index+path)

	def getCheck position, index, path
		if Square[index].type === "king" 
			if @checkMoves:length === 0
				@checkMoves.push(getTrajectory(position, index, path))
			else
				let legalMoves = []
				for move in getTrajectory(position, index, path)
					unless @checkMoves.first.includes(move)
						legalMoves.push(move)
				@checkMoves.push(legalMoves) if typeof legalMoves.first === "number" 

	def getPin position, index, path
		let piece = index

		while typeof Square[index] !== "string"
			index+=path
			if typeof Square[index] === "object"
				if Square[index].player !== player and Square[index].type === "king"
					Square[piece].pinMoves = getTrajectory(position, index, path)
				break