import Piece from './Piece'

export class Queen < Piece

	def initialize player 
		super player, (player === 1 ? "https://bit.ly/2XRvzSN" : "https://bit.ly/2JswLUr")
		@type = :queen
		@paths = [-13, -12, -11, -1, 1, 11, 12, 13]

	def getMoves position

		let attackPath = self.getStandard(position)

		for attack, index in moves:attack
			self.getOverpass(attack, attackPath[index])	
			self.getCheck(position, attack, attackPath[index])
			self.getPin(position, attack, attackPath[index])

		self.verifyPin