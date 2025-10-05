extends Control



func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Lab/lab.tscn")

func _on_quit_pressed():
	get_tree().quit()
