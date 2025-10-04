extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$CPUParticles3D.emitting = false
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fix():
	$CPUParticles3D.emitting = false
	$Timer.start()

func _on_timer_timeout():
	pass
	#$CPUParticles3D.emitting = true
