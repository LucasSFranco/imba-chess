import Piece from './Piece'

export class Pawn < Piece

	def initialize player 
		super player, (player === 1 ? "https://upload.wikimedia.org/wikipedia/commons/4/45/Chess_plt45.svg" : "https://upload.wikimedia.org/wikipedia/commons/c/c7/Chess_pdt45.svg")
		