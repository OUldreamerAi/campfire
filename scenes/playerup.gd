extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -500.0
@onready var sprite = $playerupSprite

@export var playerPosition: Vector2

func _ready() -> void:
	Global.score = 0


func _process(delta: float) -> void:
	playerPosition = position
	var moveDir = Input.get_axis("left","right")
	if moveDir:
		sprite.play("default")
		sprite.flip_h = moveDir < 0
	else: sprite.stop()
	velocity.x = moveDir * SPEED
	velocity += get_gravity() * delta
	move_and_slide()

	
	#jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
