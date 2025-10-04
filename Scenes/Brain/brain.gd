extends Node3D

var attention := 1.0
var generate = 10.0
var generate_value := 0
var need_reel = 0

func _ready():
	randomize()
	new_reel()

func _physics_process(_delta):
	attention -= 0.001
	attention = clamp(attention, 0.0, 1.0)
	$Label3D.text = str(int(attention*100))+"%"
	generate_value = generate * attention

func add_attention(reel):
	if need_reel == reel:
		attention += 0.01

func new_reel():
	need_reel = randi_range(0,Reels.reel_types.size()-1)
	$Label3D.modulate = Reels.reel_types[need_reel]
	$Timer.start(randf_range(1.0, 5.0))

func _on_timer_timeout():
	new_reel()
