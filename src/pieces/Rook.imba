import Piece from './Piece'

export class Rook < Piece

	def initialize player 
		super player, (player === 1 ? "https://bit.ly/2Ju6p4D" : "https://bit.ly/2JzLdsP")
		@type = :rook
		@paths = [-12, -1, 1, 12]

	def getMoves position

		let attackPath = self.getStandard(position)

		for attack, index in moves:attack
			self.getOverpass(attack, attackPath[index])	
			self.getCheck(position, attack, attackPath[index])
			self.getPin(position, attack, attackPath[index])

		self.verifyPin