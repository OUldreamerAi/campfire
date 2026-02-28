extends CharacterBody2D
@onready var sprite = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Inverted gravity
	if not is_on_ceiling():
		velocity -= get_gravity() * delta
	
	# Jump - synchronized, inverted direction
	if PlayerSync.should_jump and is_on_ceiling():
		velocity.y = -JUMP_VELOCITY  # Opposite direction
	
	# Movement - mirrored horizontally
	var direction = PlayerSync.input_direction  # Negate for mirror
	if direction:
		velocity.x = direction * SPEED
		sprite.play("default")
		sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.stop()
	
	move_and_slide()
