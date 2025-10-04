extends Node3D

var currency := 0.0


func _ready():
	$Timer.start()

func _physics_process(delta):
	pass

func _on_timer_timeout():
	for i in $Brains.get_children():
		currency += i.generate_value / 10.0
		$Level/Label3D.text = str(int(currency))
