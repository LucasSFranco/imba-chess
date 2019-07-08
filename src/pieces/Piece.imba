export class Piece

	prop unmoved default: true
	prop type
	prop player
	prop style

	def initialize type, player, image
		@type = type
		@player = player
		@style = image
