extends AnimatedSprite2D

@export var shake_intensity: float = 4.0  # Maximum shake distance
@export var shake_duration: float = 0.5   # Duration of the shake in seconds

var shake_timer: float = 0.0
var original_position: Vector2

func _ready():
	original_position = position
	start_shake()

func start_shake():
	shake_timer = shake_duration

func _process(_delta):
		position = original_position + Vector2(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)
