extends Node2D


var board
var banner

@onready var container = $CenterContainer

@onready var BoardScene = preload("res://Board/board.tscn")
@onready var BannerScene = preload("res://Banner/Banner.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var game_pixel_size = Difficulty.get_size_per_difficulty()
	game_pixel_size *= Vector2(16,16)
	game_pixel_size.y += 40
	
	game_pixel_size += Vector2(100,100)
	
	print(game_pixel_size)
	get_window().size = game_pixel_size
	
	var banner = BannerScene.instantiate()
	container.add_child(banner)
	var board = BoardScene.instantiate()
	container.add_child(board)
