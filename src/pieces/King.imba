import Piece from './Piece'

export class King < Piece

	def initialize player 
		super player, (player === 1 ? "https://upload.wikimedia.org/wikipedia/commons/4/42/Chess_klt45.svg" : "https://upload.wikimedia.org/wikipedia/commons/f/f0/Chess_kdt45.svg")
				