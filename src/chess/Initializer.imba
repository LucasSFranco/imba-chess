import Pawn from '../pieces/Pawn'
import Knight from '../pieces/Knight'
import Bishop from '../pieces/Bishop'
import Rook from '../pieces/Rook'
import Queen from '../pieces/Queen'
import King from '../pieces/King'
import Squares from '../Squares'

var Square = Squares

export def Initializer
	Squares.fill("margin")

	for r, row in Array.new(8) # 4
		for c, col in Array.new(8)
			let index = (row+2)*12 + (col+2) # 4
			Square[index] = undefined
	
	for c, col in Array.new(4) # 8
		Square[col+38] = Pawn.new :pawn, 2
		Square[col+98] = Pawn.new :pawn, 1

	# Square[26] = Rook.new :rook, 2 
	# Square[33] = Rook.new :rook, 2 
	# Square[110] = Rook.new :rook, 1 
	# Square[117] = Rook.new :rook, 1 

	# Square[27] = Knight.new :knight, 2 
	# Square[32] = Knight.new :knight, 2 
	# Square[111] = Knight.new :knight, 1 
	# Square[116] = Knight.new :knight, 1 

	# Square[28] = Bishop.new :bishop, 2 
	# Square[31] = Bishop.new :bishop, 2 
	# Square[112] = Bishop.new :bishop, 1 
	# Square[115] = Bishop.new :bishop, 1 

	# Square[29] = Queen.new :queen, 2 
	# Square[113] = Queen.new :queen, 1 

	# Square[30] = King.new :king, 2 
	# Square[114] = King.new :king, 1