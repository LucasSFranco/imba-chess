

# # Fazer movimento das peças, suavemente
# # Fazer placar de jogadas
# # Fazer relógio
# # Fazer casos de empate 

# class Piece

# 	prop action default: {moves: [], attacks: [], defenses: []} 
# 	prop paths
# 	prop pinnedPiece
# 	prop pinMoves
# 	prop identity
# 	prop type
# 	prop player
# 	prop style

# 	def initialize identity, type, player, iconUrl
# 		@identity = identity
# 		@type = type
# 		@player = player
# 		@style = iconUrl

# 	def verifyPinMoves	
# 		if pinMoves
# 			for key of action
# 				let legalMoves = []
# 				for move in action[key]
# 					if pinMoves.includes(move)
# 						legalMoves.push(move)
# 				action[key] = legalMoves
# 		return action

# 	def getKing squares
# 		for square in squares
# 			if square and square !== "offBoard" and square.player === player and square.type === "king"
# 				return square

# 	def verifyCheckMoves squares
# 		let king = getKing squares
# 		if king.checkMoves
# 			for key of action
# 				let legalMoves = []
# 				for move in action[key]
# 					if king.checkMoves.includes(move)
# 						legalMoves.push(move)
# 				action[key] = legalMoves
# 		return action

# 	def verifyAction squares, path, multiplier=1, getPin=true  	
# 		let squareID = identity+path*multiplier
# 		let especialSquareID = identity+path*(multiplier+1)	
# 		let square = squares[squareID]
# 		if square !== "offBoard"
# 			unless square
# 				if squares[identity].type === "pawn" and [-13, -11, 11, 13].includes(path)
# 					action:defenses.push(squareID)
# 				else
# 					action:moves.push(squareID)
# 			else if square.player !== player
# 				action:attacks.push(squareID)
# 				if square.type === "king" 
# 					action:defenses.push(especialSquareID)
# 					let checkMoves = []
# 					let pieceID = identity
# 					let kingID = squareID
# 					if pieceID > kingID
# 						while pieceID > kingID
# 							checkMoves.push(pieceID)
# 							pieceID+=path
# 					else
# 						while pieceID < kingID
# 							checkMoves.push(pieceID)
# 							pieceID+=path
# 					if square.checkMoves
# 						let legalMoves = []
# 						for move in checkMoves
# 							if square.checkMoves.includes(move)
# 								legalMoves.push(move)
# 						checkMoves = legalMoves
# 					square.checkMoves = checkMoves
# 				else unless getPin
# 					let enemyPiece = square
# 					let sucessorSquareID = squareID
# 					if pinnedPiece 
# 						pinnedPiece.pinMoves = null
# 						pinnedPiece = null
# 					for el in Array.new 8
# 						sucessorSquareID += path
# 						let sucessorSquare = squares[sucessorSquareID]
# 						if sucessorSquare and sucessorSquare !== "offBoard"
# 							if sucessorSquare.player !== player and sucessorSquare.type === "king"
# 								let pinMoves = []
# 								let pieceID = identity
# 								let enemyPieceID = sucessorSquareID
# 								if pieceID > enemyPieceID
# 									while pieceID > enemyPieceID
# 										pinMoves.push(pieceID)
# 										pieceID+=path
# 								else 
# 									while pieceID < enemyPieceID
# 										pinMoves.push(pieceID)
# 										pieceID+=path
# 								enemyPiece.pinMoves = pinMoves
# 								pinnedPiece = enemyPiece
# 								getPin = true	
# 								break
# 							else if sucessorSquare.type !== "king"
# 								break
# 				return "break"
# 			else if squares[identity].type !== "pawn" 
# 				action:defenses.push(squareID)
# 				return "break"
# 		else
# 			return "break"


# class Pawn < Piece

# 	prop promotionCondition
# 	prop enPassantCondition
# 	prop enPassantAttackID
# 	prop unmoved default: true
# 	prop unmovedPaths default: {
# 		1: -24
# 		2: 24
# 	}

# 	prop promotionSquares default: {
# 		1: [26, 27, 28, 29, 30, 31, 32, 33]
# 		2: [110, 111, 112, 113, 114, 115, 116, 117]
# 	}

# 	def initialize identity, type, player 
# 		super identity, type, player, (player === 1 ? "https://upload.wikimedia.org/wikipedia/commons/4/45/Chess_plt45.svg" : "https://upload.wikimedia.org/wikipedia/commons/c/c7/Chess_pdt45.svg")
# 		paths = {
# 			1: [-11, -12, -13]
# 			2: [11, 12, 13]
# 		}
		
# 	def getAction squares
# 		action = {moves: [], attacks: [], defenses: []} 

# 		for path in paths[player]
# 			verifyAction squares, path

# 		let index = identity+unmovedPaths[player]
		
# 		if unmoved and !squares[index]
# 			action:moves.push index
# 		if promotionSquares[player].includes(identity)
# 			promotionCondition = true
# 		if enPassantCondition
# 			action:attacks.push(enPassantPieceIndex)
		
# 		action = verifyPinMoves
# 		action = verifyCheckMoves(squares)
		
# 		return action 

# class Knight < Piece

# 	def initialize identity, type, player 
# 		super identity, type, player, (player === 1 ? "https://upload.wikimedia.org/wikipedia/commons/7/70/Chess_nlt45.svg" : "https://upload.wikimedia.org/wikipedia/commons/e/ef/Chess_ndt45.svg")
# 		paths = [-25, -23, -14, -10, 10, 14, 23, 25]

# 	def getAction squares
# 		action = {moves: [], attacks: [], defenses: []} 

# 		for path in paths
# 			verifyAction squares, path
		
# 		action = verifyPinMoves
# 		action = verifyCheckMoves(squares)

# 		return action

# class Bishop < Piece

# 	def initialize identity, type, player 
# 		super identity, type, player, (player === 1 ? "https://upload.wikimedia.org/wikipedia/commons/b/b1/Chess_blt45.svg" : "https://upload.wikimedia.org/wikipedia/commons/9/98/Chess_bdt45.svg")
# 		paths = [-13, -11, 11, 13]

# 	def getAction squares
# 		action = {moves: [], attacks: [], defenses: []} 
		
# 		let getPin = false
# 		for path in paths
# 			for multiplier in [1, 2, 3, 4, 5, 6, 7, 8]
# 				let bool = null
# 				bool = verifyAction squares, path, multiplier, false
# 				break if bool === "break"

# 		action = verifyPinMoves
# 		action = verifyCheckMoves(squares)

# 		return action

# class Rook < Piece

# 	prop unmoved default: true

# 	def initialize identity, type, player 
# 		super identity, type, player, (player === 1 ? "https://upload.wikimedia.org/wikipedia/commons/7/72/Chess_rlt45.svg" : "https://upload.wikimedia.org/wikipedia/commons/f/ff/Chess_rdt45.svg")
# 		paths = [-12, -1, 1, 12]

# 	def getAction squares
# 		action = {moves: [], attacks: [], defenses: []} 
		
# 		for path in paths
# 			for multiplier in [1, 2, 3, 4, 5, 6, 7, 8]
# 				let bool = null
# 				bool = verifyAction squares, path, multiplier, false
# 				break if bool === "break"
		
# 		action = verifyPinMoves
# 		action = verifyCheckMoves(squares)

# 		return action

# class Queen < Piece

# 	def initialize identity, type, player 
# 		super identity, type, player, (player === 1 ? "https://upload.wikimedia.org/wikipedia/commons/1/15/Chess_qlt45.svg" : "https://upload.wikimedia.org/wikipedia/commons/4/47/Chess_qdt45.svg")
# 		paths = [-13, -12, -11, -1, 1, 11, 12, 13]

# 	def getAction squares
# 		action = {moves: [], attacks: [], defenses: []} 
		
# 		for path in paths
# 			for multiplier in [1, 2, 3, 4, 5, 6, 7, 8]
# 				let bool = null
# 				bool = verifyAction squares, path, multiplier, false
# 				break if bool === "break"
		
# 		action = verifyPinMoves
# 		action = verifyCheckMoves(squares)

# 		return action

# class King < Piece

# 	prop checkMoves
# 	prop castlingCondition
# 	prop unmoved default: true

# 	def initialize identity, type, player 
# 		super identity, type, player, (player === 1 ? "https://upload.wikimedia.org/wikipedia/commons/4/42/Chess_klt45.svg" : "https://upload.wikimedia.org/wikipedia/commons/f/f0/Chess_kdt45.svg")
# 		paths = [-13, -12, -11, -1, 1, 11, 12, 13]

# 	def getAllEnemyMoves squares, paths
# 		let allEnemyMoves = []

# 		for square in squares
# 			let enemyMoves = []
# 			if square and square !== "offBoard" and square.player !== player
# 				if !(square.type === "king") and !(square.type === "pawn") 
# 					enemyMoves = square.getAction(squares)
# 					enemyMoves = [*enemyMoves:moves, *enemyMoves:defenses]
# 				else if square.type === "king"
# 					for path in paths
# 						let move = square.identity+path
# 						enemyMoves.push(move)
# 				else if square.type === "pawn"
# 					enemyMoves = square.getAction(squares)
# 					enemyMoves = enemyMoves:defenses
# 				for move in enemyMoves
# 					unless allEnemyMoves.includes(move)
# 						allEnemyMoves.push(move)

# 		return allEnemyMoves 

# 	def getAction squares
# 		action = {moves: [], attacks: [], defenses: []} 

# 		let allEnemyMoves = getAllEnemyMoves squares, paths


# 		for path in paths
# 			verifyAction squares, path

# 		for key of action
# 			let legalMoves = []
# 			for move in action[key]
# 				unless allEnemyMoves.includes(move)
# 					legalMoves.push(move)
# 			action[key] = legalMoves

# 		if unmoved
# 			let majorCastling = true
# 			let minorCastling = true
# 			for move in [identity, identity - 1, identity - 2, identity - 3, identity - 4]
# 				if allEnemyMoves.includes(move) or (move !== (identity - 4) and squares[move])
# 					majorCastling = false
# 			for move in [identity, identity + 1, identity + 2, identity + 3]
# 				if allEnemyMoves.includes(move) or (move !== (identity + 3) and squares[move])
# 					minorCastling = false

# 			let leftRook = squares[identity - 4]
# 			let rightRook = squares[identity + 3]
# 			if majorCastling and leftRook !== "offBoard" and leftRook.type === "rook" and leftRook.unmoved  
# 				castlingCondition = true
# 				action:moves.push(identity - 2)
# 			if minorCastling and rightRook !== "offBoard" and rightRook.type === "rook" and rightRook.unmoved
# 				castlingCondition = true
# 				action:moves.push(identity + 2)

# 		return action

# tag Game
	
# 	prop squares
# 	prop sourceID
# 	prop player
# 	prop action

# 	def build
# 		initialization

# 	def initialization
# 		squares = Array.new(144).fill("offBoard")

# 		for r, row in Array.new 4
# 			for c, col in Array.new 8
# 				let index = (row+4)*12 + (col+2)
# 				squares[index]=null
		
# 		for el, i in Array.new 8
# 			squares[i+38] = Pawn.new i+38, "pawn", 2
# 			squares[i+98] = Pawn.new i+98, "pawn", 1

# 		squares[26] = Rook.new 26, "rook", 2 
# 		squares[33] = Rook.new 33, "rook", 2 
# 		squares[110] = Rook.new 110, "rook", 1 
# 		squares[117] = Rook.new 117, "rook", 1 

# 		squares[27] = Knight.new 27, "knight", 2 
# 		squares[32] = Knight.new 32, "knight", 2 
# 		squares[111] = Knight.new 111, "knight", 1 
# 		squares[116] = Knight.new 116, "knight", 1 

# 		squares[28] = Bishop.new 28, "bishop", 2 
# 		squares[31] = Bishop.new 31, "bishop", 2 
# 		squares[112] = Bishop.new 112, "bishop", 1 
# 		squares[115] = Bishop.new 115, "bishop", 1 

# 		squares[29] = Queen.new 29, "queen", 2 
# 		squares[113] = Queen.new 113, "queen", 1 

# 		squares[30] = King.new 30, "king", 2 
# 		squares[114] = King.new 114, "king", 1 

# 		player = 1
# 		action = {moves: [], attacks: [], defenses: []}

# 	def verifyEnPassantCondition square
# 		let piece
# 		if square and square !== "offBoard" and square.type === "pawn"
# 			square.enPassantCondition = true
# 			square.enPassantPieceIndex = source - 12
# 			piece = square
# 		return piece

# 	def move index
# 		let enPassantCondition
# 		if action:moves.includes(index) or action:attacks.includes(index)
# 			let endID = index
# 			let source = squares[sourceID] 
# 			let end = squares[index]

# 			if source.type === "king" and source.castlingCondition
# 				let rook, rookEnd
# 				if endID === (sourceID - 2)
# 					rook = squares[source - 4]
# 					rookEnd = squares[source - 1]
# 				if endID === (sourceID + 2)
# 					rook = squares[source + 3]
# 					rookEnd = squares[source + 1]
# 				rook.unmoved = false
# 				rookEnd = rook
# 				rookEnd.identity = sourceID - 1
# 				rook = null

# 			if source.type === "pawn" and source.enPassantCondition
# 				let enPassantAttackID = squares[source].enPassantAttackID
# 				if player === 1 and endID === enPassantAttackID
# 					squares[enPassantAttackID + 12] = null
# 				else if endID === enPassantAttackID
# 					squares[enPassantAttackID - 12] = null

# 			if enPassantCondition
# 				piece.enPassantCondition = undefined

# 			let piece
# 			enPassantCondition = false

# 			let king = source.getKing(squares)
# 			if king.checkMoves
# 				king.checkMoves = undefined

# 			if source.type === "pawn" or source.type === "rook" or source.type === "king"
# 				source.unmoved = false

# 			squares[endID] = squares[sourceID]
# 			squares[endID].identity = endID
# 			squares[sourceID] = null

# 			let x = []
# 			for square in squares
# 				if square and square !== "offBoard"
# 					square.getAction(squares)
# 					x.push square
			
# 			end = squares[endID]
# 			if end.type === "pawn" and end.promotionCondition
# 				squares[endID] = Queen.new index, "queen", end.player
			
# 			sourceID = null
# 			action = {moves: [], attacks: [], defenses: []}
			
# 			if player === 1
# 				player = 2
# 			else 
# 				player = 1
		
# 		else if squares[index]
# 			sourceID = index
# 			if squares[sourceID].player === player
# 				action = squares[sourceID].getAction(squares)
# 			else 
# 				action = {moves: [], attacks: [], defenses: []}

# 		render


# 	def isEven num
# 		num % 2 === 0

# 	def board rows, cols
# 		for rowCoordinate, row in rows
# 			let y = row*60+5
# 			<svg:g>
# 				<svg:text font-family="Helvetica" stroke-width="1" fill="#585858" stroke="#585858" x="15" y="{y+35}">
# 					"{rowCoordinate}"
# 				for colCoordinate, col in cols
# 					let color = (isEven(row) and isEven(col)) or (!isEven(row) and !isEven(col)) ? "#E6EDDE" : "#618340"
# 					let index = (row+2)*12 + (col+2)
# 					let x = col*60+40
# 					<svg:g :tap=(do move(index))>
# 						<svg:rect width="60" height="60" fill="{color}" x="{x}" y="{y}">
# 						if sourceID
# 							if index === sourceID
# 								<svg:rect width="60" height="60" fill="rgba(255,231,116,0.5)" x="{x}" y="{y}">
# 							if action:moves.includes(index)
# 								<svg:circle r="15" fill="rgba(181,181,174,0.5)" cx="{x+30}" cy="{y+30}">
# 							if action:attacks.includes(index)
# 								<svg:circle r="15" fill="rgba(255,0,0,0.5)" cx="{x+30}" cy="{y+30}">
# 						if squares[index]
# 							<svg:image href="{squares[index].style}" height="60" width="60" x="{x}" y="{y}">

# 	def render
# 		const rows = [8, 7, 6, 5, 4, 3, 2, 1]
# 		const cols = [:a, :b, :c, :d, :e, :f, :g, :h]
# 		<self>
# 			<div.board>
# 				<svg:svg.box>
# 					board rows, cols
# 					for colCoordinate, col in cols 
# 						<svg:text font-family="Helvetica" stroke-width="1" fill="#585858" stroke="#585858" x="{col*60+65}" y="510">
# 							"{colCoordinate}"

# Imba.mount <Game>
