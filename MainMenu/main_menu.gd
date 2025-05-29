extends Control


# These are connected through the editor and not the code
# To do it, select the appropriate signal in the "Node" page use the node after selecting the node in the scene

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://DifficultyMenu/DifficultyMenu.tscn") # Changes currently laoded scene to the one at file location


func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://OptionsMenu/OptionsMenu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
