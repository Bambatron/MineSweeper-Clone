extends Node

# Expose a variable, whose value is saved with the scene and is editable in the editor
@export var hidden_value:Minesweeper.TILE_VALUES

const tile_size:Vector2i = Vector2i(16,16)
const pressed_texture_pos = {
	Minesweeper.TILE_VALUES.NUM_1: Vector2i(0,0),
	Minesweeper.TILE_VALUES.NUM_2: Vector2i(16,0),
	Minesweeper.TILE_VALUES.NUM_3: Vector2i(32,0),
	Minesweeper.TILE_VALUES.NUM_4: Vector2i(48,0),
	Minesweeper.TILE_VALUES.NUM_5: Vector2i(0,16),
	Minesweeper.TILE_VALUES.NUM_6: Vector2i(16,16),
	Minesweeper.TILE_VALUES.NUM_7: Vector2i(32,16),
	Minesweeper.TILE_VALUES.NUM_8: Vector2i(48,16),
	Minesweeper.TILE_VALUES.BLANK: Vector2i(0,32),
	Minesweeper.TILE_VALUES.MINE: Vector2i(32,48),
}
const unopened_texture_pos = Vector2i(16,32)
const flagged_texture_pos = Vector2i(32,32)
const clicked_mine_texture_pos = Vector2i(48,48)

# shorthand for the ready() func, called when the atttached node enters the active scene
@onready var sprite:Sprite2D = $Area2D/Sprite2D # Recover the node from the scene though path
@onready var _is_pressed = false # var _name => private variable
@onready var _is_flagged = false

# Declares a signal that can be emitted and listened to 
signal mine_opened
signal blank_opened

# Click on the tile
func open_tile():
	if _is_flagged:
		flag_tile()
		
	_is_pressed = true
	show_hidden_value()
	if hidden_value == Minesweeper.TILE_VALUES.MINE:
		mine_opened.emit() # Emits signal "mine_opened"
	elif hidden_value == Minesweeper.TILE_VALUES.BLANK:
		blank_opened.emit() # Emits signal "blank_opened"

# Shows the value under on screen
func show_hidden_value():
	if _is_pressed and hidden_value == Minesweeper.TILE_VALUES.MINE:
		sprite.region_rect = Rect2(clicked_mine_texture_pos, tile_size)
	else:
		sprite.region_rect = Rect2(pressed_texture_pos[hidden_value], tile_size)

# Toggle flag on tile
func flag_tile():
	if !_is_pressed:
		_is_flagged = not _is_flagged
		if _is_flagged:
			sprite.region_rect = Rect2(flagged_texture_pos, tile_size)
			Minesweeper.tile_flagged.emit()
		else:
			sprite.region_rect = Rect2(unopened_texture_pos, tile_size)
			Minesweeper.tile_unflagged.emit()

# this funciton is conneted to Area2D Input event
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if Input.is_action_pressed("left_click"):
				open_tile()
			elif Input.is_action_pressed("right_click"):
				flag_tile()

func get_tile_size() -> Vector2:
	return Vector2(16,16)
