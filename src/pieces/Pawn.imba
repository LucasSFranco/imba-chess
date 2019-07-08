import Piece from './Piece'
import Squares from '../Squares'
import Queen from './Queen'

var Square = Squares

export class Pawn < Piece

	def initialize type, player 
		super type, player, (player === 1 ? "https://upload.wikimedia.org/wikipedia/commons/4/45/Chess_plt45.svg" : "https://upload.wikimedia.org/wikipedia/commons/c/c7/Chess_pdt45.svg")
	
	# It stores en passant attack square if it is possible 
	prop enPassantAttack

	# Index multiplicators for pawn movements
	prop paths default: {
		1: [-12, -13,  -11]
		2: [12,  13,  11]
	}

	# Possible pawn promotion squares for each player
	prop promotionSquares default: {
		1: [26, 27, 28, 29, 30, 31, 32, 33]
		2: [110, 111, 112, 113, 114, 115, 116, 117]
	}

	# Do pawn promotion if it is possible
	def doPromotion position, target
		if promotionSquares[player].includes(target)
			Square[position] = Queen.new :queen, player

	# Clear en passant condition
	def clearEnPassant
		for square in Squares
			if typeof square === "object" and square.type === "pawn" and square.enPassantAttack
				square.enPassantAttack = undefined

	# Do en passant movement if it is possible
	def doEnPassant position, target
		if target === enPassantAttack
			let index = paths[player].slice(0,1).pop*(-1)
			Square[enPassantAttack+index] = undefined
		else
			clearEnPassant()

	# Verification of en passant occurrence 
	def verifyEnPassant position, target
		let index = paths[player].slice(0,1).pop
		if unmoved and target === position+2*index
			if typeof Square[target - 1] === "object"
				Square[target - 1].enPassantAttack = position+index
			if typeof Square[target + 1] === "object"
				Square[target + 1].enPassantAttack = position+index

	# Get all pawn moves, attacks and defenses
	# moves: movements that don't threaten anything, but can restrict opponent king movements
	# attacks: movements that threaten a piece 
	# defenses: movements that restrict opponent king movements
	def getAction position
		let action = {moves: [], attacks: [], defenses: []}

		# Attacks and defenses
		let indexes = paths[player].slice(-2)
		for index in indexes
			if typeof Square[position+index] === "object" and Square[position+index].player !== player
				action:attacks.push(position+index)
			action:defenses.push(position+index)
		# Get en passant attack square
		if enPassantAttack
			action:attacks.push(enPassantAttack)
		# Moves
		let index = paths[player].slice(0,1).pop
		unless Square[position+index]
			action:moves.push(position+index)
			if !Square[position+2*index] and unmoved
				action:moves.push(position+2*index)

		return action



