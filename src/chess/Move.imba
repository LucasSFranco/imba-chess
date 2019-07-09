import Squares, checkMoves from '../Global'

var Square = Squares

export class Move
	
	prop source
	prop target
	prop action default: {moves: [], attacks: [], defenses: []}

	def clearEnPassant
		for square in Squares
			if typeof square === "object" and square.type === "pawn" and square.enPassantAttack
				square.enPassantAttack = undefined

	def kingEspecials source, target
		if Square[source].type === :king
			Square[source].doCastling(source, target)

	# Tentar ajeitar esse clearEnPassant
	def pawnEspecials source, target
		if Square[source].type === :pawn
			Square[source].doEnPassant(source, target)
			Square[source].doPromotion(source, target)
		clearEnPassant()
		if Square[source].type === :pawn
			Square[source].verifyEnPassant(source, target)
	
	def moved
		if Square[source].unmoved
			Square[source].unmoved = false

	def check
		console.log checkMoves
		if typeof checkMoves.first !== "string" and Square[source].type !== :king
			for key of Square[source].action 
				let legalMoves = []
				for move in Square[source].action[key]
					legalMoves.push(move) if checkMoves.includes(move)
				Square[source].action[key] = legalMoves

	def clear
		target = undefined
		source = undefined
		checkMoves.splice(0, checkMoves:length, "NaN") if typeof checkMoves.first !== "string"

	def squareChange
		Square[target] = Square[source]
		Square[source] = undefined

	# Tentar retirar aquele check desnecessário
	# Passar funções para baixo
	def move
		if target
			self.kingEspecials(source, target)
			self.pawnEspecials(source, target)
			self.moved()
			self.squareChange()
			self.clear()
			return true
		else if source
			self.check()
			return false





	