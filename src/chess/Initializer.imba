import Pawn from './pieces/Pawn'
import Knight from './pieces/Knight'
import Bishop from './pieces/Bishop'
import Rook from './pieces/Rook'
import Queen from './pieces/Queen'
import King from './pieces/King'
import Squares from './chess/Squares'

export def Initializer(player, action)
	Squares.fill("margin")

	for r, row in Array.new(6) # 4
		for c, col in Array.new(8)
			let index = (row+3)*12 + (col+2) # 4
			Squares[index] = undefined
	
	for c, col in Array.new(4) # 8
		Squares[col+38] = Pawn.new 2
		Squares[col+98] = Pawn.new 1

	Squares[26] = Rook.new 2
	Squares[33] = Rook.new 2
	Squares[110] = Rook.new 1
	Squares[117] = Rook.new 1

	Squares[27] = Knight.new 2
	Squares[32] = Knight.new 2
	Squares[111] = Knight.new 1
	Squares[116] = Knight.new 1

	Squares[28] = Bishop.new 2
	Squares[31] = Bishop.new 2
	Squares[112] = Bishop.new 1
	Squares[115] = Bishop.new 1

	Squares[29] = Queen.new 2
	Squares[113] = Queen.new 1

	Squares[30] = King.new 2
	Squares[114] = King.new 1