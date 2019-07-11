import Piece from './Piece'
import Queen from './Queen'
import Squares as Square from '../Global'

export class Pawn < Piece

	prop enpassantAttack
	prop promotionSquares default: {
		1: [26, 27, 28, 29, 30, 31, 32, 33]
		2: [110, 111, 112, 113, 114, 115, 116, 117]
	}
	
	def initialize player 
		super player, (player === 1 ? "https://bit.ly/2Js9bY4" : "https://bit.ly/2NPrw5q")
		@type = :pawn
		@paths = {1: [-12, -13, -11], 2: [12, 13, 11]}

	def doPromotion source, target
		if promotionSquares[player].includes(target)
			Square[source] = Queen.new player

	def doEnpassant source, target
		if target === enpassantAttack
			let index = paths[player][0]*(-1)+enpassantAttack
			Square[index] = undefined

	def verifyEnpassant source, target
		let path = paths[player][0]
		let index = source+path
		if unmoved and target === (index+path)
			if typeof Square[target - 1] === :object and Square[target - 1].type === :pawn
				Square[target - 1].enpassantAttack = index
			if typeof Square[target + 1] === :object and Square[target + 1].type === :pawn
				Square[target + 1].enpassantAttack = index

	def getEnpassant
		if enpassantAttack
			moves:attack.push(enpassantAttack)

	def getAttackDefense position
		for path in paths[player].slice(-2)
			let index = position+path
			if typeof Square[index] === :object and Square[index].player !== player
				moves:attack.push(index)
				self.getCheck(position, index, path)
			moves:defense.push(index)

	def getDisplacement position
		let path = paths[player][0]
		let index = position+path
		if !Square[index]
			moves:displacement.push(index)
			index+=path
			if !Square[index] and unmoved
				moves:displacement.push(index)

	def getMoves position
		moves = {displacement: [], attack: [], defense: []}

		self.getAttackDefense(position)
		self.getDisplacement(position)
		self.getEnpassant

		self.verifyPin

