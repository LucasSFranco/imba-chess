import Piece from './Piece'

export class Knight < Piece

	def initialize player 
		super player, (player === 1 ? "https://upload.wikimedia.org/wikipedia/commons/7/70/Chess_nlt45.svg" : "https://upload.wikimedia.org/wikipedia/commons/e/ef/Chess_ndt45.svg")
		