import Piece from './Piece'

export class Knight < Piece

	def initialize player 
		super player, (player === 1 ? "https://bit.ly/2LIOkkC" : "https://bit.ly/2LIOwQS")
		@type = :knight
		@paths = [-25, -23, -14, -10, 10, 14, 23, 25]

	def getMoves position

		let attackPath = self.getStandard(position)

		for attack, index in moves:attack
			self.getCheck(position, attack, attackPath[index])

		self.verifyPin