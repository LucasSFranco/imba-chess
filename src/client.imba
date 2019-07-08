import Squares from './chess/Squares'
import Initializer from './chess/Initializer'

tag Game

	prop move
	prop selected
	
	def build
		Initializer  


	def doMove index
		if selected
			selected = index
			move = Move.new(index)
		else
			move.target = index

	def isEven num
		num % 2 === 0

	def board rows, cols
		for rowCoordinate, row in rows
			let y = row*60+5
			<svg:g>
				<svg:text font-family="Helvetica" stroke-width="1" fill="#585858" stroke="#585858" x="15" y="{y+35}">
					"{rowCoordinate}"
				for colCoordinate, col in cols
					let color = (isEven(row) and isEven(col)) or (!isEven(row) and !isEven(col)) ? "#E6EDDE" : "#618340"
					let index = (row+2)*12 + (col+2)
					let x = col*60+40
					<svg:g :tap=(do move(index))>
						<svg:rect width="60" height="60" fill="{color}" x="{x}" y="{y}">
						if selected
							if index === selected
								<svg:rect width="60" height="60" fill="rgba(255,231,116,0.5)" x="{x}" y="{y}">
							if move.action:moves.includes(index)
								<svg:circle r="15" fill="rgba(181,181,174,0.5)" cx="{x+30}" cy="{y+30}">
							if move.action:attacks.includes(index)
								<svg:circle r="15" fill="rgba(255,0,0,0.5)" cx="{x+30}" cy="{y+30}">
						if Squares[index]
							<svg:image href="{Squares[index].style}" height="60" width="60" x="{x}" y="{y}">

	def render
		const rows = [8, 7, 6, 5, 4, 3, 2, 1]
		const cols = [:a, :b, :c, :d, :e, :f, :g, :h]
		<self>
			<div.board>
				<svg:svg.box>
					board rows, cols
					for colCoordinate, col in cols 
						<svg:text font-family="Helvetica" stroke-width="1" fill="#585858" stroke="#585858" x="{col*60+65}" y="510">
							"{colCoordinate}"

Imba.mount <Game>
