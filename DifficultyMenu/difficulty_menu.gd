extends Control



func _on_begginer_pressed() -> void:
	Difficulty.choose_difficulty("BEGINNER")
	get_tree().change_scene_to_file("res://Board/board.tscn")

func _on_intermediate_pressed() -> void:
	Difficulty.choose_difficulty("INTERMEDIATE")
	get_tree().change_scene_to_file("res://Board/board.tscn")

func _on_advanced_pressed() -> void:
	Difficulty.choose_difficulty("ADVANCED")
	get_tree().change_scene_to_file("res://Board/board.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://MainMenu/MainMenu.tscn")
