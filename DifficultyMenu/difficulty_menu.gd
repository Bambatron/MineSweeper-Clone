extends Control

@onready var vbox = $MarginContainer/VBoxContainer

# On entering the active scene dinamically create a button for each difficulty and bind the correct funtion to it
func _ready() -> void:
	for d in Difficulty.DIFFICULTY:
		print(d)
		var bt:Button = Button.new() # Creates a new Button
		bt.text = d # Set text to difficulty
		bt.pressed.connect(_on_difficulty_button_pressed.bind(d)) # Binds funciton to button press passing specifical difficulty to the function
		vbox.add_child(bt) # Add Button to the vBox
	
	var back_button:Button = Button.new()
	back_button.text = "CANCEL"
	back_button.pressed.connect(_on_back_pressed)
	vbox.add_child(back_button)

func _on_difficulty_button_pressed(diff) -> void:
	Difficulty.choose_difficulty(diff)
	get_tree().change_scene_to_file("res://Board/board.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://MainMenu/MainMenu.tscn")
