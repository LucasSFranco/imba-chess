import Piece from './Piece'
import Squares from '../Global'

var Square = Squares

export class Knight < Piece

	def initialize player 
		super player, (player === 1 ? "https://upload.wikimedia.org/wikipedia/commons/7/70/Chess_nlt45.svg" : "https://upload.wikimedia.org/wikipedia/commons/e/ef/Chess_ndt45.svg")
		@type = "knight"
		@paths = [-25, -23, -14, -10, 10, 14, 23, 25]

	def getMoves position

		let attackPath = self.getStandard(position)

		for attack, index in moves:attack
			self.getCheck(position, attack, attackPath[index])

		self.verifyPin