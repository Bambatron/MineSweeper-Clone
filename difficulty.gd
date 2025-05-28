extends Node

# Beginner
# - 9x9 board and 10 mines
# - 12% probability of finding mine

# Intermediate
# - 16x16 board and 40 mines
# - 15% probability of finding mine

# Advanced
# - 24x24 board and 99 mines
# - 17% probability of finding mine

enum DIFFICULTY {
	BEGINNER,
	INTERMEDIATE,
	ADVANCED
}

# Dictionary
var difficulty_mapping = {
	"BEGINNER": DIFFICULTY.BEGINNER,
	"INTERMEDIATE": DIFFICULTY.INTERMEDIATE,
	"ADVANCED": DIFFICULTY.ADVANCED
}

var board_size_per_difficulty = {
	DIFFICULTY.BEGINNER: Vector2i(9, 9),
	DIFFICULTY.INTERMEDIATE: Vector2i(16, 16),
	DIFFICULTY.ADVANCED: Vector2i(30, 16)
}

var mines_per_difficulty = {
	DIFFICULTY.BEGINNER: 10,
	DIFFICULTY.INTERMEDIATE: 40,
	DIFFICULTY.ADVANCED: 99
}

var _choosen_difficulty:DIFFICULTY

func choose_difficulty(diff):
	if diff in DIFFICULTY:
		_choosen_difficulty = difficulty_mapping[diff]
	else:
		print("Difficulty not found. Please check again")

func get_choosen_difficulty() -> DIFFICULTY:
	return _choosen_difficulty

func get_size_per_difficulty() -> Vector2i:
	return board_size_per_difficulty[_choosen_difficulty]
	
func get_mines_per_difficulty() -> int:
	return mines_per_difficulty[_choosen_difficulty]
