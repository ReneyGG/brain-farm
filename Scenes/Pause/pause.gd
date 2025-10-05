extends CanvasLayer

var clicked := false
var last_mode

func _ready():
	hide()

func _input(event):
	if event.is_action_released("pause"):
		if visible:
			get_tree().paused = false
			hide()
		else:
			last_mode = Input.mouse_mode
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_tree().paused = true
			show()

func _on_resume_button_pressed():
	Input.set_mouse_mode(last_mode)
	#$Press.play()
	hide()
	get_tree().paused = false

func _on_menu_button_pressed():
	#$Press.play()
	hide()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menu/menu.tscn")
