import Piece from './Piece'
import Squares from '../Global'

var Square = Squares

export class Bishop < Piece

	def initialize player 
		super player, (player === 1 ? "https://upload.wikimedia.org/wikipedia/commons/b/b1/Chess_blt45.svg" : "https://upload.wikimedia.org/wikipedia/commons/9/98/Chess_bdt45.svg")
		@type = "bishop"
		@paths = [-13, -11, 11, 13]

	def getMoves position

		let attackPath = self.getStandard(position)

		for attack, index in moves:attack
			self.getOverpass(attack, attackPath[index])	
			self.getCheck(position, attack, attackPath[index])
			self.getPin(position, attack, attackPath[index])

		self.verifyPin