import Piece from './Piece'
import Squares from '../Global'

var Square = Squares

export class Rook < Piece

	def initialize player 
		super player, (player === 1 ? "https://upload.wikimedia.org/wikipedia/commons/7/72/Chess_rlt45.svg" : "https://upload.wikimedia.org/wikipedia/commons/f/ff/Chess_rdt45.svg")
		@type = "rook"
		@paths = [-12, -1, 1, 12]

	def getMoves position

		let attackPath = self.getStandard(position)

		for attack, index in moves:attack
			self.getOverpass(attack, attackPath[index])	
			self.getCheck(position, attack, attackPath[index])
			self.getPin(position, attack, attackPath[index])

		self.verifyPin