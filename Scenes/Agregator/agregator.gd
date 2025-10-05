extends Node3D

var broke := false

func _ready():
	$CPUParticles3D.emitting = false
	$Timer.start()

func _process(delta):
	pass

func fix():
	$CPUParticles3D.emitting = false
	$Timer.start()
	broke = false

func _on_timer_timeout():
	$CPUParticles3D.emitting = true
	broke = true
