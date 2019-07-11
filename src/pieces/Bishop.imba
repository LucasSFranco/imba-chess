import Piece from './Piece'

export class Bishop < Piece

	def initialize player 
		super player, (player === 1 ? "https://bit.ly/30tUIAC" : "https://bit.ly/2xJ7H4U")
		@type = :bishop
		@paths = [-13, -11, 11, 13]

	def getMoves position

		let attackPath = self.getStandard(position)

		for attack, index in moves:attack
			self.getOverpass(attack, attackPath[index])
			self.getCheck(position, attack, attackPath[index])
			self.getPin(position, attack, attackPath[index])

		self.verifyPin