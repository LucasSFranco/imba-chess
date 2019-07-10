import Squares, CheckMoves from '../Global'

var Square = Squares

export class Movement
	
	prop source
	prop target
	prop player default: 1 

	def clearEnPassant
		for square in Squares
			if typeof square === "object" and square.type === "pawn" and square.enPassantAttack
				square.enPassantAttack = undefined

	def pawnEspecials source, target
		if Square[source].type === :pawn
			Square[source].doEnPassant(source, target)
			Square[source].doPromotion(source, target)
		clearEnPassant()
		if Square[source].type === :pawn
			Square[source].verifyEnPassant(source, target)
	
	def kingEspecials source, target
		if Square[source].type === :king
			Square[source].doCastling(source, target)

	def moved
		if Square[source].unmoved
			Square[source].unmoved = false

	def changeTurn
		if player === 1
			player = 2
		else
			player = 1

	def reset
		target = undefined
		source = undefined
		CheckMoves.splice(0) if CheckMoves:length > 0

	def changeSquare
		Square[target] = Square[source]
		Square[source] = undefined

	def doMove 
		if target 
			self.pawnEspecials(source, target)
			self.kingEspecials(source, target)

			self.moved
			self.changeSquare
			self.changeTurn
			self.reset
			return {displacement: [], attack: [], defense: []}
		else if source
			Square[source].check
			return Square[source].player === player ? Square[source].moves : {displacement: [], attack: [], defense: []}





	