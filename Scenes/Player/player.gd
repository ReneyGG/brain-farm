extends CharacterBody3D

@onready var hands = $CanvasLayer/Control/GUI/AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var speed = 5
var jump_speed = 5
var mouse_sensitivity = 0.002
var current_reel
var current_tool = "phone"
var over := false

func _ready():
	randomize()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$CanvasLayer/Control/GUI/Reels.modulate = Reels.reel_types[0]
	current_reel = 0

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))

func game_over():
	over = true
	$CanvasLayer/Control/GUI/Reels.modulate = Color("000000")

func _physics_process(delta):
	velocity.y += -gravity * delta
	var input = Input.get_vector("left", "right", "forward", "back")
	var movement_dir = transform.basis * Vector3(input.x, 0, input.y)
	#if movement_dir.length() != 0:
		#$AnimationPlayer.play("walk")
	#else:
		#$AnimationPlayer.play("idle")
	if not over:
		velocity.x = movement_dir.x * speed
		velocity.z = movement_dir.z * speed
	
	move_and_slide()
	if over:
		return
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed
	
	if Input.is_action_just_pressed("next_reel") or Input.is_action_just_pressed("show_reel"):
		if $Camera3D/UseRayCast.is_colliding():
			tool_switch()
			return
	
	if current_tool == "phone":
		if Input.is_action_pressed("next_reel"):
			#if Input.is_action_just_pressed("next_reel"):
			#	current_reel = random_reel()
			#	$CanvasLayer/Control/ColorRect.color = Reels.reel_types[current_reel]
			$CanvasLayer/AnimationPlayer.play("phone_swipe")
		elif Input.is_action_pressed("show_reel"):
			if $Camera3D/RayCast3D.is_colliding():
				if $Camera3D/RayCast3D.get_collider().is_in_group("brain"):
					$Camera3D/RayCast3D.get_collider().get_parent().add_attention(current_reel)
			hands.frame = 5
		elif not $CanvasLayer/AnimationPlayer.is_playing():
			hands.frame = 0
	
	elif current_tool == "wrench":
		if Input.is_action_pressed("next_reel"):
			hands.frame = 7
			if $Camera3D/RayCast3D.is_colliding():
				$Camera3D.apply_shake()
				$Camera3D/RayCast3D.get_collider().get_parent().fix()
		elif Input.is_action_pressed("show_reel"):
			pass
		else:
			hands.frame = 6
	
	if hands.frame == 5 or current_tool == "wrench":
		$CanvasLayer/Control/GUI/Reels.hide()
	else:
		$CanvasLayer/Control/GUI/Reels.show()

func next_reel():
	current_reel = random_reel()
	$CanvasLayer/Control/GUI/Reels.modulate = Reels.reel_types[current_reel]

func tool_switch():
	if current_tool == "phone":
		current_tool = "wrench"
	else:
		current_tool = "phone"

func random_reel():
	var next = randi_range(0,Reels.reel_types.size()-1)
	if next == current_reel:
		return random_reel()
	else:
		return next
