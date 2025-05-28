extends Node

enum TILE_VALUES {
	BLANK = 0, # No mines near
	NUM_1 = 1, # 1 mine near
	NUM_2 = 2, # 2 mines near
	NUM_3 = 3, # 3 mines near
	NUM_4 = 4, # 4 mines near
	NUM_5 = 5, # 5 mines near
	NUM_6 = 6, # 6 mines near
	NUM_7 = 7, # 7 mines near
	NUM_8 = 8, # 8 mines near
	MINE = 9, # A mine
}

# Generates a minesweeper puzzle board with given size and number of mines
func generate_puzzle(board_size:Vector2i, num_mines:int):
	var rows = board_size.y
	var cols = board_size.x
	
	# Generate clear board (no mines, all blank)
	var board = []
	for y in range(rows):
		var row = []
		for x in range(cols):
			row.append(0)
		board.append(row)
	
	# Randomly pick num_mines different position where to put mines
	var mines_coordinates = _generate_mines_coordinates(num_mines, rows, cols)
	
	# Place the mines in the board and updates the negihbors for clues
	for m_pos in mines_coordinates:
		board[m_pos.y][m_pos.x] = 9
		# Getting the neighbors
		var neighbors = []
		neighbors.append(Vector2i(m_pos.x-1, m_pos.y))
		neighbors.append(Vector2i(m_pos.x-1, m_pos.y+1))
		neighbors.append(Vector2i(m_pos.x, m_pos.y-1))
		neighbors.append(Vector2i(m_pos.x+1, m_pos.y-1))
		neighbors.append(Vector2i(m_pos.x+1, m_pos.y))
		neighbors.append(Vector2i(m_pos.x+1, m_pos.y+1))
		neighbors.append(Vector2i(m_pos.x, m_pos.y+1))
		neighbors.append(Vector2i(m_pos.x-1, m_pos.y-1))
		# Updating the neighbors clues
		for n in neighbors:
			if (0 <= n.x  and n.x <= cols-1) and (0 <= n.y and n.y <= rows-1):
				if board[n.y][n.x] != 9:
					board[n.y][n.x] += 1
	
	return board

# Randomly picks the given number of coordinates in the board bounds given for placing the mines. No repetitions
func _generate_mines_coordinates(num_mines:int, rows:int, cols:int) -> Array:
	# Generate board coordinates
	var board_coordinates = []
	for x in range(cols):
		for y in range(rows):
			board_coordinates.append(Vector2(x, y))
	
	# Generate board coordinates
	var mine_coordinates = []
	while mine_coordinates.size() < num_mines:
		var random_coord = board_coordinates[randi() % board_coordinates.size()]
		if random_coord not in mine_coordinates:
			mine_coordinates.append(random_coord)
	
	return mine_coordinates
