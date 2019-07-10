# It defines an array prototype that returns first element of array  
Array:prototype:first = do (
	this[0]
)    
# It defines an array prototype that returns last element of array 
Array:prototype:last = do (
	this[this:length - 1]
)

# It stores all positions in the board and set as global variable 
export var Squares = Array.new(144)
# It stores all check positions when that exists
export var CheckMoves = []
