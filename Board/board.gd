extends Node



@onready var TileScene = preload("res://Tile/tile.tscn")
@onready var tile_script = preload("res://Tile/tile.gd")
var tiles = []

@onready var grid:GridContainer = $MarginContainer/CenterContainer/GridContainer 
var board = [] # Holds all the hidden values of the puzzle
var board_size:Vector2i
var mines:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	board_size = Difficulty.get_size_per_difficulty()
	mines = Difficulty.get_mines_per_difficulty()
	
	# Generates puzzle
	board = Minesweeper.generate_puzzle(board_size, mines)
	
	# Generate rendered grid
	var grid_size:Vector2 = set_up_grid()
	resize_window(grid_size)

func set_up_grid() -> Vector2:
	grid.columns = board_size.x
	var tile_size
	for i in range(board_size.y):
		var row = []
		for j in range(board_size.x):			
			var tile = TileScene.instantiate()
			tile_size = tile.get_tile_size()
			tile.hidden_value = board[i][j]
			tile.position = Vector2i(j*tile_size.x + tile_size.x / 2, i*tile_size.y + tile_size.y / 2)
			if board[i][j] == Minesweeper.TILE_VALUES.BLANK:
				tile.blank_opened.connect(_on_blank_opened.bind(i,j))
			elif board[i][j] == Minesweeper.TILE_VALUES.MINE:
				tile.mine_opened.connect(_on_mine_opened)
			row.append(tile)
			grid.add_child(tile)
		tiles.append(row)
	
	return Vector2(board_size.x * tile_size.x, board_size.y * tile_size.y)

func resize_window(grid_size) -> void:
	var margin_size = $MarginContainer.get_minimum_size()
	print(margin_size)
	get_window().size = grid_size + margin_size



func _on_blank_opened(i, j):
	# Opens all neighbors (we are sure thay are not mines)
	for k in range(-1, 2):
		for l in range (-1, 2):
			if (i+k >= 0 and i+k < board_size.y) and (j+l >= 0 and j+l < board_size.x):
				if not tiles[i+k][j+l]._is_pressed:
					# We use open tile so to progate the signal in case the opend tile is a blank
					tiles[i+k][j+l].open_tile()

func _on_mine_opened():
	# Check all board for mines and show them
	for i in range(board_size.y):
		for j in range(board_size.x):
			if board[i][j] == Minesweeper.TILE_VALUES.MINE:
				tiles[i][j].show_hidden_value()
	game_lost()

func game_lost():
	grid.set_process_mode(Node.PROCESS_MODE_DISABLED)
	#grid.set_process_mode(Node.PROCESS_MODE_INHERIT)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
