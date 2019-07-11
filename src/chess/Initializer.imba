import Pawn from '../pieces/Pawn'
import Knight from '../pieces/Knight'
import Bishop from '../pieces/Bishop'
import Rook from '../pieces/Rook'
import Queen from '../pieces/Queen'
import King from '../pieces/King'
import Squares from '../Global'

var Square = Squares

export def Initializer
	Squares.fill("margin")

	for r, row in Array.new(4) 
		for c, col in Array.new(8)
			let index = (row+4)*12 + (col+2) 
			Square[index] = undefined
	
	for c, col in Array.new(8) 
		Square[col+38] = Pawn.new 2
		Square[col+98] = Pawn.new 1

	Square[27] = Knight.new 2 
	Square[32] = Knight.new 2 
	Square[111] = Knight.new 1 
	Square[116] = Knight.new 1 

	Square[28] = Bishop.new 2 
	Square[31] = Bishop.new 2 
	Square[112] = Bishop.new 1 
	Square[115] = Bishop.new 1 

	Square[26] = Rook.new 2 
	Square[33] = Rook.new 2 
	Square[110] = Rook.new 1 
	Square[117] = Rook.new 1 

	Square[29] = Queen.new 2 
	Square[113] = Queen.new 1 

	Square[30] = King.new 2 
	Square[114] = King.new 1