extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_ceiling():
		velocity -= get_gravity() * delta
	
	# Handle jump (same as upper player).
	if Input.is_action_just_pressed("ui_accept") and is_on_ceiling():
		velocity.y =velocity.y - JUMP_VELOCITY
	
	# Get the input direction but REVERSE it (mirror horizontally).
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
