extends Control

@onready var label = $Timer_Label
@onready var timer = $Timer
@onready var total_time_seconds : int = 0

@onready var mine_count : int
@onready var mine_label = $Mine_Counter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()
	
	Minesweeper.tile_flagged.connect(_on_tile_flagged)
	Minesweeper.tile_unflagged.connect(_on_tile_unflagged)
	
	set_mine_count(99)
func _on_tile_flagged():
	set_mine_count(mine_count - 1)

func _on_tile_unflagged():
	set_mine_count(mine_count + 1)

func _on_timer_timeout() -> void:
	total_time_seconds += 1
	var m = floor(total_time_seconds / 60) as int
	var s = int(total_time_seconds % 60)
	label.text = "%02d:%02d" % [m,s]

func set_mine_count(new_mine_count):
	mine_count = new_mine_count
	mine_label.text = str(mine_count)

func _on_game_setup() -> void:
	set_mine_count(Difficulty.get_mines_per_difficulty())
	
