extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity (inverted - pulls upward).
	if not is_on_ceiling():
		velocity -= get_gravity() * delta
	
	# Handle jump - only jump if THIS player is on ceiling AND upper player is on floor.
	if Input.is_action_just_pressed("ui_accept") and is_on_ceiling():
		velocity.y = -JUMP_VELOCITY
	
	# Get the input direction and REVERSE it (mirror horizontally). 
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
		sprite.play("default")
		sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
