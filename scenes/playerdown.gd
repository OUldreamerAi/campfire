extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var playerUp: CharacterBody2D
@onready var sprite = $AnimatedSprite2D

func _ready() -> void:
	playerUp= $"../PlayerUp"
	

func _process(delta: float) -> void:
	var moveDir = Input.get_axis("left","right")
	if moveDir:
		sprite.play("default")
		sprite.flip_h = moveDir < 0
	else: sprite.stop()
	position.x = playerUp.position.x 
	position.y = -playerUp.position.y + 200
	
	

	move_and_slide()
