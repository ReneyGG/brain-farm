extends Node3D

var currency := 100.0
var game_over := false
var flicker := 0.0

func _ready():
	randomize()
	$Timer.start()

func _physics_process(delta):
	$Level/OmniLight3D.light_energy = lerp($Level/OmniLight3D.light_energy, flicker, 0.3)
	currency -= 0.2
	if currency <= 0.0 and not game_over:
		game_over = true
		$Player.game_over()
		over()

func _on_timer_timeout():
	if $Agregator.broke:
		currency -= 1.0
	else:
		for i in $Brains.get_children():
			currency += i.generate_value / 10.0
	currency = max(0.0, currency)
	$Level/Label3D.text = str(int(currency)) + " V"

func over():
	$AudioStreamPlayer3D.stop()
	$Level/OmniLight3D.hide()
	$Level/SpotLight3D.hide()
	$Level/SpotLight3D2.hide()
	$Level/SpotLight3D3.hide()
	$Level/SpotLight3D4.hide()
	$Level/SpotLight3D5.hide()
	$Level/OmniLight3D2.light_color = Color("ce2344")
	$OverTimer.start(5)

func _on_flicker_timer_timeout():
	flicker = randf_range(0.0, 0.2)

func _on_over_timer_timeout():
	get_tree().quit()
