extends Node3D

var currency := 100.0
var game_over := false

func _ready():
	$Timer.start()

func _physics_process(delta):
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
	$Level/Label3D.text = str(int(currency))

func over():
	$Level/OmniLight3D.hide()
	$Level/SpotLight3D.hide()
	$Level/SpotLight3D2.hide()
	$Level/SpotLight3D3.hide()
	$Level/SpotLight3D4.hide()
	$Level/SpotLight3D5.hide()
	$Level/OmniLight3D2.light_color = Color("ce2344")
