import Piece from './Piece'

export class Rook < Piece

	prop unmoved default: true

	def initialize player 
		super player, (player === 1 ? "https://upload.wikimedia.org/wikipedia/commons/7/72/Chess_rlt45.svg" : "https://upload.wikimedia.org/wikipedia/commons/f/ff/Chess_rdt45.svg")
		