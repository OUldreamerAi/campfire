extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0



func _process(delta: float) -> void:
	var moveDir = Input.get_axis("left","right")
	velocity.x = moveDir * SPEED
	velocity += get_gravity() * delta
	move_and_slide()
	
	#jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
