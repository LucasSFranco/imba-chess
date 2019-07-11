import Squares as Square, CheckMoves from '../Global'

export class Movement
	
	prop source
	prop target
	prop player default: 1 

	def verifyPawnEspecials source, target
		if Square[source].type === :pawn
			Square[source].doEnpassant(source, target)
			Square[source].doPromotion(source, target)
		Square[source].clearEnpassantCondition
		if Square[source].type === :pawn
			Square[source].verifyEnpassant(source, target)
	
	def verifyKingEspecials source, target
		if Square[source].type === :king
			Square[source].doCastle(source, target)

	def isMoved
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
			self.verifyPawnEspecials(source, target)
			self.verifyKingEspecials(source, target)

			self.isMoved
			self.changeSquare
			self.changeTurn
			self.reset
		else if source
			Square[source].verifyCheck
			return Square[source].player === player ? Square[source].moves : {displacement: [], attack: [], defense: []}
		return {displacement: [], attack: [], defense: []}





	