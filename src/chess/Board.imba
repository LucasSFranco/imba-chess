import Squares from '../Global'

var Square = Squares

export tag Board

	prop action
	prop selected

	def isEven num
		num % 2 === 0

	def render
		const rows = [8, 7, 6, 5, 4, 3, 2, 1]
		const cols = [:a, :b, :c, :d, :e, :f, :g, :h]
		<self>
			<div.board>
				<svg:svg.box>
					for rowCoordinate, row in rows
						let y = row*60
						<svg:g>
							<svg:text font-family="Helvetica" stroke-width="1" fill="#585858" stroke="#585858" x="15" y="{y+40}">
								"{rowCoordinate}"
							for colCoordinate, col in cols
								let color = (isEven(row) and isEven(col)) or (!isEven(row) and !isEven(col)) ? "#E6EDDE" : "#618340"
								let index = (row+2)*12 + (col+2)
								let x = col*60
								<svg:g :tap=(do doMove(index))>
									<svg:rect width="60" height="60" fill="{color}" x="{x+40}" y="{y+5}">
									if selected
										if index === selected
											<svg:rect width="60" height="60" fill="rgba(255,231,116,0.5)" x="{x+40}" y="{y+5}">
										if action:moves.includes(index)
											<svg:circle r="15" fill="rgba(181,181,174,0.5)" cx="{x+70}" cy="{y+35}">
										else if action:attacks.includes(index)
											<svg:circle r="15" fill="rgba(255,0,0,0.5)" cx="{x+70}" cy="{y+35}">
									if Square[index]
										<svg:image href="{Square[index].style}" height="60" width="60" x="{x+40}" y="{y+5}">
					for colCoordinate, col in cols 
						<svg:text font-family="Helvetica" stroke-width="1" fill="#585858" stroke="#585858" x="{col*60+65}" y="510">
							"{colCoordinate}"