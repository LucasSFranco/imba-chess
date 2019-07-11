import Initializer from './chess/Initializer'
import Movement from './chess/Movement'
import Squares from './Global'

var Move = Movement.new
var Square = Squares

tag Game

	prop selected 
	prop moves default: {displacement: [], attack: [], defense: []} 
	prop mouseover
	
	def build
		Initializer()

	def update
		for square, index in Squares
			if typeof square === :object
				square.getMoves(index)

	def transferIndex index
		if moves:displacement.includes(index) or moves:attack.includes(index)
			Move.target = index
			selected = undefined
		else if Square[index]
			Move.source = index
			selected = index	
		moves = Move.doMove
		self.render

	def hover index
		mouseover = index

	def isEven num
		num % 2 === 0

	def render
		self.update
		const rows = [8, 7, 6, 5, 4, 3, 2, 1]
		const cols = [:a, :b, :c, :d, :e, :f, :g, :h]
		<self>
			<div.board>
				<svg:svg.box>
					for rowCoordinate, row in rows
						let y = row*60
						<svg:g>
							<svg:text.noselect font-family="Segoe UI" stroke-width="1" fill="#585858" stroke="#585858" x="15" y="{y+40}">
								"{rowCoordinate}"
							for colCoordinate, col in cols
								let color = (isEven(row) and isEven(col)) or (!isEven(row) and !isEven(col)) ? "#E6EDDE" : "#618340"
								let index = (row+2)*12 + (col+2)
								let x = col*60
								<svg:g :tap=(do transferIndex(index)) :mouseover=(do hover(index))>
									<svg:rect width="60" height="60" fill="{color}" x="{x+40}" y="{y+5}">
									if index === mouseover
										<svg:rect fill="none" stroke-width="4" stroke="white" width="57" height="57" x="{x+42}" y="{y+7}">
									if selected
										if index === selected
											<svg:rect width="60" height="60" fill="rgba(255,231,116,0.5)" x="{x+40}" y="{y+5}">
										if moves:displacement.includes(index)
											<svg:circle r="15" fill="rgba(160,160,160,0.5)" cx="{x+70}" cy="{y+35}">
										else if moves:attack.includes(index)
											<svg:circle r="15" fill="rgba(255,0,0,0.5)" cx="{x+70}" cy="{y+35}">
									if Square[index]
										<svg:image href="{Square[index].style}" height="60" width="60" x="{x+40}" y="{y+5}">
					for colCoordinate, col in cols 
						<svg:text.noselect font-family="Segoe UI" stroke-width="1" fill="#585858" stroke="#585858" x="{col*60+65}" y="510">
							"{colCoordinate}"

Imba.mount <Game>
